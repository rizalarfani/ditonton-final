import 'dart:convert';
import 'dart:io';

import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImplement dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImplement(client: mockHttpClient);
  });

  group('get On The Air Playing Tv Series', () {
    final list = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air_tv.json')))
        .tvSeriesList;

    test('should return list of Tv Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air_tv.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvSeries();
      // assert
      expect(result, equals(list));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final list = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvSeriesList;

    test('should return list of Tv Series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                readJson(
                  'dummy_data/popular_tv.json',
                ),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, list);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final list = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvSeriesList;

    test('should return list of Tv Series when response code is 200 ',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/top_rated_tv.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, list);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Series detail', () {
    final id = 1;
    final list = TvSeriesDetailResponse.fromJson(
      json.decode(
        readJson('dummy_data/detail_tv_series.json'),
      ),
    );

    test('should return Tv Series detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/detail_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getDetailTvSeries(id);
      // assert
      expect(result, equals(list));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetailTvSeries(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
