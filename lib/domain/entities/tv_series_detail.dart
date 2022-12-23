import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final String homePage;
  final int id;
  final bool inProduction;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail(
      {this.backdropPath,
      required this.genres,
      required this.homePage,
      required this.id,
      required this.inProduction,
      required this.name,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homePage,
        id,
        inProduction,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
