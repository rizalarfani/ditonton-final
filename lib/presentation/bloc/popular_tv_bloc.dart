import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvBloc({required this.getPopularTvSeries})
      : super(PopularTvInitial()) {
    on<GetPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final results = await getPopularTvSeries.execute();
      results.fold((failure) => emit(PopularTvError(failure.message)),
          (data) => emit(PopularTvHastData(data)));
    });
  }
}
