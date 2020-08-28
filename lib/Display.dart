import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';import 'Display.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Display extends StatefulWidget {
  var temperature;
  var city;
  var humidity;
  var icon;
  var pressure;
  Display(var a,var b,var c,var d,var e)
  {
    temperature=a;
    pressure=b;
    humidity=c;
    icon=d;
    city=e;
  }
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var temperaturef;
  var cityf;
  var humidityf;
  var iconf;
  var pressuref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temperaturef=widget.temperature;
    humidityf=widget.humidity;
    pressuref=widget.pressure;
    iconf=widget.icon;
    cityf=widget.city;


  }String locationi;
  Future<Void> gert ()
async{
   await getWeather();
}
  void getWeather() async{

    Response response= await get("http://api.openweathermap.org/data/2.5/weather?q=$locationi&appid=03e0b5dae42b2dbbdf38ace0e63902f3&units=metric");
    if(response.statusCode==200){
    var temperature=jsonDecode(response.body)['main']['temp'];
    var pressure=jsonDecode(response.body)['main']['pressure'];
    var humidity=jsonDecode(response.body)['main']['humidity'];
    var icon=jsonDecode(response.body)['weather'][0]['icon'];
    var city=jsonDecode(response.body)['name'];
    temperaturef=temperature;
    iconf=icon;
    humidityf=humidity;
    cityf=city;
    pressuref=pressure;
    print(cityf);}
    else{
      temperaturef=0;
      cityf="error";
      humidityf=0;

    }

  }


  @override
  Widget build(BuildContext context) {String location;

    return Scaffold(
        resizeToAvoidBottomInset: false,


      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage("images/b.png"),
            fit: BoxFit.fitHeight,)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
             children: <Widget>[
               Row(
                 textBaseline: TextBaseline.alphabetic,
                 children: <Widget>[
                   Icon(Icons.search,size: 40,),
                   Container(
                     width: 300,
                     height: 30,

                       child: TextField(

                         onSubmitted: (String str)
                         { locationi=str;
                           setState(() {


                              gert();





                           });

                         },

                         style: TextStyle(
                           color: Colors.white
                               ,fontSize: 20
                         ),
                         decoration: InputDecoration(
                           fillColor: Colors.red,hintText: "Search for other places",


                       ),
                     ),
                   ),
                 ],
               )
             ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(cityf,style: TextStyle(fontSize: 30,color: Colors.white,fontStyle: FontStyle.italic),),
                Image(image: AssetImage('images/$iconf'+'.png'),)
              ],
            ),
//            Card(
//              color: Colors.blueGrey.shade800,elevation: 20,
//
//
//              child:Text(humidityf.toString(),style: TextStyle(fontSize: 100,color: Colors.white,fontStyle: FontStyle.italic) ,
//            ))
          Card(

            color: Colors.blueGrey.shade800,
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: <Widget>[
                Text('Temperature:',style: TextStyle(fontSize: 30,color: Colors.white,fontStyle: FontStyle.italic)),
                Text(double.parse(temperaturef.toString()).toInt().toString()+"°C",style: TextStyle(fontSize: 50,color: Colors.white,fontStyle: FontStyle.italic))
              ],),
            ),
          ),
            Card(
              color: Colors.blueGrey.shade800,
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(children: <Widget>[
                  Text('Humidity:',style: TextStyle(fontSize: 30,color: Colors.white,fontStyle: FontStyle.italic)),
                  Text(humidityf.toInt().toString()+"%",style: TextStyle(fontSize: 50,color: Colors.white,fontStyle: FontStyle.italic))
                ],),
              ),
            ),
            Card(
              color: Colors.blueGrey.shade800,
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(children: <Widget>[
                  Text('Pressure:',style: TextStyle(fontSize: 30,color: Colors.white,fontStyle: FontStyle.italic)),
                  Text(pressuref.toInt().toString()+" hPa",style: TextStyle(fontSize: 40,color: Colors.white,fontStyle: FontStyle.italic))
                ],),
              ),
            )
          ],
        ),
      )
    );
  }
}

