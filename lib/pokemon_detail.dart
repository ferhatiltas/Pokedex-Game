import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex_game/model/pokedex.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }
  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
    PaletteGenerator.fromImageProvider(
        NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              height: MediaQuery.of(context).size.height * (2 / 3),
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Text(
                      widget.pokemon.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Boy : " + widget.pokemon.height, style:
                    TextStyle(fontSize: 20)
                    ),
                    Text(
                      "Kilo : " + widget.pokemon.weight, style:
                    TextStyle(fontSize: 20)
                    ),
                    Text(
                      "Türler",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.type
                          .map((tip) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                tip,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList(),
                    ),

                    Text(
                      "Önceki Evrim Hali",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.prevEvolution != null ?
                      widget.pokemon.prevEvolution.map((evolution) =>
                          Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                evolution.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList() : [Text("Evrimin İlk Hali", style:
                      TextStyle(fontSize: 20))],
                    ),

                    Text(
                      "Sonraki Evrim Türü",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.nextEvolution != null ?
                      widget.pokemon.nextEvolution.map((evolution) =>
                          Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                evolution.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList() : [Text("Evrimin Son Aşamasında")],
                    ),
                    Text(
                      "Zayıf Yönleri",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.weaknesses != null ?
                      widget.pokemon.weaknesses.map((weakness) =>
                          Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                weakness,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList() : [Text("Zayıflığı yok")],
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                height: 200,
                width: 200,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/loading.gif",
                  image: widget.pokemon.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
