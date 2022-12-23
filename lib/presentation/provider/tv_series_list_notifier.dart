import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRaledTvSeries getTopRaledTvSeries;
  final GetOnAirTvSeries getOnAirTvSeries;

  TvSeriesListNotifier({
    required this.getPopularTvSeries,
    required this.getTopRaledTvSeries,
    required this.getOnAirTvSeries,
  });

  RequestState _statePopular = RequestState.Empty;
  RequestState get statePopular => _statePopular;

  List<TvSeries> _listTvSeriesPopular = [];
  List<TvSeries> get listTvSeriesPopular => _listTvSeriesPopular;

  RequestState _stateTopRaled = RequestState.Empty;
  RequestState get stateTopRaled => _stateTopRaled;

  List<TvSeries> _listTvSeriesTopRaled = [];
  List<TvSeries> get listTvSeriesTopRaled => _listTvSeriesTopRaled;

  RequestState _stateOnAirTvSeries = RequestState.Empty;
  RequestState get stateOnAirTvSeries => _stateOnAirTvSeries;

  List<TvSeries> _listTvSeriesOnAirTvSeries = [];
  List<TvSeries> get listTvSeriesOnAirTvSeries => _listTvSeriesOnAirTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _statePopular = RequestState.Loading;
    notifyListeners();

    final results = await getPopularTvSeries.execute();
    results.fold((failure) {
      _statePopular = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesdata) {
      _statePopular = RequestState.Loaded;
      _listTvSeriesPopular = tvSeriesdata;
      notifyListeners();
    });
  }

  Future<void> fetchTopRelatedTvSeries() async {
    _stateTopRaled = RequestState.Loading;
    notifyListeners();

    final results = await getTopRaledTvSeries.execute();
    results.fold((failure) {
      _stateTopRaled = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesdata) {
      _stateTopRaled = RequestState.Loaded;
      _listTvSeriesTopRaled = tvSeriesdata;
      notifyListeners();
    });
  }

  Future<void> fetchOnAirTvSeries() async {
    _stateOnAirTvSeries = RequestState.Loading;
    notifyListeners();

    final results = await getOnAirTvSeries.execute();
    results.fold((failure) {
      _stateOnAirTvSeries = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesdata) {
      _stateOnAirTvSeries = RequestState.Loaded;
      _listTvSeriesOnAirTvSeries = tvSeriesdata;
      notifyListeners();
    });
  }
}
