import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/data/repos/news_repo_impl.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

part 'fetch_news_state.dart';

class FetchNewsCubit extends Cubit<FetchNewsState> {
  FetchNewsCubit(this.newsRepoImpl) : super(FetchNewsInitial());
  NewsRepoImpl newsRepoImpl;


 List<NewsEntity> newsList = [];
  
  Future fetchNews({int pageSize = 10}) async {
  if (pageSize == 10) {
      emit(FetchNewsLoading());
    } else {
      emit(FetchNewsLoadingPagination());
    }
    var result = await newsRepoImpl.fetchNews(
      pageSize: pageSize,
    );
    result.fold(
      (failure) {
        if (pageSize == 10) {
        emit(FetchNewsFailure(failure.errMessage));
      } else {
        emit(FetchNewsFailurePagination(failure.errMessage));
      }
      },
      (newsList) {
        this.newsList = newsList;
        emit(FetchNewsSuccess());
      },
    );
  }
}
