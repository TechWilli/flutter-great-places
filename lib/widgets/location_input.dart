import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    debugPrint('${locationData.latitude}');
    debugPrint('${locationData.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'Localização não informada',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: _getCurrentUserLocation,
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Icons.location_on),
                label: const Text('Localização atual'),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: null,
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Icons.map),
                label: const Text('Selecione no mapa'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
