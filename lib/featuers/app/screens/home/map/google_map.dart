import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_car_park/featuers/app/controllers/park_controller.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final parkController = ParkController.instance;

  Location locationControler = Location();

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationControler.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await locationControler.requestService();
    } else {
      return;
    }

    permissionGranted = await locationControler.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationControler.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        return;
      }
    }

    locationControler.onLocationChanged.listen((LocationData current) {
      if (current.latitude != null && current.longitude != null) {
        setState(() {
          parkController.currentLocation = LatLng(current.latitude!, current.longitude!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return parkController.isLoading.value == true || parkController.currentLocation == null
        ? const Center(child: CircularProgressIndicator())
        : Obx(
            () => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: parkController.currentLocation!,
                zoom: 17,
              ),
              markers: parkController.allParks.map((element) {
                final ParkModel park = element;
                final LatLng latLng = park.getLatLong; // Capture element locally
                return Marker(
                  markerId: MarkerId(park.name),
                  position: latLng,
                  onTap: () {
                    // print('Marker at ${park.name}');
                  },
                );
              }).toSet(),
            ),
          );
  }
}
