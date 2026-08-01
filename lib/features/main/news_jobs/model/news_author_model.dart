import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_author_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class NewsAuthorModel extends Equatable {
  const NewsAuthorModel({
    this.name = '',
    this.handle = '',
    this.avatarUrl,
    this.color,
  });

  const NewsAuthorModel.empty() : this();

  factory NewsAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$NewsAuthorModelFromJson(json);

  final String name;
  final String handle;
  final String? avatarUrl;
  final String? color;

  Map<String, dynamic> toJson() => _$NewsAuthorModelToJson(this);

  @override
  List<Object?> get props => [name, handle, avatarUrl, color];
}
