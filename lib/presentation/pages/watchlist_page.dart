import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    Future.microtask(
      () {
        context.read<WatchlistMovieBloc>().add(GetWatchlistMovie());
        context.read<WatchlistTvBloc>().add(GetWatchlistTv());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMovie());
    context.read<WatchlistTvBloc>().add(GetWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: kDavysGrey),
              ),
              child: TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kDavysGrey,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Text(
                    'Movie',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Tv Series',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                    builder: (context, state) {
                      if (state is WatchlistMovieInitial ||
                          state is WatchlistMovieLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WatchlistMovieHasData) {
                        return state.movie.length > 0
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final movie = state.movie[index];
                                  return MovieCard(movie);
                                },
                                itemCount: state.movie.length,
                              )
                            : Center(
                                child: Text('Tidak ada watchlistMovies'),
                              );
                      } else if (state is WatchlistMovieError) {
                        return Center(
                          key: Key('error_message'),
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                    builder: (context, state) {
                      if (state is WatchlistTvInitial ||
                          state is WatchlistTvLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WatchlistTvHasData) {
                        return state.tv.length > 0
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final tv = state.tv[index];
                                  return TvSeriesCard(tv);
                                },
                                itemCount: state.tv.length,
                              )
                            : Center(
                                child: Text('Tidak ada watchlistMovies'),
                              );
                      } else if (state is WatchlistTvError) {
                        return Center(
                          key: Key('error_message'),
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    tabController.dispose();
    super.dispose();
  }
}
