import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_great_places/database/database.dart';
import 'package:flutter_great_places/models/place_model.dart';

typedef PlacesList = List<Place>;

class GreatPlaceProvider with ChangeNotifier {
  PlacesList _items = [];

  Future<void> loadPlaces() async {
    final dataList = await Database.getData(table: 'places');
    _items = dataList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image']),
            location: null,
          ),
        )
        .toList();

    notifyListeners();
  }

  PlacesList get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  void addPlace({required String title, required File image}) {
    final Place newPlace = Place(
      id: Random().nextDouble().toString(),
      image: image,
      title: title,
      location: null,
    );

    _items.add(newPlace);

    Database.insert(table: 'places', data: {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    notifyListeners();
  }
}
