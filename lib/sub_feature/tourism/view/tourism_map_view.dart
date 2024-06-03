import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourismMapView extends StatefulWidget {
  const TourismMapView({super.key});

  @override
  State<TourismMapView> createState() => _TourismMapViewState();
}

class _TourismMapViewState extends State<TourismMapView> {
  late GoogleMapController mapController;

  final LatLng _start = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng _end = const LatLng(34.0522, -118.2437); // Los Angeles

  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('line1'),
        points: [_start, _end],
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _start,
          zoom: 6,
        ),
        polylines: _polylines,
        markers: {
          Marker(
            markerId: const MarkerId('start'),
            position: _start,
            infoWindow: const InfoWindow(title: 'Start'),
          ),
          Marker(
            markerId: const MarkerId('end'),
            position: _end,
            infoWindow: const InfoWindow(title: 'End'),
          ),
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
