import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/presentation/views/widgets/news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.news});
  final List<NewsEntity> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(),
          child: NewsCard(news: news[index]),
        );
      },
    );
  }
}

