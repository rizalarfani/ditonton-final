import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_raled_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRaledTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/topraled-tv';

  @override
  _TopRaledTvSeriestate createState() => _TopRaledTvSeriestate();
}

class _TopRaledTvSeriestate extends State<TopRaledTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TopRaledTvSeriesNotifier>(context, listen: false)
          .fetchTopRelatedTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Raled Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRaledTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = data.listTvSeries[index];
                  return TvSeriesCard(tvseries);
                },
                itemCount: data.listTvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
