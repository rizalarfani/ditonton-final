import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class TvSeriesDetailResponse extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
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

  TvSeriesDetailResponse(
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

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homePage: json['homepage'],
        id: json['id'],
        inProduction: json['in_production'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        "genres": List<GenreModel>.from(genres.map((x) => x.toJson())),
        'homepage': homePage,
        'id': id,
        'in_production': inProduction,
        'name': name,
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'posterPath': posterPath,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        genres: this.genres.map((e) => e.toEntity()).toList(),
        homePage: this.homePage,
        id: this.id,
        inProduction: this.inProduction,
        name: this.name,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

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
