import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';

/// `DiscussionDetailRoute` navigasyon parametresi — hem grup hem tartışma
/// modelini taşır, çünkü ekranda ikisinin de bilgisi (grup adı, tartışma
/// başlığı/gönderileri) gösteriliyor.
final class DiscussionDetailArgs extends Equatable {
  const DiscussionDetailArgs({required this.group, required this.discussion});

  final GroupModel group;
  final GroupDiscussionModel discussion;

  @override
  List<Object> get props => [group, discussion];
}
