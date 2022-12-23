import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvBloc(this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(SearchLoading());
        final results = await _searchTvSeries.execute(query);

        results.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasDataTv(data));
          },
        );
      },
    );
  }
}
