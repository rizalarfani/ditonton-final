import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

import '../../common/exception.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeriesTable);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable);
}

class TvSeriesLocalDataSourceImpl extends TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeriesTable);
      return 'Added to Watchlist Tv Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.removeWatchlist(tvSeriesTable.id);
      return 'Removed from Watchlist Tv Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
