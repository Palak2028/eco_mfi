
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';





class GeoPointsLocator extends StatefulWidget {


  final List<Geocordinates> geocordinates;
  GeoPointsLocator(this.geocordinates);
  @override
  _GeoPointsLocator createState() => new _GeoPointsLocator();
}

class _GeoPointsLocator extends State<GeoPointsLocator> {
  List<Marker> MarkerList  = new List<Marker>();

  @override
  void initState() {
    super.initState();
    markerBuilder();
  }







  List<Marker> markerBuilder(){
    if(widget.geocordinates!=null&&widget.geocordinates.isNotEmpty){
      for(int i= 0;i<widget.geocordinates.length;i++){
        MarkerList.add(new Marker(
          width: 20.0,
          height: 35.0,
          point: new LatLng(widget.geocordinates[i].geoLatitude, widget.geocordinates[i].geolongitude),
          builder: (ctx) =>
          new Container(
            child:new Icon(
              FontAwesomeIcons.mapMarker,
              color: Colors.red[400],
              size: 35.0,
            ),
          ),
        ),);


      }

      setState(() {

      });

    }

  }
  buildMap(){


    if(_mapController.ready){
      _mapController.move(

          new LatLng(widget.geocordinates[0].geoLatitude,widget.geocordinates[0].geolongitude),
          15.0,
      );
      setState(() {

      });

    }

  }
  MapController _mapController = new MapController();
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new Scaffold(
      appBar:  new AppBar(

          title:new Text('GeoLocation'),
      ),
      body: new FlutterMap(
        mapController: _mapController,
        options: new MapOptions(center :new LatLng(widget.geocordinates[0].geoLatitude,widget.geocordinates[0].geolongitude),minZoom: 5.0),
        layers: [
          new TileLayerOptions(
              urlTemplate:"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],


      ),
        MarkerList.isNotEmpty? new MarkerLayerOptions(
            markers: MarkerList
          ):null

        ],



      ),
    );
  }

}




class Geocordinates{
  double geoLatitude;
  double geolongitude;
}