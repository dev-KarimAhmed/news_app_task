import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/home/data/data_sources/local_data_source.dart';
import 'package:news_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/domain/repos/fetch_news_repo.dart';

class NewsRepoImpl implements FetchNewsRepo {
  RemoteDataSource remoteDataSource;
  NewsLocalDataSource localDataSource;
  NewsRepoImpl(this.remoteDataSource , this.localDataSource);
  @override
  Future<Either<Failure, List<NewsEntity>>> fetchNews({
    String? category,
    int? page,
  }) async {
    try {
      List<NewsEntity> newsList = [];
       newsList = localDataSource.fetchNewsLocally(pageSize: page);
        
        if (newsList.isNotEmpty) {
          log("Fetched news from local data source");
          return Right(newsList);
          
        }
      newsList = await remoteDataSource.fetchNews(
        category: category,
        page: page,
      );

      
      return Right(newsList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError.fromDioError(e));
      }
      return Left(ServerError(e.toString()));
    }
  }
}
