import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'b3d752074ccc4ba43839a9ec1ca47c23';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩'; // Thunderstorms
    } else if (condition < 600) {
      return '🌧'; // Rain
    } else if (condition < 700) {
      return '❄️'; // Snow
    } else if (condition == 800) {
      return '☀️'; // Clear sky
    } else if (condition <= 804) {
      return '☁️'; // Cloudy
    } else {
      return '🤷‍'; // Unknown or other conditions
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'It\'s 🌞 time'; // Hot weather
    } else if (temp > 25) {
      return 'Time for shorts and 👕'; // Warm weather
    } else if (temp < 15) {
      return 'You\'ll need 🧣 and 🧤'; // Cold weather
    } else {
      return 'Bring a 🧥 just in case'; // Moderate weather
    }
  }
}
