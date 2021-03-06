import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,


          ),
          home: Homepage()


      )
  );
}


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Position position;
  StreamSubscription<Position> positionStream;
  String lat,long = '';





  getLocation () async {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          if(position != null){
            setState(() {
              lat = position.latitude.toString();
              long = position.longitude.toString();
            });
          }
          else{
            setState(() {
              lat = 'Unknown';
              long = 'Unknown';
            });
          }
        });

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat='Unknown';
    long='Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS App for Codein'),
        centerTitle: true,

      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Latitude",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(lat,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              ),
              Text("Longtitude",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(long,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: RaisedButton(onPressed: getLocation,child: Text('Start Tracking',style: TextStyle(color: Colors.white),),color: Theme.of(context).primaryColor,),
              )
            ],
          ),
        ),
      ),


    );
  }
}
