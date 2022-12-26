part of 'tv_recomenndation_bloc.dart';

abstract class TvRecomenndationState extends Equatable {
  const TvRecomenndationState();

  @override
  List<Object> get props => [];
}

class TvRecomenndationInitial extends TvRecomenndationState {}

class TvRecomenndationEmpty extends TvRecomenndationState {}

class TvRecomenndationLoading extends TvRecomenndationState {}

class TvRecomenndationError extends TvRecomenndationState {
  final String message;

  TvRecomenndationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecomenndationHasData extends TvRecomenndationState {
  final List<TvSeries> movie;

  TvRecomenndationHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
