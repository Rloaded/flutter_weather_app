import 'package:flutter/material.dart';
import 'package:weather_app_example/bloc/bloc.dart';
import 'package:weather_icons/weather_icons.dart';

class InfoCard extends StatefulWidget {
  InfoCard({Key key}) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final currentData = state.data.weatherData[state.data.currentDay];
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).dialogBackgroundColor,
                  Colors.transparent,
                ],
              ),
            ),
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage(currentData.imagePath),
                          ),
                        ),
                        Container(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 1, child: Container()),
                              Text(
                                currentData.description,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("${currentData.avgTemp}°C"),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Humidity
                            Container(
                              child: Column(
                                children: [
                                  Icon(
                                    WeatherIcons.humidity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      "${currentData.humidity}%",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Text(
                                    "Humidity",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            //wind
                            Container(
                              child: Column(
                                children: [
                                  Icon(
                                    WeatherIcons.strong_wind,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      "${currentData.windSpeed} km/h",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Text(
                                    "Wind",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            //Pressure
                            Container(
                              child: Column(
                                children: [
                                  Icon(
                                    WeatherIcons.barometer,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      "${currentData.pressure} hpa",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Text(
                                    "Pressure",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
