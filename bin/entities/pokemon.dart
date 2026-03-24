import 'dart:convert';

import 'package:http/http.dart' as http;

class Pokemon{
  int idpokemon = -1;
  String nombre = "";
  String tipo1 = "";
  String? tipo2 = "";
  int ataque = 0; 
  int defensa = 0;
  int hp = 0;
  int velocidad = 0;
  int ataqueesp = 0;
  int defensaesp = 0;

  Pokemon({required this.idpokemon, 
    required this.nombre, 
    required this.tipo1, 
    this.tipo2, 
    required this.ataque, 
    required this.defensa, 
    required this.hp, 
    required this.velocidad, 
    required this.ataqueesp, 
    required this.defensaesp});

  Pokemon.fromApi(Map<String,dynamic> data){
    idpokemon = data["id"] ?? -1;
    nombre = data["name"]  ?? "";
    tipo1 = data["types"][0]["type"]["name"]  ?? "";
    if(data["types"].length > 1) {
      tipo2 = data["types"][1]["type"]["name"];
    }
    hp = data["stats"][0]["base_stat"] ?? 0;
    ataque = data["stats"][1]["base_stat"] ?? 0;
    defensa = data["stats"][2]["base_stat"] ?? 0;
    ataqueesp = data["stats"][3]["base_stat"] ?? 0;
    defensaesp = data["stats"][4]["base_stat"] ?? 0;
    velocidad = data["stats"][5]["base_stat"] ?? 0;
  }
  
  
  static Future<Pokemon> obtenerPokemon (String identificador) async{
      var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$identificador");
      var response = await http.get(url);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        Pokemon pokemon = Pokemon.fromApi(data);
        return pokemon;
      }else{
        print("Error: algo ha ido mal al obtener el pokemon");
      }
  }

}