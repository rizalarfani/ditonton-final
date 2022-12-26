import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tvSeriesModel = TvSeriesModel(
    backdropPath: '/o8zk3QmHYMSC7UiJgFk81OFF1sc.jpg',
    genreIds: [10766, 18],
    id: 204095,
    name: 'Mar do Sertão',
    overview: '',
    popularity: 1444.766,
    posterPath: '/ixgnqO8xhFMb1zr8RRFsyeZ9CdD.jpg',
    voteAverage: 4.3,
  );

  final tvSeriesResponse =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air_tv.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tvSeriesResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'genre_ids': [10766, 18],
            'id': 204095,
            'name': 'Mar do Sertão',
            'overview': '',
            'popularity': 1444.766,
            'poster_path': '/ixgnqO8xhFMb1zr8RRFsyeZ9CdD.jpg',
            'vote_average': 4.3,
            'backdrop_path': '/o8zk3QmHYMSC7UiJgFk81OFF1sc.jpg',
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
