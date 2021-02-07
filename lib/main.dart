

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_game/pokemon_list.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Pokedex Game",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue
      ),
     home: PokemonList(),
    );
  }
}