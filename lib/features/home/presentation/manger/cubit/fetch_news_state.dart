part of 'fetch_news_cubit.dart';

sealed class FetchNewsState extends Equatable {
  const FetchNewsState();

  @override
  List<Object> get props => [];
}

final class FetchNewsInitial extends FetchNewsState {}
final class FetchNewsLoading extends FetchNewsState {}
final class FetchNewsSuccess extends FetchNewsState {
  final List<NewsEntity> newsList;

  const FetchNewsSuccess(this.newsList);

  @override
  List<Object> get props => [newsList];
}
final class FetchNewsFailure extends FetchNewsState {
  final String errorMessage;

  const FetchNewsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
