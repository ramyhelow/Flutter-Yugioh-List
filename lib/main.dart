import 'package:flutter/material.dart';
import 'package:yugioh_cards/screens/home.dart';
import 'package:yugioh_cards/screens/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes:{
    '/': (context) => LoadingScreen(),
    '/home': (context) => HomeScreen(),
  }

));