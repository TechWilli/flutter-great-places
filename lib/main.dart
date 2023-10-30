// para funcionar as chamadas http feitas no app, não sei se é assim sempre, mas estou precisando usar para pegar imagens via url
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_great_places/my_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
