import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTopRaledTvSeries {
  final TvSeriesRepository repository;

  GetTopRaledTvSeries({required this.repository});

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRetedTvSeries();
  }
}
