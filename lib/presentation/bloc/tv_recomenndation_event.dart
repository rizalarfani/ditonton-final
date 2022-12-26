part of 'tv_recomenndation_bloc.dart';

abstract class TvRecomenndationEvent extends Equatable {
  const TvRecomenndationEvent();

  @override
  List<Object> get props => [];
}

class GetTvRecomenndation extends TvRecomenndationEvent {
  final int id;
  GetTvRecomenndation(this.id);

  @override
  List<Object> get props => [id];
}
