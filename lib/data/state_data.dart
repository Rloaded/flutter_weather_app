import 'package:json_annotation/json_annotation.dart';

part 'state_data.g.dart';

/// StateData enthält:
/// [currentDay]: den index des aktuellen Tages
/// [weatherData]: Liste aller Wetterdaten
/// [location]: der Stadtname der aktuellen Position
/// [dataFine]: gibt an ob der DatenStand akurat ist (zeigt ein Icon an)
@JsonSerializable()
class StateData {
  final int currentDay;
  final List<WeatherInfo> weatherData;
  final String location;
  final bool dataFine;

  StateData({
    this.weatherData,
    this.currentDay,
    this.location,
    this.dataFine,
  });

  factory StateData.initial() => StateData(
        currentDay: 0,
        weatherData: List.filled(5, WeatherInfo.initial()),
        location: "MockValues",
        dataFine: false,
      );

  StateData copyWith({
    int currentDay,
    List<WeatherInfo> weatherData,
    String location,
    bool dataFine,
  }) {
    return StateData(
      currentDay: currentDay ?? this.currentDay,
      weatherData: weatherData ?? this.weatherData,
      location: location ?? this.location,
      dataFine: dataFine ?? this.dataFine,
    );
  }

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);
  Map<String, dynamic> toJson() => _$StateDataToJson(this);
}

/// Enthält alle Daten für den entsprechenden Tag.
@JsonSerializable()
class WeatherInfo {
  final String imagePath;
  final int avgTemp;
  final int minTemp;
  final int maxTemp;
  final int windSpeed;
  final int humidity;
  final int pressure;
  final String dayName;
  final DateTime date;
  final String description;

  WeatherInfo({
    this.imagePath,
    this.avgTemp,
    this.minTemp,
    this.maxTemp,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.dayName,
    this.date,
    this.description,
  });

  factory WeatherInfo.initial() {
    return WeatherInfo(
      avgTemp: 20,
      date: DateTime(2021, 5, 2),
      dayName: "Mocked",
      description: "Look Outside",
      humidity: 420,
      imagePath: "assets/sunny.png",
      maxTemp: 25,
      minTemp: 19,
      pressure: 1069,
      windSpeed: 3,
    );
  }

  WeatherInfo copyWith({
    String imagePath,
    int avgTemp,
    int minTemp,
    int maxTemp,
    int windSpeed,
    int humidity,
    int pressure,
    String dayName,
    DateTime date,
    String descritpion,
  }) {
    return WeatherInfo(
      imagePath: imagePath ?? this.imagePath,
      avgTemp: avgTemp ?? this.avgTemp,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
      dayName: dayName ?? this.dayName,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}
