import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/data/repos/news_repo_impl.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';

part 'fetch_news_state.dart';

class FetchNewsCubit extends Cubit<FetchNewsState> {
  FetchNewsCubit(this.newsRepoImpl) : super(FetchNewsInitial());
  NewsRepoImpl newsRepoImpl;

  
  Future fetchNews() async {
    emit(FetchNewsLoading());
    var result = await newsRepoImpl.fetchNews();
    result.fold(
      (failure) {
        emit(FetchNewsFailure(failure.errMessage));
      },
      (newsList) {
        emit(FetchNewsSuccess(newsList));
      },
    );
  }
}
