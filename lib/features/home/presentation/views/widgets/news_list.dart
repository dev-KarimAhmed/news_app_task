import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/presentation/manger/cubit/fetch_news_cubit.dart';
import 'package:news_app/features/home/presentation/views/widgets/news_card.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.news});
  final List<NewsEntity> news;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late ScrollController _scrollController;
  int nextPage = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        log('Reached the bottom of the list');
        // We are at the bottom, so fetch more books
        if (!isLoading) {
          isLoading = true;
          log("$nextPage next page");
          context.read<FetchNewsCubit>().fetchNews(page: nextPage++);
          isLoading = false;
        }
      }
    } else {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent * 0.7) {
        log("$nextPage next page");
        log('Reached 70% of the list');
        // We have scrolled to 70% of the list
        if (!isLoading) {
          isLoading = true;
          context.read<FetchNewsCubit>().fetchNews(page: nextPage++);
          isLoading = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.news.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(),
          child: NewsCard(news: widget.news[index]),
        );
      },
    );
  }
}
