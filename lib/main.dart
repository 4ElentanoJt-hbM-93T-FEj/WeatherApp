// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import './weather_slider.dart';
import './position.dart' as determine_postition;
import './WeatherResponse.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Position? _currentPosition;
  double? latitude;
  double? longitude;
  var resUrl = '';
  Map<String, dynamic>? currentWeather;
  double? temp = 0.0;
  var weather;
  List<String> hourlyTime = [];
  List<double>? windSpeed = [];
  String? farengete;
  List resList = [];
  DateTime dtStart = DateTime.now();
  DateTime dtEnd = DateTime.now().add(const Duration(days: 6));

  Map<String, String>? listWeather = {};

  // String startDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // String endDate = DateFormat("yyyy-MM-dd")
  //     .format(DateTime.now().add(const Duration(days: 7)));

  // Обращение к классу получения местоположения устройства.
  var determinePosition =
      determine_postition.DeterminePosition().determinePosition;

  @override
  void initState() {
    super.initState();
    getRequest();
    print("123");
  }

  Future<void> getRequest() async {
    // Получение местоположения устройства.
    _currentPosition = await determinePosition();

    // Координтаы устройства. (они всегда будут иметь значения)
    latitude = _currentPosition!.latitude;
    longitude = _currentPosition!.longitude;

    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&current_weather=true&timezone=Europe%2FMoscow&forecast_days=14';
    // 'https://api.open-meteo.com/v1/forecast?latitude=&longitude=&hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&current_weather=true&timezone=auto&start_date=$startDate&end_date=$endDate';

    final response = await http.get(Uri.parse(url)).then(
      (value) {
        print('+++');
        // print(jsonDecode(value.body));

        if (value.statusCode == 200) {
          WeatherResponse weather =
              WeatherResponse.fromJson(jsonDecode(value.body));
          // print(weather.currentWeather?.temperature);

          hourlyTime = weather.hourly!.time!;
          windSpeed = weather.hourly!.windspeed10m!;

          print(hourlyTime);
          print(windSpeed);
          // weather.hourly!.temperature2m!;
          // print(dtStart.day);
          // print(dtEnd.day);
          // print('${dtStart.day}T');
          // print('${dtEnd.day}T');
          // print(hourlyTime);
          // print(hourlyTime.indexOf('${dtStart.day}T'));
          // print(hourlyTime.indexOf('${dtEnd.day}T'));

          // 2023-07-11T17:00
          //
          String start = "";
          String end = "";

          // if (dtStart.month < 10 && dtStart.hour < 10) {
          //   start =
          //       '${dtStart.year}-0${dtStart.month}-${dtStart.day}T0${dtStart.hour}:00';
          //   end =
          //       '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T0${dtEnd.hour}:00';
          // } else if (dtStart.hour < 10) {
          //   start =
          //       '${dtStart.year}-0${dtStart.month}-${dtStart.day}T0${dtStart.hour}:00';
          //   end =
          //       '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T0${dtEnd.hour}:00';
          // } else if (dtStart.hour > 10) {
          //   start =
          //       '${dtStart.year}-0${dtStart.month}-${dtStart.day}T${dtStart.hour}:00';
          //   end = '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T${dtEnd.hour}:00';
          // } else if (dtStart.month < 10){

          // }
          String firstDay = '';
          String secondDay = '';
          String thirtytDay = '';
          String fourtyDay = '';
          String fiftyDay = '';
          String sixtyDay = '';
          String seventyDay = '';

          if (dtStart.hour < 10) {
            start =
                '${dtStart.year}-0${dtStart.month}-${dtStart.day}T0${dtStart.hour}:00';
            end =
                '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T0${dtEnd.hour}:00';

            firstDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.day}T0${dtStart.hour}:00';
            secondDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 1)).day}T0${dtStart.hour}:00';
            thirtytDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 2)).day}T0${dtStart.hour}:00';
            fourtyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 3)).day}T0${dtStart.hour}:00';
            fiftyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 4)).day}T0${dtStart.hour}:00';
            sixtyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 5)).day}T0${dtStart.hour}:00';
            seventyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 6)).day}T0${dtStart.hour}:00';
          } else {
            start =
                '${dtStart.year}-0${dtStart.month}-${dtStart.day}T${dtStart.hour}:00';
            end = '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T${dtEnd.hour}:00';
            firstDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.day}T0${dtStart.hour}:00';
            secondDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 1)).day}T${dtStart.hour}:00';
            thirtytDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 2)).day}T${dtStart.hour}:00';
            fourtyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 3)).day}T${dtStart.hour}:00';
            fiftyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 4)).day}T${dtStart.hour}:00';
            sixtyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 5)).day}T${dtStart.hour}:00';
            seventyDay =
                '${dtStart.year}-0${dtStart.month}-${dtStart.add(const Duration(days: 6)).day}T${dtStart.hour}:00';
          }

          List listDays = [
            firstDay,
            secondDay,
            thirtytDay,
            fourtyDay,
            fiftyDay,
            sixtyDay,
            seventyDay
          ];

          for (var item in listDays) {
            for (int i = hourlyTime.indexOf(start);
                i <= hourlyTime.indexOf(end);
                i++) {
              print(
                  "${weather.hourly!.time![i]} - ${weather.hourly!.temperature2m![i]}");
              if (item == weather.hourly!.time![i]) {
                // try {
                //   windSpeed?.add(weather.hourly!.windspeed10m![i]);
                // } catch (e) {
                //   null;
                // }

                listWeather?.addEntries({
                  weather.hourly!.time![i]:
                      weather.hourly!.temperature2m![i].toString()
                }.entries);
              }
            }
          }

          print('Вывод из списка дней окончен');
          print(listWeather);

          for (var i in listWeather!.values) {
            resList.add(i);
          }
          print('Вывод окончен');
          print(resList);
          print('Вывод окончен');
          // print(start);
          // print(end);
          // // print(
          // //     '${dtStart.year}-0${dtStart.month}-${dtStart.day}T${dtStart.hour}:00 Текущая дата');
          // // print(
          // //     '${dtEnd.year}-0${dtEnd.month}-${dtEnd.day}T${dtEnd.hour}:00 Конечная дата');
          // print(hourlyTime.indexOf(start));
          // print(
          //     "${weather.hourly!.time![1]} - ${weather.hourly!.temperature2m![1]}");
          // print(hourlyTime.indexOf(end));
          // print(
          //     "${weather.hourly!.time![145]} - ${weather.hourly!.temperature2m![145]}");

          print('Вывод окончен');

          setState(() {
            temp = weather.currentWeather?.temperature;
            farengete = (temp! * 9 / 5 + 32).toString();
            print(farengete);
          });
        }
      },
    );
    // print(hourlyTime);
  }

  // Запрос на использование местоположения
  Future<void> requestPermission() async {
    const permission = Permission.location;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Image.asset(
            'images/bg2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              width: 500,
              height: 650,
              child: Column(
                children: [
                  const Text(
                    'Магнитогорск',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      'images/icon-clouds-and-sun.jpg',
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Container(
                    child: Text(
                      '$temp°C / $farengete°F',
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                  // Text(
                  //   'Скорость ветра: ${windSpeed![1]}',
                  //   style: const TextStyle(fontSize: 20, color: Colors.white),
                  // ),

                  // ElevatedButton(
                  //   child: const Text("Показать погоду"),
                  //   onPressed: () async {
                  //     await getRequest();
                  //   },
                  // ),
                  const SizedBox(
                    height: 100,
                  ),
                  WeatherSlider(resList),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
