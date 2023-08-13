import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void initState(){
    super.initState();
    getLocation();
  }

  void getLocation() async {
   Location location = Location();
   await location.getCurrentLocation();

   print(location.longitude);
   print(location.latitude);
  }
  
  void getData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=London&appid=b3d752074ccc4ba43839a9ec1ca47c23',
    );
    Response response = await get(url);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
