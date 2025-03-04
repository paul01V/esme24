import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:swipezone/repositories/models/location.dart';

class MapPage extends StatefulWidget {
  final List<Location> selectedLocations;

  const MapPage({super.key, required this.selectedLocations});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController _mapController;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    for (var location in widget.selectedLocations) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(location.localization.latitude, location.localization.longitude),
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des lieux sélectionnés'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(48.8566, 2.3522), // Coordonnées de Paris par défaut
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: _markers,
          ),
        ],
      ),
    );
  }
}

