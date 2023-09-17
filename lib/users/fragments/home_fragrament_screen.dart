import 'dart:convert';

import 'package:clothes/consts/consts.dart';
import 'package:clothes/consts/lists.dart';
import 'package:clothes/users/cart/cart_list_screen.dart';
import 'package:clothes/users/item/item_details_screen.dart';
import 'package:clothes/users/item/search_items.dart';
import 'package:clothes/users/model/Clothes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../api/api_connect.dart';

class HomeFragmentScreen extends StatelessWidget {
  HomeFragmentScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();


  //get all popular or trending items/product
  Future<List<Clothes>> getTrendingClothItems() async{

    List<Clothes> trendingClothItemList = [];

    try{
      
     var res = await http.post(
        Uri.parse(API.getRatedClothes),
      );

     if(res.statusCode == 200){
       var responseBodyOfTrendingItems = jsonDecode(res.body);


       if(responseBodyOfTrendingItems["success"]==true){
         (responseBodyOfTrendingItems["clothItemsData"] as List).forEach((eachRecord) { 
           trendingClothItemList.add(Clothes.fromJson(eachRecord));
         });
       }

     }else{
       Fluttertoast.showToast(msg: "Error on the server");
     }

    }catch(e){
      print("Error::"+ e.toString());
    }
    return trendingClothItemList;
  }

  Future<List<Clothes>> getAllClothItems() async{

    List<Clothes> allClothItemList = [];

    try{

      var res = await http.post(
        Uri.parse(API.getAllClothes),
      );
      if(res.statusCode == 200){
        var responseBodyOfAllItems = jsonDecode(res.body);

        if(responseBodyOfAllItems["success"]==true){
          (responseBodyOfAllItems["clothItemsData"] as List).forEach((eachRecord) {
            allClothItemList.add(Clothes.fromJson(eachRecord));
          });
        }

      }else{
        Fluttertoast.showToast(msg: "Error on the server");
      }

    }catch(e){
      print("Error::"+ e.toString());
    }
    return allClothItemList;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16,),


 


          //search bar widget
          showSearchBarWidget(),

          20.heightBox,

          //Swiper brands
          VxSwiper.builder(
            aspectRatio: 16 / 9,
            autoPlay: true,
            height: 150,
            enlargeCenterPage: true,
            itemCount: slidersListnew.length, 
            itemBuilder: (context, index)
            {
              return Image.asset(
                slidersListnew[index],
                fit: BoxFit.fill,
              ).box.rounded.shadowXs.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
            }
          ),

