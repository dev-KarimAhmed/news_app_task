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
  int nextPage = 2; // Start at 2 since page 1 is loaded initially
  bool isLoading = false;
  bool hasReachedEnd = false;

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
    if (isLoading || hasReachedEnd) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent * 0.8) {
      log('Fetching page $nextPage (80% scroll reached)');
      setState(() {
        isLoading = true;
      });
      context.read<FetchNewsCubit>().fetchNews(page: nextPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchNewsCubit, FetchNewsState>(
      listener: (context, state) {
        if (state is FetchNewsLoadingPagination) {
          setState(() {
            isLoading = true;
          });
        } else if (state is FetchNewsSuccessPagination) {
          setState(() {
            isLoading = false;
            if (context.read<FetchNewsCubit>().newsList.length == widget.news.length) {
              hasReachedEnd = true; // No new data added
            } else {
              nextPage++; // Increment only on success
            }
          });
        } else if (state is FetchNewsFailurePagination) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load more news: ${state.errorMessage}'),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  context.read<FetchNewsCubit>().fetchNews(page: nextPage);
                },
              ),
            ),
          );
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.news.length + (isLoading || hasReachedEnd ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < widget.news.length) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: NewsCard(news: widget.news[index]),
            );
          } else if (isLoading) {
            return Padding(
              padding: EdgeInsets.all(16.0.h),
              child: const Center(child: CircularProgressIndicator(color: Colors.teal)),
            );
          } else if (hasReachedEnd) {
            return Padding(
              padding: EdgeInsets.all(16.0.h),
              child: const Center(child: Text('No more news to load')),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}