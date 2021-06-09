import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B-elevitating',
      theme: ThemeData(accentColor: Colors.amberAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quote of the day'),
        ),
        body: Center(
          child: FutureBuilder<Quote>(
            future: getQuote(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data!.text),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("-${snapshot.data!.author}"),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<Quote> getQuote() async {
  final response = await http.get(Uri.parse('https://type.fit/api/quotes'));

  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Quote {
  final String author;
  final String text;

  Quote({required this.author, required this.text});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(author: json['author'], text: json['quote']);
  }
}
