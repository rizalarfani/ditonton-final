import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/onair-tv';

  @override
  _OnAirTvSeriestate createState() => _OnAirTvSeriestate();
}

class _OnAirTvSeriestate extends State<OnAirTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<OnAirTvBloc>().add(GetOnAirTv()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading || state is OnAirTvInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvHastData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.results[index];
                  return TvSeriesCard(tvseries);
                },
                itemCount: state.results.length,
              );
            } else if (state is OnAirTvError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
