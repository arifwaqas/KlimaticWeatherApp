import 'dart:async' as prefix1;
import 'dart:core' as prefix0;
import 'dart:core';
import '../utils/stylepage.dart' as style;
import 'package:flutter/material.dart';
import 'package:klimatic/ui/change_city.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'change_city.dart';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  String cityName = "Kuala Lumpur";
  String stName = "Kuala Lumpur";
  String cnName = "Malaysia";
  Map data;

  Future _changeCityFunc(BuildContext context) async {
      Map dataChange = await Navigator.of(context).push(
        new MaterialPageRoute<Map>(
          builder: (BuildContext context){
            return new ChangeCity();
          }
        )
      );

      if (dataChange!=null && dataChange.isNotEmpty){
        setState(() {
          cityName = dataChange['city'].toString();

        });
      }
      debugPrint(cityName);
  }

void _showWeather() async {
  data = await getWeather(cityName);
setState(() {
  cnName = data['location']['country'].toString();
  stName = data['location']['region'].toString();
});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "Klimatic",
            textDirection: TextDirection.ltr,
            style: new TextStyle(
              fontFamily: 'GreatVibes',
              fontSize: 32,
              letterSpacing: 3,
              color: Colors.white,
              fontWeight: FontWeight.w500

            ),
          ),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                _changeCityFunc(context);
              },
              color: Colors.white,
              alignment: Alignment.center,
            ),
          ],
        ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/umbrella.png',
              width: 460,
              height: 1220,
              fit: BoxFit.fill,
            ),
          ),

          new Container(
            child: updateTemp(cityName),
            margin: const EdgeInsets.fromLTRB(30.0,30.0,0,30.0),
          ),

          new Container(
            alignment: Alignment.topRight,
            child: Text("$cityName",
            style: style.cityStyle(),),
            margin: const EdgeInsets.fromLTRB(0,20,20,0),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0,110,20,0),
            child: Text("$cnName",
              style: style.cnStyle(),),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0,90,20,0),
            child: Text("$stName,",
              style: style.stStyle(),
            ),
          ),
        ],
      ),
    );
  }


  //Future builder function
  Widget updateTemp(String city) {
      return
          new FutureBuilder(
            future: getWeather(city),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData){
                _showWeather();
                data = snapshot.data;

                return new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.bottomRight,
                        margin: new EdgeInsets.only(right: 18),
                        child: new Image(
                          image: new NetworkImage("https:${data["current"]["condition"]["icon"]}"),
                          height: 100,
                          width:100,
                          fit: BoxFit.fill,
                        ),
                      ),

                      new Container(
                        margin: new EdgeInsets.fromLTRB(0,0,21,0),
                        child: new Column(

                          children: <Widget>[
                            new Container(
                              alignment: Alignment.bottomRight,
                              child: new Text(
                                "${data['current']['temp_c'].toString()}° C",
                                style: style.tempStyle(),
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.symmetric(vertical: 4),
                              alignment: Alignment.bottomRight,
                              child: new Text(
                                "Humidity: ${data['current']['humidity'].toString()}% ",
                                style: style.subTemp(),
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.symmetric(vertical: 4),
                              alignment: Alignment.bottomRight,
                              child: new Text(
                                "UV Index: ${data['current']['uv'].toString()}",
                                style: style.subTemp(),
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.symmetric(vertical: 4),
                              alignment: Alignment.bottomRight,
                              child: new Text(
                                "The visibilty is about ${data['current']['vis_km'].toString()} KMs",
                                style: style.subTempBottom(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /**/

                    ],
                  ),
                );
              }
              else {
               return new Container();
              }
            },
          );
  }

  //Map getWeather()
  Future<Map> getWeather(String cityName) async {

    final apiID = 'https://api.apixu.com/v1/current.json?key=38f335cc8d524d89a3d180336190307&q=$cityName';

    http.Response response = await http.get(apiID);

    //Map resmap = json.decode(response.body);


    return json.decode(response.body);
  }


}

