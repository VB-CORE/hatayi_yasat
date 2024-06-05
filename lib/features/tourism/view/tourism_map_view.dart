import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/tourism/models/tourism_map_model.dart';
import 'package:lifeclient/product/utility/decorations/box_decorations.dart';

part '../widgets/tourism_place_card.dart';
part '../widgets/tourism_places_slider.dart';

class TourismMapView extends StatefulWidget {
  const TourismMapView({super.key});

  @override
  State<TourismMapView> createState() => _TourismMapViewState();
}

class _TourismMapViewState extends State<TourismMapView>
    with _TourismMapStateHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: localization
        title: const Text('Tourism Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _locations.first.position,
              zoom: 10,
            ),
            markers: Set.from(_markers),
            polylines: Set.from(_polylines),
            myLocationEnabled: true,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _TourismPlacesSlider(
              locations: _locations,
              onItemTap: _onPlaceTapped,
            ),
          ),
        ],
      ),
    );
  }
}

mixin _TourismMapStateHelper on State<TourismMapView> {
  late GoogleMapController _mapController;
  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];
  final List<TourismMapModel> _locations = [
    const TourismMapModel(
      name: 'Sydney Opera House',
      description: 'Famous Sydney landmark',
      latitude: -33.8567844,
      longitude: 151.213108,
    ),
    const TourismMapModel(
      name: 'Sydney Harbour Bridge',
      description: 'Iconic bridge in Sydney',
      latitude: -33.852306,
      longitude: 151.210787,
    ),
    const TourismMapModel(
      name: 'Bondi Beach',
      description: 'Popular beach in Sydney',
      latitude: -33.890844,
      longitude: 151.274292,
    ),
  ];

  LatLng? _selectedPosition;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    for (final location in _locations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location.name),
          position: location.position,
          infoWindow: InfoWindow(
            title: location.name,
            snippet: location.description,
            onTap: () {
              _onMarkerTapped(location.position);
            },
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onPlaceTapped(LatLng position) {
    _mapController.animateCamera(
      CameraUpdate.newLatLng(
        position,
      ),
    );
    _onMarkerTapped(position);
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {
      if (_selectedPosition == null) {
        _selectedPosition = position;
      } else {
        _createPolyline(_selectedPosition!, position);
        _selectedPosition = null;
      }
    });
  }

  void _createPolyline(LatLng start, LatLng end) {
    final polylineId = PolylineId('${start}_$end');
    final polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      width: 5,
      points: [start, end],
    );

    setState(() {
      _polylines.add(polyline);
    });
  }
}
