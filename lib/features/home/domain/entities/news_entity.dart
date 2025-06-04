import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable{
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;

 const NewsEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
  });
  
  @override
  List<Object?> get props => [
    title,
    description,
    urlToImage,
    publishedAt,
  ];

}