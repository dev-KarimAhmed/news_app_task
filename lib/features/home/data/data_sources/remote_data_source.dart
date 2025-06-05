
import 'package:news_app/core/functions/save_news.dart';
import 'package:news_app/core/services/api_services.dart';
import 'package:news_app/features/home/data/models/news_model/news_model.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

abstract class RemoteDataSource {
  Future<List<NewsEntity>> fetchNews({String? category, int? page});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  ApiServices apiServices;
  RemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<NewsEntity>> fetchNews({String? category, int? page}) async {
    List<NewsEntity> newsList = [];

    var resopnse = await apiServices.get(
      category: category,
      page: page,
    );

    for (var news in resopnse['articles']) {
      newsList.add(NewsModel.fromJson(news));
    }

    saveNews(newsList, "newsBox");
    return newsList;
  }
}
