import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsJob extends StatefulWidget {
  final double lat;
  final double long;
  final String title;
  final String snippet;
  final int jobId;
  const GoogleMapsJob({super.key, required this.lat, required this.long, required this.title, required this.snippet, required this.jobId});

  @override
  State<GoogleMapsJob> createState() => _GoogleMapsJobState();
}

class _GoogleMapsJobState extends State<GoogleMapsJob> {
  late GoogleMapController mapController;

  Set<Marker> markers = {};

  @override
  void initState() {
    addMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Jobs'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) =>
            mapController = controller,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: markers,
      ),
    );
  }

  void addMarker() async {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(markers.length.toString()),
          position: LatLng(
            widget.lat + markers.length * 0.01,
            widget.long + markers.length * 0.01,
          ),
          infoWindow: InfoWindow(
            title: widget.title,
            snippet: widget.snippet,
          ),
        ),
      );
    });
  }
}
