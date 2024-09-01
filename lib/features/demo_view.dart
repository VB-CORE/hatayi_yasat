import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lifeclient/product/utility/constants/index.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});
  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  LatLng _initialPosition =
      AppConstants.initialLocation.target; // Başlangıç konumu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        onTap: (argument) {
          setState(() {
            _initialPosition = argument;
          });
        },
        initialCameraPosition: AppConstants.initialLocation,
        markers: {
          Marker(
            markerId: const MarkerId('selected-location'),
            position: _initialPosition,
          ),
        },
      ),
    );
  }
}
