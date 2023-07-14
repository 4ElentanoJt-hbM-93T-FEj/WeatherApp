// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class WeatherSlider extends StatefulWidget {
  List listWeather;
  Function? fn;
  WeatherSlider(this.listWeather, this.fn, {super.key});

  @override
  State<WeatherSlider> createState() => WeatherSliderState();
}

class WeatherSliderState extends State<WeatherSlider> {
  String temperetureFirst = '';
  String temperetureSecond = '';
  String temperetureThirty = '';
  String temperetureFourty = '';
  String temperetureFifty = '';
  String temperetureSixty = '';

  String imgDays1 = 'assets/images/icon-clouds-and-sun.jpg';
  String imgDays2 = 'assets/images/icon-clouds-and-sun.jpg';
  String imgDays3 = 'assets/images/icon-clouds-and-sun.jpg';
  String imgDays4 = 'assets/images/icon-clouds-and-sun.jpg';
  String imgDays5 = 'assets/images/icon-clouds-and-sun.jpg';
  String imgDays6 = 'assets/images/icon-clouds-and-sun.jpg';
  // Map<List<int>, String> weatherCodes = {
  //   [0]: 'Чистое небо',
  //   [1, 2, 3]: 'Ясно',
  //   [45, 48]: 'Туман',
  //   [51, 53, 55]: 'Морось',
  //   [56, 57]: 'Ледяная морось',
  //   [61, 63, 65]: 'Дождь',
  //   [66, 67]: 'Ледяной дождь',
  //   [71, 73, 75]: 'Снегопад',
  //   [77]: 'Снежные зерна',
  //   [80, 81, 82]: 'Ливневые дожди',
  //   [85, 86]: 'Снег'
  // };

  @override
  void initState() {
    super.initState();
    getTempereture();
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
    return 'assets/images/rain.jpg';
  }

  Future<void> getTempereture() async {
    await widget.fn!();
    setState(
      () {
        if (widget.listWeather.isNotEmpty) {
          temperetureFirst = widget.listWeather[0][0] + '';
          temperetureSecond = widget.listWeather[1][0] + '';
          temperetureThirty = widget.listWeather[2][0] + '';
          temperetureFourty = widget.listWeather[3][0] + '';
          temperetureFifty = widget.listWeather[4][0] + '';
          temperetureSixty = widget.listWeather[5][0] + '';
          imgDays1 = getWeatherImg(int.parse(widget.listWeather[0][1]))!;
          imgDays2 = getWeatherImg(int.parse(widget.listWeather[1][1]))!;
          imgDays3 = getWeatherImg(int.parse(widget.listWeather[2][1]))!;
          imgDays4 = getWeatherImg(int.parse(widget.listWeather[3][1]))!;
          imgDays5 = getWeatherImg(int.parse(widget.listWeather[4][1]))!;
          imgDays6 = getWeatherImg(int.parse(widget.listWeather[5][1]))!;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 400,
      child: Center(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays1,
                    width: 45,
                    height: 45,
                  ),
                  const Text("ПН",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureFirst*C',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays2,
                    width: 45,
                    height: 45,
                  ),
                  const Text("ВТ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureSecond*C',
                      style: const TextStyle(color: Colors.white, fontSize: 15))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays3,
                    width: 45,
                    height: 45,
                  ),
                  const Text("СР",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureThirty*C',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays4,
                    width: 45,
                    height: 45,
                  ),
                  const Text("ЧТ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureFourty*C',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays5,
                    width: 45,
                    height: 45,
                  ),
                  const Text(
                    "ПТ ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    '$temperetureFifty*C',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    imgDays6,
                    width: 45,
                    height: 45,
                  ),
                  const Text('СБ',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureSixty*C',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
