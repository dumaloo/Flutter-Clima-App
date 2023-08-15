import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';


const apiKey = 'b3d752074ccc4ba43839a9ec1ca47c23';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;

  void initState(){
    super.initState();
    getLocation();
  }

  void getLocation() async {
   Location location = Location();
   await location.getCurrentLocation();

   latitude = location.latitude;
   longitude = location.longitude;
   getData();
  }
  
  void getData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    );
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      String data = response.body;

      var decodedData = jsonDecode(data);
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];
      double temperature = decodedData['main']['temp'];

      print(cityName);
      print(temperature);
      print(condition);
    }
    else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
