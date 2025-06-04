import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/home/data/models/article_model.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Reader',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: mockArticles.length,
        itemBuilder: (context, index) {
          final article = mockArticles[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            decoration: BoxDecoration(),
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      fit: BoxFit.fill,
                      placeholder:
                          (context, url) => const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => const SizedBox(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'description of the article goes here' * 8,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Published on: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(article.publishedAt))}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Article> mockArticles = List.generate(
  10,
  (index) => Article(
    title: 'Sample News Title $index',
    urlToImage:
        'https://ichef.bbci.co.uk/ace/branded_sport/1200/cpsprodpb/6d48/live/791ff130-3195-11f0-8ca4-cf9bdd8e2b45.jpg',
    publishedAt:
        DateTime.now().subtract(Duration(days: index)).toIso8601String(),
  ),
);

