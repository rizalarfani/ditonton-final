import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      () => Provider.of<WatchlistNotifier>(context, listen: false)
        ..fetchWatchlistMovies()
        ..fetchWatchlistTvSeries(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistNotifier>(context, listen: false)
      ..fetchWatchlistMovies()
      ..fetchWatchlistTvSeries();
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
                    Consumer<WatchlistNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistState == RequestState.Loaded) {
                          return data.watchlistMovies.length > 0
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    final movie = data.watchlistMovies[index];
                                    return MovieCard(movie);
                                  },
                                  itemCount: data.watchlistMovies.length,
                                )
                              : Center(
                                  child: Text('Tidak ada watchlistMovies'),
                                );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    ),
                    Consumer<WatchlistNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistTvState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistTvState ==
                            RequestState.Loaded) {
                          return data.watchListTvSeries.length > 0
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    final tvSeries =
                                        data.watchListTvSeries[index];
                                    return TvSeriesCard(tvSeries);
                                  },
                                  itemCount: data.watchListTvSeries.length,
                                )
                              : Center(
                                  child: Text('Tidak ada watchlist Tv Series'),
                                );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    tabController.dispose();
    super.dispose();
  }
}
