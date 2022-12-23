import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;
  final TvSeriesRepository tvSeriesRepository;

  RemoveWatchlist(
      {required this.movieRepository, required this.tvSeriesRepository});

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTvSeries(
      TvSeriesDetail tvSeriesDetail) {
    return tvSeriesRepository.removeWatchlist(tvSeriesDetail);
  }
}
