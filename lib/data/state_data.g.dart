// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateData _$StateDataFromJson(Map<String, dynamic> json) {
  return StateData(
    weatherData: (json['weatherData'] as List)
        ?.map((e) =>
            e == null ? null : WeatherInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentDay: json['currentDay'] as int,
    location: json['location'] as String,
    dataFine: json['dataFine'] as bool,
  );
}

Map<String, dynamic> _$StateDataToJson(StateData instance) => <String, dynamic>{
      'currentDay': instance.currentDay,
      'weatherData': instance.weatherData,
      'location': instance.location,
      'dataFine': instance.dataFine,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) {
  return WeatherInfo(
    imagePath: json['imagePath'] as String,
    avgTemp: json['avgTemp'] as int,
    minTemp: json['minTemp'] as int,
    maxTemp: json['maxTemp'] as int,
    windSpeed: json['windSpeed'] as int,
    humidity: json['humidity'] as int,
    pressure: json['pressure'] as int,
    dayName: json['dayName'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'avgTemp': instance.avgTemp,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'dayName': instance.dayName,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
    };