          const SizedBox(height: 24,),
          //tending-popular items
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Trending",
              style: TextStyle(
                color: darkFontGrey,
                fontFamily: bold,
                fontSize: 20,
              ),
            ),
          ),
          16.heightBox,
          trendingMostPopularClothesItemWidget(context),


          const SizedBox(height: 24,),
          //all new Collection Items
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Products",
              style: TextStyle(
                color: darkFontGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16,),
          allItemsWidget(context),
        ],
      ),
    );
  }


  //search bar
 Widget showSearchBarWidget(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: IconButton(
            onPressed: (){

              Get.to(() => SearchItems(typeKeywords: searchController.text));

            },
            icon: const Icon(
              Icons.search,
              color: Colors.black45,
            ),
          ),
          hintText: "Search HGT products here",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          suffixIcon: IconButton(
            onPressed: (){
              Get.to(() => const CartListScreen());
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: textfieldGrey,
            )
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: textfieldGrey,
              )
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.lightBlueAccent,
              )
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10
          ),
          //filled: true,
          //fillColor: Colors.grey
        ),
      ),
    );
  }

  //popular clother
  Widget trendingMostPopularClothesItemWidget(context){
    return FutureBuilder(
        future: getTrendingClothItems(),
        builder: (context, AsyncSnapshot<List<Clothes>> dataSnapShot){
          //check of we have network
          if(dataSnapShot.connectionState ==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
          
         // print(dataSnapShot.data);

          //check if data is empty
          if(dataSnapShot.data == null){
            return const Center(
              child: Text(
                "No Trending item found"
              ),
            );
          }

          //check if the legnth of data
          if(dataSnapShot.data!.length > 0 ){

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////          
            return Container(
              decoration: const BoxDecoration(color: redColor),
              height: 260,
              child: ListView.builder(
                itemCount: dataSnapShot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    Clothes eachClothItemData =  dataSnapShot.data![index];

                    return GestureDetector(
                      onTap: (){

                        Get.to(() => ItemDetailsScreen(itemInfo: eachClothItemData));

                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.fromLTRB(
                            index==0 ? 16 : 8,
                            10,
                            index == dataSnapShot.data!.length -1 ? 16 : 8,
                            10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white12,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0,3),
                              blurRadius: 6,
                              color: Colors.grey,
                            ),
                          ]

                        ),
                        child: Column(
                          children: [
                            //clothes images
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22),
                              ),
                              child: FadeInImage(
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage("images/place_holder.png"),
                                  image: NetworkImage(API.IMAGE + eachClothItemData.image!),
                                imageErrorBuilder: (context,error,stackTraceError){
                                    return const Center(
                                      child: Icon(
                                        Icons.broken_image_outlined,
                                      ),
                                    );
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //name and price of items
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          eachClothItemData.name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "₱"+eachClothItemData.price.toString().numCurrency,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8,),

                                  Row(
                                    children: [
                                      //rating star and rating number
                                      RatingBar.builder(
                                        initialRating: eachClothItemData.rating!,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (BuildContext context, int index) =>
                                           const Icon(
                                              Icons.star,
                                              color: Colors.yellowAccent,
                                            ),
                                        onRatingUpdate: (updatingRating){
                                        },
                                        ignoreGestures: true,
                                        unratedColor: Colors.white,
                                        itemSize: 20,
                                      ),
                                        SizedBox(width: 8,),
                                      Text(
                                        "("+ eachClothItemData.rating.toString()+")",
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],

                              ),
                            ),
                          ],
                        ),
                      ) ,

                    );

                  }),
            );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          }else{
            return const Center(
              child: Text("Empty, No data"),
            );
          }
        },
    );
  }

  Widget allItemsWidget(context){

  return FutureBuilder(
      future: getAllClothItems(),
      builder: (context, AsyncSnapshot<List<Clothes>> dataSnapShot) {
        //check of we have network
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //check if data is empty
        if (dataSnapShot.data == null) {
          return const Center(
            child: Text(
                "No item found"
            ),
          );
        }


        if(dataSnapShot.data!.length > 0){

          return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataSnapShot.data!.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    mainAxisSpacing: 8, 
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300
                  ), 
                  itemBuilder: (context,index)
                  {
                    Clothes eachClothItemRecord = dataSnapShot.data![index];
                    
                    return GestureDetector(
                      onTap: (){
                        Get.to(() => ItemDetailsScreen(itemInfo: eachClothItemRecord));
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInImage(
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage("images/place_holder.png"),
                              image: NetworkImage(API.IMAGE + eachClothItemRecord.image!),
                            ),
                            
                            const Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: eachClothItemRecord.name!.text.center.fontFamily(bold).color(darkFontGrey).make()
                            ),
                            const Spacer(),
                            10.heightBox,
                            //////////////////////////////////////////////////////////////////////////////.
                            // "600".text.color(redColor).fontFamily(bold).size(16).make(),
                            Row(
                              children: [
                                Text(
                                  "Tags: \n "+eachClothItemRecord.tags.toString().replaceAll("[", "").replaceAll("]", ""),
                                ),
                              ],
                            ),
                            
                            Text(
                              "₱"+eachClothItemRecord.price.toString().numCurrency,
                              style: const TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                      ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make(),
                    );
                  },
          );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // return GridView.builder(
          //     itemCount: dataSnapShot.data!.length,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     scrollDirection: Axis.vertical,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2, 
          //               mainAxisSpacing: 8, 
          //               crossAxisSpacing: 8,
          //               mainAxisExtent: 300
          //             ), 
          //     itemBuilder: (context,index){
          //       Clothes eachClothItemRecord = dataSnapShot.data![index];

          //       return GestureDetector(
          //         onTap: (){
          //           Get.to(() => ItemDetailsScreen(itemInfo: eachClothItemRecord));
          //         },
          //         child: Container(
          //           margin: EdgeInsets.fromLTRB(
          //             16,
          //               index == 0 ? 16 : 8 ,
          //             16,
          //             index == dataSnapShot.data!.length - 1 ? 16 : 8 ,
          //           ),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               color: Colors.black,
          //               boxShadow: const [
          //                 BoxShadow(
          //                   offset: Offset(0,0),
          //                   blurRadius: 6,
          //                   color: Colors.grey,
          //                 ),
          //               ]

          //           ),
          //           child: Row(
          //             children: [
          //               //name + price + tags
          //               Expanded(
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(left: 15),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         //name and price
          //                         Row(
          //                           children: [
          //                             //name
          //                             Expanded(
          //                               child: Text(
          //                                 eachClothItemRecord.name!,
          //                                 maxLines: 2,
          //                                 overflow: TextOverflow.ellipsis,
          //                                 style: const TextStyle(
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 16,
          //                                   color: Colors.grey,
          //                                 ),
          //                             ),
          //                             ),
          //                             Padding(
          //                               padding: const EdgeInsets.only(left:12,right: 12),
          //                               child: Text(
          //                                 "₱"+eachClothItemRecord.price.toString().numCurrency,
          //                                 maxLines: 2,
          //                                 overflow: TextOverflow.ellipsis,
          //                                 style: const TextStyle(
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 16,
          //                                   color: Colors.purpleAccent,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         const SizedBox(height: 16,),
          //                         Text(
          //                           "Tags: \n "+eachClothItemRecord.tags.toString().replaceAll("[", "").replaceAll("]", ""),
          //                           maxLines: 2,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: const TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 12,
          //                             color: Colors.grey,
          //                           ),
          //                         ),

          //                       ],
          //                     ),

          //           ),
          //               ),

          //               //images clothes
          //               ClipRRect(
          //                 borderRadius: const BorderRadius.only(
          //                   bottomRight: Radius.circular(20),
          //                   topRight: Radius.circular(20),
          //                 ),
          //                 child: FadeInImage(
          //                   height: 130,
          //                   width: 130,
          //                   fit: BoxFit.cover,
          //                   placeholder: const AssetImage("images/place_holder.png"),
          //                   // image: NetworkImage(
          //                   //   eachClothItemRecord.image!,
          //                   // ),
          //                   image: NetworkImage(API.IMAGE + eachClothItemRecord.image!),
          //                   imageErrorBuilder: (context,error,stackTraceError){
          //                     return const Center(
          //                       child: Icon(
          //                         Icons.broken_image_outlined,
          //                       ),
          //                     );
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          // );
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        }
        else {
          return const Center(
            child: Text("Empty, No data"),
          );
        }
      }
    );
  }

}
