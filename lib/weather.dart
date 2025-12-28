import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherModule extends StatefulWidget {
  const WeatherModule({Key? key}) : super(key: key);

  @override
  _WeatherModuleState createState() => _WeatherModuleState();
}

class _WeatherModuleState extends State<WeatherModule> {
  final String _apiKey = '60bbd59ec7556e88c0f6b5a2080aebaa';
  String _cityName = '';
  dynamic _weatherData;
  bool _isLoading = false;
  bool _isValidCity = true;

  Future<void> _fetchWeatherData(String city) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _weatherData = data;
          _isLoading = false;
          _isValidCity = true; // Reset validation flag
        });
      } else {
        setState(() {
          _weatherData = null;
          _isLoading = false;
          _isValidCity = false; // Set validation flag
        });
        // Handle error response
        //print('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        _weatherData = null;
        _isLoading = false;
        _isValidCity = false; // Set validation flag
      });
      // Handle network error
      //print('Failed to fetch weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  filled: true,
                  fillColor: Colors.white,
                  errorText: _isValidCity
                      ? null
                      : _cityName.isEmpty
                          ? 'Enter city name'
                          : 'Invalid city name',
                ),
                onChanged: (value) {
                  setState(() {
                    _cityName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_cityName.isNotEmpty) {
                    _fetchWeatherData(_cityName);
                  } else {
                    setState(() {
                      _isValidCity = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(88, 20, 143, 1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Get Weather',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (_weatherData != null)
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(18),
                  margin: const EdgeInsets.fromLTRB(0, 36, 0, 36),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(88, 20, 143, 1),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              Text(
                                '🏡 ${_weatherData['name']}',
                                style: const TextStyle(
                                    fontSize: 36, color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              Image.network(
                                'https://openweathermap.org/img/w/${_weatherData['weather'][0]['icon']}.png',
                                width: 100,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${_weatherData['main']['temp']}°C',
                                style: const TextStyle(
                                    fontSize: 36, color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${_weatherData['weather'][0]['description'][0].toUpperCase()}${_weatherData['weather'][0]['description'].substring(1)}',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
