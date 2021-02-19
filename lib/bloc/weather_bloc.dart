import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_example/bloc/weather_bloc_repository.dart';
import 'package:weather_app_example/data/state_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherBlocRepository repo = WeatherBlocRepository();

  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is RefreshData) {
      yield DataLoading(
        data: state.data,
      );
      try {
        final data = await repo.getWeatherData();
        yield DataLoaded(
          data: data,
        );
      } catch (e) {
        yield DataLoadingFailed(
          data: state.data.copyWith(
            dataFine: false,
          ),
          message: e,
        );
      }
    } else if (event is ChangeDay) {
      yield DayChanged(
        data: state.data.copyWith(
          currentDay: event.newCurrentDay,
        ),
      );
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    try {
      final data = StateData.fromJson(json);
      return DataLoaded(data: data);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    return state.data.toJson();
  }
}
