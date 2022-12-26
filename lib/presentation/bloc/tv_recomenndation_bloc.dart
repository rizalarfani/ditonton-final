import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'tv_recomenndation_event.dart';
part 'tv_recomenndation_state.dart';

class TvRecomenndationBloc
    extends Bloc<TvRecomenndationEvent, TvRecomenndationState> {
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  TvRecomenndationBloc({required this.getTvSeriesRecommendation})
      : super(TvRecomenndationInitial()) {
    on<GetTvRecomenndation>((event, emit) async {
      emit(TvRecomenndationLoading());
      final results = await getTvSeriesRecommendation.execute(event.id);

      results.fold((failure) {
        emit(TvRecomenndationError(failure.message));
      }, (data) {
        emit(TvRecomenndationHasData(data));
      });
    });
  }
}
