import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final List<dynamic> genreIds;
  final String name;

  TvSeriesModel({
    this.posterPath,
    required this.popularity,
    required this.id,
    this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.genreIds,
    required this.name,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        posterPath: json['poster_path'],
        popularity: json['popularity'].toDouble(),
        id: json['id'],
        backdropPath: json['backdrop_path'],
        voteAverage: json['vote_average'].toDouble(),
        overview: json['overview'],
        genreIds: json['genre_ids'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'poster_path': posterPath,
        'popularity': popularity,
        'id': id,
        'backdrop_path': backdropPath,
        'vote_average': voteAverage,
        'overview': overview,
        'genre_ids': List<dynamic>.from(genreIds.map((e) => e)),
        'name': name,
      };

  TvSeries toEntity() {
    return TvSeries(
      posterPath: posterPath,
      popularity: popularity,
      id: id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      genreIds: genreIds,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        genreIds,
        name,
      ];
}
