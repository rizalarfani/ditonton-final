import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../common/failure.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail({required this.repository});

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getDetailTvSeries(id);
  }
}
