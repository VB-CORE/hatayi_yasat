import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_author_model.dart';

part 'news_feed_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class NewsFeedModel extends BaseFirebaseModel<NewsFeedModel>
    with EquatableMixin {
  const NewsFeedModel({
    this.id = '',
    this.title,
    this.body,
    this.photoUrl,
    this.type,
    this.author,
    this.date,
  });

  const NewsFeedModel.empty() : this();

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;

  final String? title;

  @JsonKey(name: 'content')
  final String? body;

  @JsonKey(name: 'image')
  final String? photoUrl;

  final String? type;

  final NewsAuthorModel? author;

  @JsonKey(
    name: 'createdAt',
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? date;

  @override
  String get documentId => id;

  @override
  Map<String, dynamic> toJson() => _$NewsFeedModelToJson(this);

  @override
  NewsFeedModel fromJson(Map<String, dynamic> json) =>
      _$NewsFeedModelFromJson(json);

  @override
  NewsFeedModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const NewsFeedModel.empty();
    return fromJson(data).copyWith(id: snapshot.id);
  }

  @override
  List<Object?> get props => [id, title, body, photoUrl, type, author, date];

  NewsFeedModel copyWith({
    String? id,
    String? title,
    String? body,
    String? photoUrl,
    String? type,
    NewsAuthorModel? author,
    DateTime? date,
  }) {
    return NewsFeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      photoUrl: photoUrl ?? this.photoUrl,
      type: type ?? this.type,
      author: author ?? this.author,
      date: date ?? this.date,
    );
  }
}
