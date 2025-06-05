import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

void saveNews(List<NewsEntity> books, String boxName) {
  var box = Hive.box<NewsEntity>(boxName);
  box.addAll(books);
}