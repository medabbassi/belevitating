import 'dart:convert';

import 'package:belevitating/module/qoute.dart';
import 'package:flutter/material.dart';
import 'package:belevitating/data/quote_api.dart';
import 'package:google_fonts/google_fonts.dart';

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
    print(characterList.length.toString());
  }

  @override
  void initState() {
    super.initState();
    getCharactersfromApi();
    //print(characterList.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: characterList.length,
                itemBuilder: (context, index) {
                  return Card(

                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.favorite_border_outlined
                          ),
                        ),
                        Text(characterList[index].text,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style:GoogleFonts.robotoCondensed(fontSize: 50,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Text(characterList[index].author??"NaN"),
                        SafeArea(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                             horizontal: 20,)
                          )
                        )
                      ],
                    ),
                  );
                }),
          ),
        ));
  }
  Widget  clipper(){
    return Text(
      ''
    );
  }
}