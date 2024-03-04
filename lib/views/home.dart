import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe.api.dart';
import 'package:recipe_application/views/widgets/recipe_card.dart';
import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/views/widgets/recipe_card.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

List<Recipe> _recipes;
bool _isLoading = true;

@override
void initState(){
  super.initState();

  getRecipes();
}

Future<void> getRecipes() async{
  _recipes = await RecipeApi.getRecipe();
  setState(() {
    _isLoading = false;
  });
  
}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Food Recipe')
        ],),
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator()) 
      : ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index){
          return RecipeCard(
            title: _recipes[index].name, 
            cookTime: _recipes[index].totalTime,
            rating: _recipes[index].rating.toString(), 
            thumbnailUrl: _recipes[index].images);
        }
      )
      
    );

  }
}