import 'package:flutter/material.dart';

class TourismMapView extends StatefulWidget {
  const TourismMapView({super.key});

  @override
  State<TourismMapView> createState() => _TourismMapViewState();
}

class _TourismMapViewState extends State<TourismMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
    );
  }
}
