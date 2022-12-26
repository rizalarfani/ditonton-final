import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_on_air_tv_series.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTvSeries getOnAirTvSeries;

  OnAirTvBloc({required this.getOnAirTvSeries}) : super(OnAirTvInitial()) {
    on<GetOnAirTv>((event, emit) async {
      emit(OnAirTvLoading());

      final results = await getOnAirTvSeries.execute();
      results.fold((failure) => emit(OnAirTvError(failure.message)),
          (data) => emit(OnAirTvHastData(data)));
    });
  }
}
