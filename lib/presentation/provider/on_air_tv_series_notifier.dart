import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:flutter/foundation.dart';

class OnAirTvSeriesNotifier extends ChangeNotifier {
  final GetOnAirTvSeries getOnAirTvSeries;

  OnAirTvSeriesNotifier({required this.getOnAirTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _listTvSeries = [];
  List<TvSeries> get listTvSeries => _listTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (list) {
        _listTvSeries = list;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
