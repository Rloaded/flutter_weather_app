import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app_example/data/state_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_example/handler/location_handler.dart';

class WeatherBlocRepository {
  //TODO: APIKey ersetzen
  final String apiKey = "";

  /// Erstellt die URI an die der Backend-Call gerichtet werden soll.
  String _createAPICall(Position position) {
    return "https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=current,minutely,hourly,alerts&appid=${apiKey}&units=metric&lang=de";
  }

  /// Ruft die Daten von der WetterAPI ab und returned den entsprechenden StateData-Datensatz.
  Future<StateData> getWeatherData() async {
    if (await LocationHandler.hasPermission()) {
      final position = await LocationHandler.getPosition();
      var response;
      try {
        response = await http.get(_createAPICall(position));
      } catch (e) {
        return Future.error("Überprüfe deine Internetverbindung!"); //InternetProbleme
      }
      if (response.statusCode == 200) {
        try {
          final Map json = jsonDecode(response.body);
          final List daily = json["daily"] as List;
          final weatherData = List<WeatherInfo>();
          daily.forEach((element) {
            weatherData.add(_extractWeatherData(element));
          });
          return StateData(
            currentDay: 0,
            weatherData: weatherData,
            location: await LocationHandler.getCityName(position),
            dataFine: true,
          );
        } catch (e) {
          return Future.error("Probleme bei der Antwort!"); //Probleme mit dem Übersetzen
        }
      } else {
        return Future.error("Probleme bei der Antwort!"); // Problem bei der Antowort
      }
    } else {
      return Future.error("Problem beim Abrufen des Standorts!"); // Problem bei der Standortabfrage
    }
  }

  WeatherInfo _extractWeatherData(Map map) {
    final temp = map["temp"] as Map;
    final date = _getDateTime(map["dt"] as int);
    final weather = (map["weather"] as List).first as Map;
    return WeatherInfo(
      avgTemp: temp["day"].round(),
      date: date,
      dayName: _getWeekday(date),
      humidity: map["humidity"] as int,
      imagePath: _getImageAddress(weather["main"] as String),
      maxTemp: temp["max"].round(),
      minTemp: temp["min"].round(),
      pressure: map["pressure"].round(),
      windSpeed: (map["wind_speed"] as double).round(),
      description: weather["description"] as String,
    );
  }

  DateTime _getDateTime(int date) {
    return DateTime.fromMillisecondsSinceEpoch(date * 1000);
  }

  /// Ordnet jedem Datum einen Wochentag bzw. "Heute" oder "Morgen" zu.
  String _getWeekday(DateTime date) {
    final difference = _calculateDifference(date);

    if (difference == 0)
      return "Heute";
    else if (difference == 1) return "Morgen";

    final day = date.weekday;
    switch (day) {
      case 1:
        return "Montag";
      case 2:
        return "Dienstag";
      case 3:
        return "Mittwoch";
      case 4:
        return "Donnerstag";
      case 5:
        return "Freitag";
      case 6:
        return "Samstag";
      case 7:
        return "Sonntag";
      default:
        return "N/A";
    }
  }

  /// Berechnet den Unterschied zwischen dem aktuellen Datum und [date]
  /// Somit [1] für "Morgen" und [0] für "Heute".
  int _calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(
          DateTime(now.year, now.month, now.day),
        )
        .inDays;
  }

  /// Ordnet jedem Tag einen Path für das Wetterbild zu. 
  /// [main] ist ein Parameter der beim BackendCall übergeben wird und die 
  /// Wettersituation grob geschreibt.
  String _getImageAddress(String main) {
    String asset;
    switch (main) {
      case "Thunderstorm":
        asset = "heavyRain";
        break;
      case "Drizzle":
      case "Rain":
        asset = "rain";
        break;
      case "Snow":
        asset = "snow";
        break;
      case "Clear":
        asset = "sunny";
        break;
      case "Clouds":
        asset = "cloudy";
        break;
      default:
        asset = "fewClouds";
    }

    return "assets/${asset}.png";
  }
}
