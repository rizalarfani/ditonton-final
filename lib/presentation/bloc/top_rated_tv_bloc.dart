import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRaledTvSeries getTopRaledTvSeries;

  TopRatedTvBloc({required this.getTopRaledTvSeries})
      : super(TopRatedTvInitial()) {
    on<GetTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final results = await getTopRaledTvSeries.execute();
      results.fold((failure) => emit(TopRatedTvError(failure.message)),
          (data) => emit(TopRatedTvHastData(data)));
    });
  }
}
