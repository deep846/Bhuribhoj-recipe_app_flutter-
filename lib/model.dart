// import 'package:flutter/material.dart';
class RecipeModel
{
late String applabel;
late String appimageurl;
late double appcalories;
late String appurl;

RecipeModel({this.applabel = "Lable",this.appcalories = 0,this.appimageurl = "Image",this.appurl="URL"});
factory RecipeModel.fromMap(Map recipe)
{
  return RecipeModel(
    applabel: recipe["label"],
    appcalories: recipe["calories"],
    appimageurl: recipe["image"],
    appurl: recipe["url"]

  );
}

}