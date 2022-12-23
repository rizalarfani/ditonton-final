import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchListStatus {
  final MovieRepository movieRepository;
  final TvSeriesRepository tvSeriesRepository;

  GetWatchListStatus(
      {required this.movieRepository, required this.tvSeriesRepository});

  Future<bool> execute(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }

  Future<bool> executeTvSeries(int id) async {
    return tvSeriesRepository.isAddedToWatchlistTv(id);
  }
}
