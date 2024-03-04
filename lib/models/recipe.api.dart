import 'dart:convert' ;
import 'package:recipe_application/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi{

  static Future<List<Recipe>> getRecipe() async{

    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {'limit': '18', 'start': '0',  'tag': 'list.recipe.popular'});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '57c59be7a2msh69424112b152518p1689e8jsn20d13230751c',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      'useQueryString': 'true'

    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']){
      _temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(_temp);
  }
}