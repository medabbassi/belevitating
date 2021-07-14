import 'dart:async';
import 'dart:convert';
import 'package:belevitating/screens/character_list.dart';
import 'package:flutter/foundation.dart';
import 'package:belevitating/data/quote_api.dart';
import 'module/qoute.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   debugShowCheckedModeBanner: false,
   title: "B-elevetating",
   theme: ThemeData(primarySwatch: Colors.red),
   home: CharacterList(),
  );
 }
}

