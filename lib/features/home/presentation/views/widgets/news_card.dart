import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/widgets/custom_loading_indicator.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/presentation/views/article_details.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});

  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ArticleDetailsView(
                    articleUrl: news.url ?? '',
                    articleTitle: news.title,
                  ),
            ),
          ),
      child: SizedBox(
        height: 125.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage ?? '',
                    fit: BoxFit.cover,
                    height: 125.h,
                    placeholder: (context, url) => CustomLoadingIndicator(),
                    errorWidget:
                        (context, url, error) => const SizedBox(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title ?? 'No Title',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      news.description ?? 'No Description',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Published on: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(news.publishedAt ?? DateTime.now().toIso8601String()))}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
