import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TopRaledTvSeriesNotifier extends ChangeNotifier {
  final GetTopRaledTvSeries getTopRaledTvSeries;

  TopRaledTvSeriesNotifier({required this.getTopRaledTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _listTvSeries = [];
  List<TvSeries> get listTvSeries => _listTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRelatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final results = await getTopRaledTvSeries.execute();
    results.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesdata) {
      _state = RequestState.Loaded;
      _listTvSeries = tvSeriesdata;
      notifyListeners();
    });
  }
}
