import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

abstract class NewsLocalDataSource {
  List<NewsEntity> fetchNewsLocally({int? pageSize = 10});
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  List<NewsEntity> fetchNewsLocally({int? pageSize = 10}) {
    return getDataFromHiveBox("newsBox", pageSize: pageSize!);
  }

  List<NewsEntity> getDataFromHiveBox(String boxName, {int pageSize = 10}) {
    var box = Hive.box<NewsEntity>(boxName);
    int start = pageSize;
    int end = pageSize * 2;
    if (start >= box.values.length || end > box.values.length) {
      return [];
    }
    return box.values.toList().sublist(start);
  }
}
