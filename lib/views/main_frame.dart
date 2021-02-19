import 'package:flutter/material.dart';
import 'package:weather_app_example/bloc/bloc.dart';
import 'package:weather_app_example/handler/location_handler.dart';
import 'package:weather_app_example/views/views.dart';



/// Dieses Widget bildet das Grundgerüst der ganzen App.
/// Von hier aus werden alle anderen Widgets aufgerufen.
class MainFrame extends StatefulWidget {
  MainFrame({Key key}) : super(key: key);

  @override
  _MainFrameState createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Future<void> initState() {
    super.initState();

    LocationHandler.hasPermission().catchError((err) {
      if (err == LocationStatus.noPermissionForever) {
        _showSnackBar("Permanent Rechte entzogen");
      } else if (err == LocationStatus.noService) {
        _showSnackBar("Kein GPS-Empfang.");
      }
    }).then((value) =>
        value ? null : _showSnackBar("Keine Rechte den Standort abzugreifen."));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is DataLoadingFailed) {
            _showSnackBar(state.message);
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                body: LayoutBuilder(
                  builder: (context, constraints) => RefreshIndicator(
                    onRefresh: () => _onRefresh(),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        // Layout work from here
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).backgroundColor,
                              Color(0xff1f1f1f),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.data.location,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !state.data.dataFine,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DayScroll(),
                            Expanded(
                              flex: 4,
                              child: InfoCard(),
                            ),
                            Expanded(
                              flex: 1,
                              child: DayChart(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  /// Diese Methode regelt das "refreshen" der Daten. 
  Future<void> _onRefresh() async {
    final provider = BlocProvider.of<WeatherBloc>(context);
    provider.add(RefreshData());
    return provider.firstWhere(
      (element) => element is DataLoaded,
    );
  }

  /// Diese Methode zeigt die verschiedenen SnackBars an.
  /// [text] ist dabei der Text der in der Snackbar angezeigt werden soll.
  void _showSnackBar(text) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 6),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      );
    });
  }
}
