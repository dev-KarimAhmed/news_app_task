import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

abstract class FetchNewsRepo {
  Future<Either<Failure, List<NewsEntity>>> fetchNews({
    String endpoint,
    int pageSize,
  });
}
