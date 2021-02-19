part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {}

/// Event wenn die Daten refreshed werden sollen.
class RefreshData extends WeatherEvent {
  @override
  List<Object> get props => [];
}

/// Event um den den aktuell angezeigten Tag zu ändern,
/// wobei [newCurrentDay] der entsprechende Tag ist.
class ChangeDay extends WeatherEvent {
  final int newCurrentDay;

  ChangeDay({this.newCurrentDay});
  
  @override
  List<Object> get props => [];
}
