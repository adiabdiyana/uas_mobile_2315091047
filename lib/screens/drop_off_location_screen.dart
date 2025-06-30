import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropOffLocationScreen extends StatefulWidget {
  const DropOffLocationScreen({super.key});

  @override
  State<DropOffLocationScreen> createState() => _DropOffLocationScreenState();
}

class _DropOffLocationScreenState extends State<DropOffLocationScreen> {
  late GoogleMapController mapController;
  final List<TPALocation> _tpaLocations = [];
  Position? _currentPosition;
  bool _isLoading = true;

  // Koordinat default jika GPS tidak aktif
  final LatLng _defaultLocation = const LatLng(-8.409518, 115.188919); // Bali

  @override
  void initState() {
    super.initState();
    _loadTPALocations();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadTPALocations() async {
    // Data dummy TPA (bisa diganti dengan API)
    setState(() {
      _tpaLocations.addAll([
        TPALocation(
          name: 'TPA BANGLI',
          address: 'Kantor Perusahaan - J9W9-25W',
          rating: 2.7,
          reviewCount: 6,
          position: const LatLng(-8.4542, 115.3547),
        ),
        TPALocation(
          name: 'TPA Desa Buruan, Penebel',
          address: 'Gudang - G4OR-RRM, Ji, Buruan - Turipik',
          rating: null,
          reviewCount: 0,
          position: const LatLng(-8.5123, 115.1234),
        ),
        TPALocation(
          name: 'TPA Banaji',
          address: 'Tujuan Misata - J9X9-FH',
          rating: 4.8,
          reviewCount: 9,
          position: const LatLng(-8.3895, 115.2765),
        ),
        TPALocation(
          name: 'TPA Temesi',
          address: 'Tempat Pembuangan Sampahi - C9Q21-QXV',
          rating: 4.8,
          reviewCount: 17,
          position: const LatLng(-8.5678, 115.1987),
        ),
        TPALocation(
          name: 'TPA PLAY GROUP & TK ABC SINGARAJA',
          address: 'V38G+J9P, Jalan Ki Barak Parji, Gg. Salak.Parji Singaraja',
          rating: 5.0,
          reviewCount: 2,
          position: const LatLng(-8.1123, 115.0876),
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi TPA Terdekat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _getCurrentLocation();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition != null
                          ? LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude)
                          : _defaultLocation,
                      zoom: 12,
                    ),
                    markers: _buildMarkers(),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tpaLocations.length,
                    itemBuilder: (context, index) {
                      return _buildTPACard(_tpaLocations[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Set<Marker> _buildMarkers() {
    return _tpaLocations.map((tpa) {
      return Marker(
        markerId: MarkerId(tpa.name),
        position: tpa.position,
        infoWindow: InfoWindow(
          title: tpa.name,
          snippet: 'Rating: ${tpa.rating ?? 'Tidak ada rating'}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          tpa.rating != null
              ? (tpa.rating! > 3
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueOrange)
              : BitmapDescriptor.hueRed,
        ),
      );
    }).toSet();
  }

  Widget _buildTPACard(TPALocation tpa) {
    return GestureDetector(
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(tpa.position, 14),
        );
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tpa.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              tpa.address,
              style: TextStyle(color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (tpa.rating != null)
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(' ${tpa.rating} (${tpa.reviewCount})'),
                ],
              )
            else
              const Text('Tidak ada ulasan'),
          ],
        ),
      ),
    );
  }
}

class TPALocation {
  final String name;
  final String address;
  final double? rating;
  final int reviewCount;
  final LatLng position;

  TPALocation({
    required this.name,
    required this.address,
    this.rating,
    required this.reviewCount,
    required this.position,
  });
}