import 'package:ditonton/common/ssl.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recomenndation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/repositories/tv_series_repository_implement.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => BottomNavigationBloc(),
  );

  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingMovieBloc(
      getNowPlayingMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieBloc(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );

  locator.registerFactory(
    () => MoviesRecomendationBloc(
      getMovieRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  //  Tv Series Bloc
  locator.registerFactory(
    () => OnAirTvBloc(
      getOnAirTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      getPopularTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      getTopRaledTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      getTvSeriesDetail: locator(),
    ),
  );

  locator.registerFactory(
    () => TvRecomenndationBloc(
      getTvSeriesRecommendation: locator(),
    ),
  );

  locator.registerFactory(
    () => TvWatchlistBloc(
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchlistTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(
        movieRepository: locator(),
        tvSeriesRepository: locator(),
      ));
  locator.registerLazySingleton(() => SaveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(
        movieRepository: locator(),
        tvSeriesRepository: locator(),
      ));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator
      .registerLazySingleton(() => GetPopularTvSeries(repository: locator()));
  locator
      .registerLazySingleton(() => GetTopRaledTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetOnAirTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(repository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesRecommendation(repository: locator()));
  locator.registerLazySingleton(() => SearchTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImplement(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      ssl: locator(),
    ),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImplement(
      ssl: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Ssl());
}
