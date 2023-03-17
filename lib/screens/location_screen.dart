import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Location_Screen extends StatefulWidget {
  Location_Screen({this.weatherData});

  final weatherData;

  @override
  State<Location_Screen> createState() => _Location_ScreenState();
}

class _Location_ScreenState extends State<Location_Screen> {
  @override
  void deb() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    String month = DateFormat.MMMM().format(now);
    String date = DateFormat.MMMMd().format(now);
    String weekday = DateFormat.MMMMEEEEd().format(now);
    print(formattedTime);
  }

  Widget build(BuildContext context) {
    deb();
    var data = widget.weatherData;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    String month = DateFormat.MMMM().format(now);
    String date = DateFormat.d().format(now);
    String weekday = DateFormat.EEEE().format(now);
    double min_temp = data['main']['temp_min'];
    double max_temp = data['main']['temp_max'];

    String icon = widget.weatherData['weather'][0]['icon'];
    double temp = data['main']['temp'] - 273;
    String temperature = temp.toStringAsFixed(1);
    String description=data['weather'][0]['description'];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Text(
                    data['name'],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    weekday,
                  ),
                ),
                Expanded(
                  child: Text(
                    date,
                  ),
                ),
                Expanded(
                  child: Text(
                    month,
                  ),
                ),
                Expanded(
                  child: Text(
                    formattedTime,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                      'http://openweathermap.org/img/wn/$icon@2x.png'),
                ),
                Expanded(
                  child: Text(
                    "$temperature\u2103",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text("Min $min_temp"),
                ),
                Expanded(
                  child: Text("Max $max_temp"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Expanded(
              child: Text(description),
            ),
          ),
        ],
      ),
    );
  }
}
