import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class WeatherSlider extends StatefulWidget {
  List listWeather;
  WeatherSlider(this.listWeather, {super.key});

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
  String temperetureSeventy = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () => getTempereture());
    });
  }

  void getTempereture() {
    setState(() {
      if (widget.listWeather.isNotEmpty) {
        temperetureFirst = widget.listWeather.elementAt(0) + '';
        temperetureSecond = widget.listWeather.elementAt(1) + '';
        temperetureThirty = widget.listWeather.elementAt(2) + '';
        temperetureFourty = widget.listWeather.elementAt(3) + '';
        temperetureFifty = widget.listWeather.elementAt(4) + '';
        temperetureSixty = widget.listWeather.elementAt(5) + '';
        temperetureSeventy = widget.listWeather.elementAt(6) + '';
      }
    });
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
                    'images/rain_icon.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text("ПН",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureSecond*C',
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    'images/icon-clouds-and-sun.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text("ВТ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureThirty*C',
                      style: const TextStyle(color: Colors.white, fontSize: 15))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    'images/icon-sun.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text("СР",
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
                    'images/icon-sun.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text("ЧТ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureFifty*C',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    'images/icon-clouds-and-sun.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text(
                    "ПТ ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    '$temperetureSixty*C',
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
                    'images/icon-clouds-and-sun.jpg',
                    width: 45,
                    height: 45,
                  ),
                  const Text('СБ',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('$temperetureSeventy*C',
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
