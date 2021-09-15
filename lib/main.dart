import 'package:flutter/material.dart';

import 'package:lista_comida/ui/home_page.dart';
import 'package:lista_comida/ui/favorite_page.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.deepOrange),
  ));
}

