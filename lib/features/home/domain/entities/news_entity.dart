import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'news_entity.g.dart';

@HiveType(typeId: 0)
class NewsEntity extends Equatable {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? urlToImage;
  @HiveField(3)
  final String? publishedAt;
  @HiveField(4)
  final String? content;
  @HiveField(5)
  final String? author;
  @HiveField(6)
  final String? url;

  const NewsEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.url,
  });

  @override
  List<Object?> get props => [title, description, urlToImage, publishedAt];
}
