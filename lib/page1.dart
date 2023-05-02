import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart'as http;
class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List iconwithname = [ ];

int select=0;

bool showgrid=true;
bool selectedbutton1=false;
bool selectedbutton2=false;


  void Item(int index) {
    setState(() {
      select= index;
    });
  }
  getData(String texxt)async{
    final url="https://service-zedzat.tequevia.com/api/v1/zedzat/product-category/?category_type=${texxt}";
    String tokens="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgzMDkwNzU0LCJqdGkiOiJiYmVkODA4NWNhOTI0Zjk1YThhM2E5ZWE4NzI5M2MwNyIsInVzZXJfaWQiOiI3YzNhNDJjZS00Zjg5LTQ2ZmMtYmRlZC03YjMyMjBkNWYwZGQifQ.7DsClWyQ7pKij_X9GLXBIahYLqtsz7W5-AEiJF89epU";

    var response=await http.get(Uri.parse(url),
      headers: {'Authorization':'Bearer $tokens'},
    );
    if(response.statusCode==200){
      var body=json.decode(response.body);
      setState(() {
        iconwithname=body;
        print("Icons${iconwithname}");
      });

    }else{
      print("Request faile with statatus ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black54,size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined,color: Colors.black54,size: 30),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard,color: Colors.black54,size: 30,),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined,color: Colors.black54,size: 30,),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,color: Colors.black54,size: 30),
            label: 'Profile',
          ),

        ],
        currentIndex: select,
        selectedItemColor: Colors.black,
        onTap: Item,
        unselectedItemColor: Colors.black54,
      ),


      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
              children: [
                SizedBox(height: 70,),
            Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10,),
                Text(
                  "ZEDZAT",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  "Govindapuram,Kozhikod,Kerala,India",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 20,),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 400),
              ),
              items: [
                "image/ac.jpg","image/ph.jpg",
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('$i'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextButton(onPressed: (){
                      setState(() {
                        getData("product");
                        showgrid=true;
                      });
                    },
                    child: Text("Product",style: TextStyle(fontSize: 10, color: Colors.white),),)
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextButton(onPressed: (){
                      setState(() {
                        getData("service");
                        showgrid=true;
                      });
                    },
                      child: Text("Service",style: TextStyle(fontSize: 10, color: Colors.white),),)
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            if(showgrid)
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 4, crossAxisSpacing: 7, mainAxisSpacing: 70),
                itemCount: iconwithname.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:NetworkImage(iconwithname[index]['category_image']),
                      ),
                      SizedBox(height: 10,),
                      Text(iconwithname[index]['category_name'],style: TextStyle(fontSize: 12),),
                    ],
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
