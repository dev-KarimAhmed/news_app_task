import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/widgets/custom_loading_indicator.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.news});
  final List<NewsEntity> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(),
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: news[index].urlToImage ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CustomLoadingIndicator(),
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
                        news[index].title ?? 'No Title',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        news[index].description ?? 'No Description',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Published on: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(news[index].publishedAt ?? DateTime.now().toIso8601String()))}',
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
    );
  }
}
