import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:klimatic/ui/klimatic_states.dart';


class ChangeCity extends StatefulWidget {

  @override
  _ChangeCityState createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {

//  void _changeFormat(){
//
//      for (int i=0; i<_cityName.toString().length; i++){
//        if (_cityName.toString()[i]==" "){
//          cityNew += "_";
//        }
//        else{
//          cityNew+=_cityName.toString()[i];
//        }
//      }
//      debugPrint(cityNew);
//  }


  var _cityName = new TextEditingController();

  String cityNew;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Page'),
        backgroundColor: Colors.cyan,
      ),
      body: new Stack(
        children: <Widget>[
          new Image.asset(
            "images/white_snow.png",
            height: 1200,
              width: 500,
            fit: BoxFit.fill,
          ),
          new Container(
            padding: new EdgeInsets.all(5),
            child: new TextField(
              keyboardType: TextInputType.text,
              controller: _cityName,
              decoration: new InputDecoration(
                labelText: "Enter City Name Here",
                alignLabelWithHint: true,
              ),
            ),
          ),
          new Container(
             padding: new EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            child: new Container(
              alignment: Alignment.center,
              child: new RaisedButton(
                elevation: 8,
                color: Colors.redAccent,
                child: new Text(
                  "Confirm"
                ),
                onPressed: () {
                 // _changeFormat();
                  Navigator.pop(context, {"city": _cityName.text});
                },
              ),
            ),
          )
        ],
      ),

    );
  }
}
