import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/services/api_services.dart';
import 'package:news_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:news_app/features/home/data/repos/news_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  getIt.registerSingleton<NewsRepoImpl>(
    NewsRepoImpl(RemoteDataSourceImpl(getIt<ApiServices>())),
  );
}
