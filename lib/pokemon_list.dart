import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_game/model/pokedex.dart';
import 'package:pokedex_game/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;
  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri=pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder(
          future:veri,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
            if (gelenPokedex.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (gelenPokedex.connectionState == ConnectionState.done) {
              // GridView.Builder Yöntemi
              // return GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     itemBuilder: (context, index) {
              //
              //       return Center(child: Text(gelenPokedex.data.pokemon[index].name));
              //     });

              // GridView.count Yöntemi
              return Padding(
                padding: EdgeInsets.all(10),
                child: GridView.extent(
                  maxCrossAxisExtent: 300,
                  children: gelenPokedex.data.pokemon.map((poke) {
                    return InkWell(
                      splashColor: Colors.blue,
                      child: Hero(
                          tag: poke.img,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: FadeInImage.assetNetwork( //FadeInImage.assetNetwork avantajı resim yüklenene kadar placeHolder kısmına gif vs atabiliriz
                                      placeholder: "assets/loading.gif", image: poke.img,fit: BoxFit.cover,),
                                ),
                                Text(poke.name,style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          )),
                      onTap: (){ // PokemonDEtail sınıfında pokemon.this sayesinde buradan oraya veri göndereceğiz
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokemonDetail(pokemon: poke,)));
                      },
                    );
                  }).toList(),
                ),
              );
            }
          }),
    );
  }
}
