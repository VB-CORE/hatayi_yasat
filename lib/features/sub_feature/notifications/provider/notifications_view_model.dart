import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/history/widget/history_photo_detail_sheet.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notifications_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/snackbar/error_snack_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
final class NotificationsViewModel extends _$NotificationsViewModel
    with ProjectDependencyMixin {
  Query<AppNotificationModel?> get _notificationsQuery =>
      firestoreService.collectionReference(
        CollectionPaths.notifications,
        AppNotificationModel(),
      );

  @override
  NotificationsState build() => const NotificationsState();

  Stream<List<AppNotificationModel>> unreadStream() =>
      _notificationsQuery.snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => document.data())
            .whereType<AppNotificationModel>()
            .where(
              (item) =>
                  !item.read && !state.locallyReadIds.contains(item.documentId),
            )
            .toList(),
      );

  Future<void> markAsRead(AppNotificationModel item) async {
    if (item.read || state.locallyReadIds.contains(item.documentId)) {
      return;
    }
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, item.documentId},
    );

    final result = await firestoreService.updateFields(
      path: CollectionPaths.notifications,
      documentId: item.documentId,
      fields: const {'read': true},
    );

    if (!result.isSuccess) {
      state = state.copyWith(
        locallyReadIds: state.locallyReadIds
            .where((id) => id != item.documentId)
            .toSet(),
      );
    }
  }

  Future<void> markAllAsRead(List<AppNotificationModel> unreadItems) async {
    if (unreadItems.isEmpty || state.isMarkingAllRead) return;
    final ids = unreadItems.map((item) => item.documentId).toSet();
    state = state.copyWith(
      locallyReadIds: {...state.locallyReadIds, ...ids},
      isMarkingAllRead: true,
    );

    final result = await firestoreService.batchWrite((batch) {
      for (final item in unreadItems) {
        batch.update(
          CollectionPaths.notifications.collection.doc(item.documentId),
          const {'read': true},
        );
      }
    });

    state = state.copyWith(
      isMarkingAllRead: false,
      locallyReadIds: result.isSuccess
          ? state.locallyReadIds
          : state.locallyReadIds.difference(ids),
    );
  }

  Future<void> openNotification(
    BuildContext context,
    AppNotificationModel item,
  ) async {
    unawaited(markAsRead(item));
    final targetId = item.targetId;
    if (targetId == null || targetId.isEmpty) return;

    switch (item.type) {
      case AppNotificationType.place:
        await _openPlace(context, targetId);
      case AppNotificationType.event:
        await _openEvent(context, targetId);
      case AppNotificationType.memory:
        await _openMemory(context, targetId);
      case AppNotificationType.system || null:
        return;
    }
  }

  Future<void> _openPlace(BuildContext context, String targetId) async {
    await PlaceDetailRoute(
      $extra: StoreModel.empty(),
      id: targetId,
    ).push<void>(context);
  }

  Future<void> _openEvent(BuildContext context, String targetId) async {
    final result = await firestoreService.getSingleData(
      model: CampaignModel(),
      path: CollectionPaths.approvedCampaigns,
      id: targetId,
    );
    if (!context.mounted) return;
    switch (result) {
      case FirebaseSuccess(:final data) when data != null:
        await EventDetailsRoute($extra: data).push<void>(context);
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(
            message: LocaleKeys.notification_campaignNotFoundErrorMessage.tr(),
          ),
        );
    }
  }

  Future<void> _openMemory(BuildContext context, String targetId) async {
    final result = await firestoreService.getSingleData(
      model: const MemoryModel(),
      path: CollectionPaths.memories,
      id: targetId,
    );
    if (!context.mounted) return;
    switch (result) {
      case FirebaseSuccess(:final data) when data != null:
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => HistoryPhotoDetailSheet(memory: data),
        );
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(
            message: LocaleKeys.notification_memoryNotFoundErrorMessage.tr(),
          ),
        );
    }
  }
}
