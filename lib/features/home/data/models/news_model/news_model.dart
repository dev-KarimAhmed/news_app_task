
import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

import 'source.dart';

class NewsModel extends NewsEntity {
  final Source? source;
  final String? author;
  @override
  final String? title;
  @override
  final String? description;
  final String? url;
  @override
  final String? urlToImage;
  @override
  final String? publishedAt;
  final String? content;

  const NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  }) : super(
          title: title,
          description: description,
          urlToImage: urlToImage ,
          publishedAt: publishedAt,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    source:
        json['source'] == null
            ? null
            : Source.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    urlToImage: json['urlToImage'] as String?,
    publishedAt: json['publishedAt'] as String?,
    content: json['content'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt,
    'content': content,
  };

  @override
  List<Object?> get props {
    return [
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
