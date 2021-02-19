import 'package:flutter/material.dart';
import 'package:weather_app_example/bloc/bloc.dart';


/// Zeigt den minimalen und maximalen Temperaturwert des Tages an.
class DayChart extends StatefulWidget {
  DayChart({Key key}) : super(key: key);

  @override
  _DayChartState createState() => _DayChartState();
}

class _DayChartState extends State<DayChart> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
      },
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          final currentData = state.data.weatherData[state.data.currentDay];
          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${currentData.minTemp}°C",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "min",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Theme.of(context).accentColor,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${currentData.maxTemp}°C",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "max",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
