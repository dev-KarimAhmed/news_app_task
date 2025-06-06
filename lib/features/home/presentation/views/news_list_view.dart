import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/dependency_injection.dart';
import 'package:news_app/features/home/presentation/manger/cubit/fetch_news_cubit.dart';
import 'package:news_app/features/home/presentation/views/widgets/news_list.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FetchNewsCubit>()..fetchNews(page: 1),
      child: BlocBuilder<FetchNewsCubit, FetchNewsState>(
        builder: (context, state) {
          final cubit = context.read<FetchNewsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News Reader',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.teal,
            ),
            body: state is FetchNewsLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.teal))
                : state is FetchNewsFailure
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                            TextButton(
                              onPressed: () => cubit.fetchNews(page: 1),
                              child: const Text('Retry', style: TextStyle(color: Colors.teal)),
                            ),
                          ],
                        ),
                      )
                    : NewsList(news: cubit.newsList),
          );
        },
      ),
    );
  }
}