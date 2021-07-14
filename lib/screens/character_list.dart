import 'dart:convert';

import 'package:belevitating/module/qoute.dart';
import 'package:flutter/material.dart';
import 'package:belevitating/data/quote_api.dart';

class CharacterList extends StatefulWidget {
  CharacterList({Key? key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  List<Quote> characterList = <Quote>[];

  void getCharactersfromApi() async {
    CharacterApi.getQuotes().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        characterList = list.map((model) => Quote.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCharactersfromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Breaking Bad Characters"),
        ),
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.all(5.0),
              itemCount: characterList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(characterList[index].text),
                  subtitle: Text(characterList[index].author??"NaN"),

                );
              }),
        ));
  }
}