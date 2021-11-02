import 'dart:convert';
// import 'dart:math';
// import 'dart:developer';
// import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:bhuribhoj/model.dart';
import 'package:bhuribhoj/recipeview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;







class Search extends StatefulWidget {
 final String query;
 Search(this.query);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isloading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  // String url = "https://api.edamam.com/api/recipes/v2?type=public&q=chicken&app_id=c2aa4177&app_key=8f1ce1994a3908b29d0b0a325e5c68bc";
  // List <String> reclist = ["Ladoo","Chicken","Pulao","biriyani","mutton kosha", "malaikari"];
  List recipeCatlist = [
    {
      "imgUrl":
      "https://thumbs.dreamstime.com/b/different-spices-herbs-stone-table-top-view-ingredients-cooking-food-background-different-spices-herbs-black-120232209.jpg",
      "heading": "chilli food"
    },
    {
      "imgUrl":
      "https://thumbs.dreamstime.com/b/different-spices-herbs-stone-table-top-view-ingredients-cooking-food-background-different-spices-herbs-black-120232209.jpg",
      "heading": "chilli food"
    },
    {
      "imgUrl":
      "https://thumbs.dreamstime.com/b/different-spices-herbs-stone-table-top-view-ingredients-cooking-food-background-different-spices-herbs-black-120232209.jpg",
      "heading": "chilli food"
    },
    {
      "imgUrl":
      "https://thumbs.dreamstime.com/b/different-spices-herbs-stone-table-top-view-ingredients-cooking-food-background-different-spices-herbs-black-120232209.jpg",
      "heading": "chilli food"
    },
    {
      "imgUrl":
      "https://thumbs.dreamstime.com/b/different-spices-herbs-stone-table-top-view-ingredients-cooking-food-background-different-spices-herbs-black-120232209.jpg",
      "heading": "chilli food"
    }

  ];
  getRecipe(String search) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$search&app_id=c2aa4177&app_key=8f1ce1994a3908b29d0b0a325e5c68bc";
    var response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(data); // in flutter new version it will not print the all data so use log
    // log(data.toString());
    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      setState(() {
        isloading = false;
      });
      recipeList.add(recipeModel);
    });

    recipeList.forEach((recipe) {
      print(recipe.applabel);
    });
  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938),
                  ],
                ),
              ),
            ),

            /*
        * inkwell -  Tap,Double tap  many function etc
        *
        * Gesture Detector is used to taping function
        *
        * inkwell diff form GD - Hover , ontap splash
        *
        * card - elevation , background , radius
        *
        * ClipRRect - child - clip (different frame) {Round rectangle border}
        *
        * clipPath - Can make customised border
        *
        * Positioned  - Stack {is used to positioned any widget}
        *
        * */
            SingleChildScrollView(
              child: Column(
                children: [
                  // search bar
                  SafeArea(
                    child: Container(
                      //Search Container

                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                print("Blank search");
                              } else {
                                recipeList.clear();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Search(searchController.text),),);
                              }
                            },
                            child: Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value)
                              {
                                if ((searchController.text).replaceAll(" ", "") ==
                                    "") {
                                  print("Blank search");
                                } else {
                                  recipeList.clear();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Search(searchController.text),),);

                                }
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Let's Cook Something!"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "WHAT DO YOU WANT TO COOK TODAY ?",
                  //         style: TextStyle(
                  //           fontFamily: "Poppins",
                  //           fontSize: 25.0,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text(
                  //         "lET'S COOK SOMETHING NEW",
                  //         style: TextStyle(
                  //           fontFamily: "Poppins",
                  //           fontSize: 20.0,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    child: isloading ? CircularProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeView(recipeList[index].appurl,recipeList[index].applabel)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              margin: EdgeInsets.all(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      recipeList[index].appimageurl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                      ),
                                      child: Text(
                                        recipeList[index].applabel,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    width: 80,
                                    height: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 15,
                                            ),
                                            Text(
                                              recipeList[index]
                                                  .appcalories
                                                  .toString()
                                                  .substring(0, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  // Container(
                  //   height: 100,
                  //   child: ListView.builder(
                  //
                  //     itemCount: recipeCatlist.length,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Card(
                  //             margin: EdgeInsets.all(20),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(18),
                  //             ),
                  //             elevation: 0,
                  //             child: Stack(
                  //               children: [
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(18.0),
                  //                   child: Image.network(
                  //                     recipeCatlist[index]["imgUrl"],
                  //                     width: 200,
                  //                     height: 250,
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //                 Positioned(
                  //                     left: 0,
                  //                     right: 0,
                  //                     bottom: 0,
                  //                     top: 0,
                  //                     child: Container(
                  //
                  //                       padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(18.0),
                  //                         color: Colors.black26,
                  //                       ),
                  //                       child: Column(
                  //                         mainAxisAlignment: MainAxisAlignment.center,
                  //                         children: [
                  //                           Text(recipeCatlist[index]["heading"],
                  //                             style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: 28.0
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
    );
  }

}


