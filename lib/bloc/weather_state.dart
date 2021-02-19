part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  final StateData data;

  WeatherState({@required this.data});
}

/// Intialzustand der App
class WeatherInitial extends WeatherState {
  final StateData data = StateData.initial();

  @override
  List<Object> get props => [data];
}

/// Zustand der App wenn gerade Daten vom Backend abruft.
class DataLoading extends WeatherState {
  final StateData data;

  DataLoading({@required this.data});

  @override
  List<Object> get props => [data];
}

/// Zustand der App wenn alle Daten erfolgreich abgerufen wurden.
class DataLoaded extends WeatherState {
  final StateData data;

  DataLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

/// Zustand der App wenn bei der Datenübergabe etwas schieflief.
/// [message] enthält den Text für den BackendCall.
class DataLoadingFailed extends WeatherState {
  final StateData data;
  final String message;

  DataLoadingFailed({
    @required this.data,
    @required this.message,
  });

  @override
  List<Object> get props => [data];
}

/// Zustand der App wenn der Tag geändert wurde.
class DayChanged extends WeatherState {
  final StateData data;

  DayChanged({@required this.data});

  @override
  List<Object> get props => [data];
}
