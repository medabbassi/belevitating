import 'dart:convert';

import 'package:belevitating/module/qoute.dart';
import 'package:flutter/material.dart';
import 'package:belevitating/data/quote_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

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
  void _shareFuntion(String value1){
    Share.share(value1);
  }
  bool _isLiked = true;
  void _toogleLike(){
    setState(() {
      if(_isLiked){
        _isLiked = false;
      }
      else {
        _isLiked =true;
      }
    });
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
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .45,
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 0),
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      topBar(),
                      SizedBox(height: 10.0),
                      characterList.length>0 ?
                      Expanded(
                          child:ListView.builder(
                          padding: EdgeInsets.all(5.0),
                          itemCount: characterList.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 550,
                              child: Card(
                                borderOnForeground: true,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: _toogleLike,
                                          icon:(_isLiked ?
                                          Icon(Icons.favorite_border_outlined ):
                                          Icon(Icons.favorite,color: Colors.pinkAccent,)),
                                            //Icons.favorite_border_outlined
                                        ),
                                      ),
                                      Text("\" " + characterList[index].text +" \"" ,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.robotoCondensed(
                                              fontSize: 50,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold)),

                                      /*Text(characterList[index].text,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style:GoogleFonts.robotoCondensed(fontSize: 50,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),*/
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(characterList[index].author ?? "NaN",
                                      style: GoogleFonts.roboto(fontWeight: FontWeight.w700),),
                                      SafeArea(
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ))),
                                      SizedBox(height: 10,),
                                      IconButton(
                                          onPressed: (){
                                            _shareFuntion(characterList[index].text);
                                          },
                                          icon: Icon(
                                            Icons.share,
                                            size: 30,  ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      ) :Container()

                    ],

                  ),
                ))
          ],
        ));
  }

  Widget topBar() {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context){
          return IconButton(
              onPressed: ()=>{},
              icon: Icon(Icons.menu, color:Colors.white,size: 40,));
        },
      ),
      title: Text('All Quotes',style: GoogleFonts.raleway(
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.w800),
          ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
