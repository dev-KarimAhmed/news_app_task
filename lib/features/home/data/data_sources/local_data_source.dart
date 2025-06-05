import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

abstract class NewsLocalDataSource {
  List<NewsEntity> fetchNewsLocally({int? page = 1});
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  List<NewsEntity> fetchNewsLocally({int? page = 1}) {
    return getDataFromHiveBox("newsBox", page: page!);
  }

  List<NewsEntity> getDataFromHiveBox(String boxName, {int page = 1}) {
    var box = Hive.box<NewsEntity>(boxName);
    int start = page;
    int end = (page + 1) * 20; // Assuming each page has 20 items
    if (start >= box.values.length || end > box.values.length) {
      return [];
    }
    return box.values.toList().sublist(start);
  }
}
