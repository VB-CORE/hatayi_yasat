import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

final class AdminUsersState extends Equatable {
  const AdminUsersState({
    this.users = const [],
    this.isFetching = false,
    this.isFetchingMore = false,
    this.isError = false,
    this.hasMore = true,
    this.processingUids = const {},
    this.actionMessageKey,
  });

  final List<AppUser> users;
  final bool isFetching;
  final bool isFetchingMore;
  final bool isError;
  final bool hasMore;
  final Set<String> processingUids;
  final String? actionMessageKey;

  AdminUsersState copyWith({
    List<AppUser>? users,
    bool? isFetching,
    bool? isFetchingMore,
    bool? isError,
    bool? hasMore,
    Set<String>? processingUids,
    String? actionMessageKey,
    bool clearActionMessage = false,
  }) => AdminUsersState(
    users: users ?? this.users,
    isFetching: isFetching ?? this.isFetching,
    isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    isError: isError ?? this.isError,
    hasMore: hasMore ?? this.hasMore,
    processingUids: processingUids ?? this.processingUids,
    actionMessageKey: clearActionMessage
        ? null
        : (actionMessageKey ?? this.actionMessageKey),
  );

  @override
  List<Object?> get props => [
    users,
    isFetching,
    isFetchingMore,
    isError,
    hasMore,
    processingUids,
    actionMessageKey,
  ];
}
