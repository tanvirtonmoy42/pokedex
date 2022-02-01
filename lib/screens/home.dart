import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_starter/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_starter/widgets/poke_card.dart';

/*
  * you'll need this:
  static const String url = 'https://pokeapi.co/api/v2/pokemon/';
*/

class HomeScreen extends StatefulWidget {
  static const String url = 'https://pokeapi.co/api/v2/pokemon/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pokemons pokemons;

  _fetchData() async {
    final response = await http.get(HomeScreen.url);
    final decode = json.decode(response.body);
    final data = Pokemons.fromJson(decode['results']);
    setState(() {
      pokemons = data;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/pikachu.png',
              height: 50,
              width: 50,
            ),
            Text(
              'Pokédex',
            ),
          ],
        ),
      ),
      body: pokemons == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                  pokemons.pokemons.length,
                  (index) => PokeCard(
                        pokeURL: pokemons.pokemons[index].url,
                      )),
            ),
    );
  }
}
