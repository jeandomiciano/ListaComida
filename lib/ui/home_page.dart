import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  String fav_comida = '';

  String q='';

  List listaComida = [];

  int _offset = 0;

  Future<Map> _getComida() async {
   http.Response response;

   if(q == '')
     response = await http.get("https://forkify-api.herokuapp.com/api/search?q=pizza");
   else
     response = await http.get("https://forkify-api.herokuapp.com/api/search?q=$q");

   return json.decode(response.body);

  }



  @override
  void initState() {
    super.initState();

    _getComida().then((map){
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.deepOrange,
        title: Text('Receitas', style: TextStyle(fontSize: 40),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage(fav_comida)));
            },
          ),
        ],
    ),

    backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise aqui",
                  labelStyle: TextStyle(color: Colors.deepOrange),
                  border: OutlineInputBorder()
              ),
              style: TextStyle(color: Colors.deepOrange, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  q = text;
                });
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
                future: _getComida(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if(snapshot.hasError) return Container();
                      else return _createComidaTable(context, snapshot);
                  }
                }
            ),
          ),

        ],
      ),
    );
  }



  Widget _createComidaTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 10,
        itemBuilder: (context, index){
          return GestureDetector(
            child: GestureDetector(
              onDoubleTap: (){
                print(snapshot.data["recipes"][index]);
                this.fav_comida=(snapshot.data["recipes"][index]["image_url"]);
                print(fav_comida);
                listaComida.add(fav_comida);
              },
              child: Image.network(snapshot.data["recipes"][index]["image_url"],
                height: 300.0,
                fit: BoxFit.cover,),
            )
          );
        }
    );
  }
}