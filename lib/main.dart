import 'dart:convert';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/pages/registration.dart';
import 'package:sum_parking/pages/splash_screen.dart';
import 'package:sum_parking/providers/auth.dart';
import 'package:sum_parking/providers/reservations.dart';
import 'helpers/custom_route.dart';
import 'pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_parking/pages/create_reservation.dart';
import './pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ChangeNotifierProxyProvider<Auth, ParkingSpaces>(
        //     builder: (ctx, auth, prevProducts) => Products(auth.token, prevProducts == null ? [] : prevProducts.items, auth.userId),
        //   ),
        ChangeNotifierProxyProvider<Auth, Reservations>(
          update: (ctx, auth, prevRes) => Reservations(
              prevRes == null ? [] : prevRes.items,
              auth.authToken,
              auth.user_id),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
            title: 'SUM sParking',
            theme: ThemeData(
              primaryColor: Colors.lightBlue[100],
              //accentColor: Colors.cyan,
              scaffoldBackgroundColor: Colors.lightBlue[100],
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                },
              ),
            ),
            home: auth.isAuth
                ? MainPage()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : LoginPage(),
                  ),
            routes: {
              Registration.routeName: (ctx) => Registration(),
              ParkingInformation.routeName: (ctx) => ParkingInformation(),
              CreateReservation.routeName: (ctx) => CreateReservation(),
            }),
      ),
    );
  }
}
