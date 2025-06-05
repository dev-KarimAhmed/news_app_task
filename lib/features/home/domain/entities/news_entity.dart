import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable{
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? author;
  final String? url;

 const NewsEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
   required this.content,
   required this.author,
   required this.url
  });
  
  @override
  List<Object?> get props => [
    title,
    description,
    urlToImage,
    publishedAt,
  ];

}