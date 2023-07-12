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
  String temperetureSeventy = '';

  @override
  void initState() {
    super.initState();
    getTempereture();
  }

  Future<void> getTempereture() async {
    await widget.fn!();
    setState(() {
      if (widget.listWeather.isNotEmpty) {
        temperetureFirst = widget.listWeather[0] + '';
        temperetureSecond = widget.listWeather[1] + '';
        temperetureThirty = widget.listWeather[2] + '';
        temperetureFourty = widget.listWeather[3] + '';
        temperetureFifty = widget.listWeather[4] + '';
        temperetureSixty = widget.listWeather[5] + '';
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
                    'images/icon-clouds-and-sun.jpg',
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
                    'images/icon-sun.jpg',
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
                    'images/icon-sun.jpg',
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
                    'images/icon-clouds-and-sun.jpg',
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
                    'images/icon-clouds-and-sun.jpg',
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
