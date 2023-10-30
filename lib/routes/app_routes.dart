// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_great_places/pages/place_form.dart';
import 'package:flutter_great_places/pages/places_list_page.dart';

abstract class AppRoutes {
  static const String HOME = '/';
  static const String PLACE_FORM = '/place-form';

  static Map<String, WidgetBuilder> routes = {
    HOME: (_) => const PlacesListPage(),
    PLACE_FORM: (_) => const PlaceForm()
  };
}
