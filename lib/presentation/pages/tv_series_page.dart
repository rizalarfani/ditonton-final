import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/on_air_tv_series.dart';
import 'package:ditonton/presentation/pages/top_raled_tv_series.dart';
import 'package:ditonton/presentation/pages/popular_tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchPopularTvSeries()
        ..fetchTopRelatedTvSeries()
        ..fetchOnAirTvSeries();
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.listTvSeriesOnAirTvSeries;
                  if (data.stateOnAirTvSeries == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.stateOnAirTvSeries == RequestState.Loaded) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state[index];
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
                  } else {
                    return Center(
                      child: Text(data.message),
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.listTvSeriesPopular;
                  if (data.statePopular == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.statePopular == RequestState.Loaded) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state[index];
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
                  } else {
                    return Center(
                      child: Text(data.message),
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.listTvSeriesTopRaled;
                  if (data.stateTopRaled == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.stateTopRaled == RequestState.Loaded) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          TvSeries tvSerie = state[index];
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
                  } else {
                    return Center(
                      child: Text(data.message),
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
