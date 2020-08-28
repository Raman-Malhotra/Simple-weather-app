import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';import 'Display.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
void main() {
  runApp(yApp());
}

class yApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

        home: new MyApp());
  }
}





class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}
double longitude;
double latitude;

class _MyAppState extends State<MyApp> {
  void getLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude=position.latitude;
    longitude=position.longitude;
    print(latitude);
    getWeather();
  }
  void getWeather() async{
    Response response= await get("http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=03e0b5dae42b2dbbdf38ace0e63902f3&units=metric");
    var temperature=jsonDecode(response.body)['main']['temp'];
    var pressure=jsonDecode(response.body)['main']['pressure'];
    var humidity=jsonDecode(response.body)['main']['humidity'];
    var icon=jsonDecode(response.body)['weather'][0]['icon'];
    var city=jsonDecode(response.body)['name'];
    print(city);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>Display(temperature,pressure,humidity,icon,city)),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       body: Center(
         child: SpinKitDoubleBounce(
           color: Colors.black,
           size: 100.0,
         ),
       ),
   );
  }
}
