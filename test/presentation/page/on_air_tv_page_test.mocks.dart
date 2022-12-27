// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/page/on_air_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart' as _i2;
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetOnAirTvSeries_0 extends _i1.SmartFake
    implements _i2.GetOnAirTvSeries {
  _FakeGetOnAirTvSeries_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeOnAirTvState_1 extends _i1.SmartFake implements _i3.OnAirTvState {
  _FakeOnAirTvState_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [OnAirTvBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockOnAirTvBloc extends _i1.Mock implements _i3.OnAirTvBloc {
  MockOnAirTvBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetOnAirTvSeries get getOnAirTvSeries => (super.noSuchMethod(
      Invocation.getter(#getOnAirTvSeries),
      returnValue: _FakeGetOnAirTvSeries_0(
          this, Invocation.getter(#getOnAirTvSeries))) as _i2.GetOnAirTvSeries);
  @override
  _i3.OnAirTvState get state => (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeOnAirTvState_1(this, Invocation.getter(#state)))
      as _i3.OnAirTvState);
  @override
  _i4.Stream<_i3.OnAirTvState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: _i4.Stream<_i3.OnAirTvState>.empty())
          as _i4.Stream<_i3.OnAirTvState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.OnAirTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.OnAirTvEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.OnAirTvState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.OnAirTvEvent>(
          _i5.EventHandler<E, _i3.OnAirTvState>? handler,
          {_i5.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i5.Transition<_i3.OnAirTvEvent, _i3.OnAirTvState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i5.Change<_i3.OnAirTvState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
