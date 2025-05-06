part of '../maps.dart';

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.4223, -122.0848),
        ),
      ),
    );
  }
}
