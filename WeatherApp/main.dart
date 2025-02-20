import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();
  String city = "";
  String weatherCondition = "";
  int temperature = 0;
  final List<String> conditions = ["Sunny", "Cloudy", "Rainy"];

  void fetchWeather() {
    setState(() {
      city = _controller.text;
      temperature = Random().nextInt(16) + 15;
      weatherCondition = conditions[Random().nextInt(conditions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Info App")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter City Name"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text("Fetch Weather"),
            ),
            SizedBox(height: 20),
            if (city.isNotEmpty)
              Column(
                children: [
                  Text("City: $city", style: TextStyle(fontSize: 20)),
                  Text("Temperature: $temperature°C", style: TextStyle(fontSize: 20)),
                  Text("Condition: $weatherCondition", style: TextStyle(fontSize: 20)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
