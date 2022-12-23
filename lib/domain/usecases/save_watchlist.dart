import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;
  final TvSeriesRepository tvSeriesRepository;

  SaveWatchlist(this.repository, this.tvSeriesRepository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTvSeries(
      TvSeriesDetail tvSeriesDetail) {
    return tvSeriesRepository.saveWatchlistTv(tvSeriesDetail);
  }
}
