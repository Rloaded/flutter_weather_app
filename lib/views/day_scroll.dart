import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_example/bloc/bloc.dart';
import 'package:weather_app_example/data/state_data.dart';


/// Dieses Widget zeichnet die horizontal-scrollende Liste. 
/// Welche ausgewählt werden können um das Wetter an diesem Tag anzuzeigen.
class DayScroll extends StatefulWidget {
  DayScroll({Key key}) : super(key: key);

  @override
  _DayScrollState createState() => _DayScrollState();
}

class _DayScrollState extends State<DayScroll> {
  final double _itemWidth = 115;

  final DateFormat dateFormat = DateFormat("dd/MM");

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final index = BlocProvider.of<WeatherBloc>(context).state.data.currentDay;
    _scrollToIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is DayChanged) {
          _scrollToIndex(state.data.currentDay);
        }
      },
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          final weatherData = state.data.weatherData;
          final titles = _getListOfTitles(weatherData);
          // Ab hier Layout bauen
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: titles.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  final currentData = weatherData[index];
                  final date = dateFormat.format(currentData.date);
                  final title = titles[index];
                  if (index == state.data.currentDay) {
                    return _getHighlightedItem(context, index, date, title);
                  } else {
                    return _getItem(context, index, date, title);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getItem(context, int index, String date, String title) {
    return GestureDetector(
      onTap: () => _onTap(index, context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: _itemWidth,
        child: _getTitleAndDate(context, date, title),
      ),
    );
  }

  Widget _getHighlightedItem(context, int index, String date, String title) {
    return GestureDetector(
      onTap: () => _doScroll(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: _itemWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
          borderRadius: BorderRadius.circular(90),
        ),
        child: _getTitleAndDate(context, date, title),
      ),
    );
  }

  Widget _getTitleAndDate(context, String date, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            date,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  // Regelt das onTap Verhalten der nicht ausgewählten Listenelementen.
  void _onTap(index, context) {
    BlocProvider.of<WeatherBloc>(context).add(
      ChangeDay(
        newCurrentDay: index,
      ),
    );
  }

  /// Scrollt zum Listenelement an der Stelle [index].
  /// Nachdem das Widget fertig gebaut wurde.
  void _scrollToIndex(index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _doScroll(index);
    });
  }

  /// Führt den eigentlich scroll durch.
  void _doScroll(index) {
    _controller.animateTo(
      index * _itemWidth,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  /// Erstellt eine Liste aller Wochentagsangaben aus [weatherInfo].
  List<String> _getListOfTitles(List<WeatherInfo> weatherInfo) {
    List<String> listOfTitles = List<String>();
    for (var info in weatherInfo) {
      listOfTitles.add(info.dayName);
    }
    return listOfTitles;
  }
}
