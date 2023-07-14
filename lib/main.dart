// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import './weather_slider.dart';
import './position.dart' as determine_postition;
import './WeatherResponse.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
// import 'package:geocoding/geocoding.dart';

Future<void> main() async {
  runApp(MyWidget());
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
  List<String> hourlyTime = [];
  List<double>? windSpeed = [];
  String? farengete;
  String weatherImg = 'assets/images/icon-clouds-and-sun.jpg';
  List resList = [];
  DateTime dtStart = DateTime.now();
  DateTime dtEnd = DateTime.now().add(const Duration(days: 6));
  String? _currentCity = '';
  final YandexGeocoder geo =
      YandexGeocoder(apiKey: '88990150-045a-4787-b513-7e08090b0409');

  Map<String, List<String>>? listWeather = {};

  Map<String, Map<String, int>>? weatherCode = {};
  List weatherCodeList = [];

  // Обращение к классу получения местоположения устройства.
  var determinePosition =
      determine_postition.DeterminePosition().determinePosition;

  @override
  void initState() {
    super.initState();
    getRequest();
    print("123");
  }

  // Получение данных из Api погоды.
  Future<void> getRequest() async {
    // Получение местоположения устройства.
    _currentPosition = await determinePosition();

    // Координтаы устройства. (они всегда будут иметь значения)
    latitude = _currentPosition!.latitude;
    longitude = _currentPosition!.longitude;
    await getAddress();
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&current_weather=true&timezone=Europe%2FMoscow';
    // 'https://api.open-meteo.com/v1/forecast?latitude=&longitude=&hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&current_weather=true&timezone=auto&start_date=$startDate&end_date=$endDate';

    final response = await http.get(Uri.parse(url)).then(
      (value) {
        print('+++');
        // print(jsonDecode(value.body));

        if (value.statusCode == 200) {
          WeatherResponse weather =
              WeatherResponse.fromJson(jsonDecode(value.body));
          // print(weather.currentWeather?.temperature);

          // Информация
          hourlyTime = weather.hourly!.time!;
          // windSpeed = weather.hourly!.windspeed10m!;

          String start = "";
          String end = "";
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
              // print(
              //     "${weather.hourly!.time![i]} - ${weather.hourly!.temperature2m![i]}");
              if (item == weather.hourly!.time![i]) {
                // Температура по дням и статус погоды
                listWeather?.addEntries({
                  weather.hourly!.time![i]: [
                    weather.hourly!.temperature2m![i].toString(),
                    weather.hourly!.weathercode![i].toString()
                  ]
                }.entries);
              }
            }
          }

          print('Вывод из списка дней окончен');
          print(listWeather);

          print('Итоговые данные по погоде - $resList');
          setState(() {
            weatherImg = getWeatherImg(weather.currentWeather!.weathercode!)!;
            temp = weather.currentWeather?.temperature;
            farengete = (temp! * 9 / 5 + 32).toInt().toString();
            for (var i in listWeather!.values) {
              resList.add(i);
            }
          });
        }
      },
    );
  }

  //Обратная конвертация из координат в адрес
  Future<void> getAddress() async {
    var address = 'null';
    var latLong = 'null';

    // Получение полного адреса по координатам
    final GeocodeResponse getAddress = await geo.getGeocode(
      GeocodeRequest(
        geocode: PointGeocode(latitude: latitude!, longitude: longitude!),
      ),
    );

    if (getAddress.firstAddress!.formatted.toString().contains('область')) {
      address = getAddress.firstAddress!.formatted.toString().split(', ')[2];
    } else {
      address = getAddress.firstAddress!.formatted.toString().split(', ')[1];
    }

    print(getAddress.firstAddress!.formatted.toString());
    setState(() {
      _currentCity = address;
    });

    // Получение координат по адресу
    final GeocodeResponse getLatLong = await geo.getGeocode(
      GeocodeRequest(
        geocode: AddressGeocode(
          address: 'Москва',
        ),
      ),
    );
    latLong = getLatLong.firstPoint!.pos.toString();
    print('Координаты именованного города $latLong');

    // Запрос имени города через прокси
    // final server = await shelf_io.serve(
    //   proxyHandler('https://geocode.xyz'),
    //   '47.88.62.42',
    //   80,
    // );

    // print('Proxying at http://${server.address.host}:${server.port}');

    // var address = await GeoCode()
    //     .reverseGeocoding(latitude: latitude!, longitude: longitude!);
    // _currentCity = address.city;
    // print(address.city);
  }

  String? getWeatherImg(int code) {
    switch (code) {
      case 0:
        return 'assets/images/icon-clouds-and-sun.jpg';

      case 1:
      case 2:
      case 3:
        return 'assets/images/icon-sun.jpg';

      case 45:
      case 48:
        return 'assets/images/fog.jpg';

      case 51:
      case 53:
      case 55:
        return 'assets/images/rain.jpg';
      case 56:
      case 57:
        return 'assets/images/freezing-rain.jpg';
      case 61:
      case 63:
      case 65:
        return 'assets/images/rain.jpg';

      case 66:
      case 67:
        return 'assets/freezing-rain.jpg';

      case 71:
      case 73:
      case 75:
        return 'assets/images/snow-storm.jpg';

      case 77:
        return 'assets/images/snow-storm.jpg';

      case 80:
      case 81:
      case 82:
        return 'assets/images/rain.jpg';

      case 85:
      case 86:
        return 'assets/images/snow-storm.jpg';
    }
    return 'assets/freezing-rain.jpg';
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_circle_left),
              onPressed: () async {
                await getRequest();
                // WeatherSlider(resList, getRequest).fn;
                // handle the press
              },
            ),
          ],
        ),
        body: Stack(children: [
          Image.asset(
            'assets/images/bg2.jpg',
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
                  Text(
                    '$_currentCity',
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      weatherImg,
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Text(
                    '$temp°C / $farengete°F',
                    style: const TextStyle(fontSize: 35, color: Colors.white),
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
                  WeatherSlider(resList, getRequest),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
