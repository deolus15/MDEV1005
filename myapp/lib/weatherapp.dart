import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Weather Page Widget
class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

// State class for the Weather Page
class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData; // Holds the fetched weather data

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // Initiates the weather data fetching on page initialization
  }

  // Function to fetch weather data from the OpenWeatherMap API
  Future<void> fetchWeatherData() async {
    try {
      const city = 'Canada'; // Hardcoded city for demonstration
      const apiKey = 'f0e9a8eef1d91f7975d9d04ff5a35ceb'; // API key for OpenWeatherMap
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'),
      );

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body); // Parse and store the fetched weather data
        });
      } else {
        print('Failed to fetch weather data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Scaffold configuration for the Weather Page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/weatherbg.jpg',
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100,
            child: weatherData == null
                ? CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display weather information
                Text(
                  'Weather in ${weatherData!['name']}',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                    'Temperature: ${weatherData!['main']['temp']}°C',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Colors.black),

                ),
                Text(
                    'Description: ${weatherData!['weather'][0]['description']}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
