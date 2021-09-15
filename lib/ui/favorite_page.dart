
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class FavoritePage extends StatelessWidget {

  List<String>listaComida = [];

  String fav_comida = '';

  FavoritePage(fav_comida);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Favorite Page"),
      ),
      body: Image.network(fav_comida,
      ),

    );
  }


}