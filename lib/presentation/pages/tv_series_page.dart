import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/on_air_tv_series.dart';
import 'package:ditonton/presentation/pages/top_raled_tv_series.dart';
import 'package:ditonton/presentation/pages/popular_tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';
import '../widgets/sub_heading.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAirTvBloc>().add(GetOnAirTv());
      context.read<PopularTvBloc>().add(GetPopularTv());
      context.read<TopRatedTvBloc>().add(GetTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'On Air Tv Series',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OnAirTvSeries.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<OnAirTvBloc, OnAirTvState>(
                builder: (context, state) {
                  if (state is OnAirTvLoading || state is OnAirTvInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnAirTvHastData) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state.results[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  TvSeriesDetailPage.ROUTE_NAME,
                                  arguments: tvSerie.id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$BASE_IMAGE_URL${tvSerie.posterPath}',
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is OnAirTvError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvSeries.ROUTE_NAME,
                ),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
                  if (state is PopularTvInitial || state is PopularTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvHastData) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state.results[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  TvSeriesDetailPage.ROUTE_NAME,
                                  arguments: tvSerie.id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$BASE_IMAGE_URL${tvSerie.posterPath}',
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is PopularTvError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRaledTvSeries.ROUTE_NAME,
                ),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvInitial ||
                      state is TopRatedTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvHastData) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state.results[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  TvSeriesDetailPage.ROUTE_NAME,
                                  arguments: tvSerie.id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$BASE_IMAGE_URL${tvSerie.posterPath}',
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is TopRatedTvError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
