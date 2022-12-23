import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../common/failure.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
