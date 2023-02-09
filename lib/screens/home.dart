import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  List pokedex = [];

  @override
  void initState() {
    if (mounted) {
      fetchPokemonData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.4),
              itemCount: pokedex.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(
                    pokedex[index]['name'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future fetchPokemonData() async {
    Map<String, String> qParams = {'limit': '150', 'offset': '0'};
    var url = Uri.https("pokeapi.co", "/api/v2/pokemon", qParams);
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);

        pokedex = decodedJsonData['results'];
        print(pokedex[0]['name']);
        setState(() {});
      }
    });
  }
}
