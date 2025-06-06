import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

abstract class NewsLocalDataSource {
  List<NewsEntity> fetchNewsLocally({int page = 1});
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static const int pageSize = 10; // Fetch 10 items per page
  static const String boxName = 'newsBox';

  @override
  List<NewsEntity> fetchNewsLocally({int page = 1}) {
    final box = Hive.box<NewsEntity>(boxName);
    // Use 1-based indexing: page 1 starts at index 1, page 2 at 11, etc.
    final start = (page - 1) * pageSize + 1;
    final end = page * pageSize + 1;

    if (start >= box.length) {
      return [];
    }

    // Return up to pageSize items or whatever is available
    return box.values.toList().sublist(
          start,
          end > box.length ? box.length : end,
        );
  }
}