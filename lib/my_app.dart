import 'package:flutter/material.dart';
import 'package:flutter_great_places/providers/great_place_provider.dart';

import 'package:flutter_great_places/routes/app_routes.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaceProvider(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.indigo,
                secondary: Colors.amber,
              ),
          scaffoldBackgroundColor: Colors.grey.shade100,
        ),
        initialRoute: AppRoutes.HOME,
        routes: AppRoutes.routes,
      ),
    );
  }
}
