import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(GetWeather('Moscow').returnWeather());
  }
}

class GetWeather {
  String city = "";
  var myFuture = http.get(
      'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m'
          as Uri);

  GetWeather(this.city);

  String returnWeather() {
    return '';
  }
}
