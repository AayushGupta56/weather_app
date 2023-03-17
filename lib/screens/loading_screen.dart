import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

const apiKey = '0b35060570726f874b4357799cc5c1e5';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  double? longitude;
  double? latittude;
  bool? isLoading;
  dynamic? data;
  setLoading(bool state) => setState(() => isLoading = state);

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    location l = location();
    try {
      setLoading(true);
      await l.getLocation();
    } finally {
      setLoading(false);
    }

    print(l.longitude);
    print(l.latitude);
    longitude = (l.longitude);
    latittude = l.latitude;
    String myurl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latittude&lon=$longitude&appid=$apiKey';
    networkHelper client = networkHelper(url: myurl);
      data = await client.getData();
    //print(data);
   // Location_Screen(weatherData: data);
    var name = data['name'];
    var weatherDescription = data['weather'][0]['description'];
    print(weatherDescription);
    print(name);
    print(data['main']['temp']);
    print(latittude);
    print(data['dt']);
    var t1 = data['dt'];

    t1 = t1 * 1000;

    var dateUtc = DateTime.fromMillisecondsSinceEpoch(t1, isUtc: false);
    var dateInMyTimezone = dateUtc.add(Duration(hours: 8));
    var secondsOfDay = dateInMyTimezone.hour * 3600 +
        dateInMyTimezone.minute * 60 +
        dateInMyTimezone.second;
    print(dateUtc);
    print(dateInMyTimezone);
    print(secondsOfDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: TextButton(
                child: Text('GetLoacation'),
                onPressed: ()async {
                  await fetchLocation();
                  if (isLoading == false) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Location_Screen(weatherData: data,),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
