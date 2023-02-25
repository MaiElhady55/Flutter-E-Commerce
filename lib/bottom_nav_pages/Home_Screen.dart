import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/consts/AppColors.dart';
import 'package:flutter_e_commerce/screens/Products_Details_Screen.dart';
import 'package:flutter_e_commerce/screens/Search_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> _carsouelImages = [];
  List<Map<String, dynamic>> _productList = [];
  List<Map<String, dynamic>> _categoryList = [];
  int _currentIndexPage = 0;
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carsouelImages.add(
          qn.docs[i]["img"],
        );
        //print(qn.docs[i]["img"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (var i = 0; i < qn.docs.length; i++) {
        _productList.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-image"],
        });
      }
    });
    return qn.docs;
  }

  fetchCategories() async {
    QuerySnapshot qn = await _firestoreInstance.collection('categories').get();
    setState(() {
      for (var i = 0; i < qn.docs.length; i++) {
        _categoryList.add({
          'image': qn.docs[i]['image'],
          'categoryName': qn.docs[i]['category-name']
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                  readOnly: true,
                  controller: _searchController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Search products here",
                      hintStyle: TextStyle(fontSize: 15),
                      suffixIcon: Icon(
                        Icons.search,
                        //color: AppColors.deep_orange,
                      )),
                  onTap: () {
                    Navigator.of(context).pushNamed(SearchScreen.routeName);
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            AspectRatio(
              aspectRatio: 3.20, //3.5
              child: CarouselSlider(
                  items: _carsouelImages
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover)),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 500),
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _currentIndexPage = val;
                        });
                      })),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotsIndicator(
                  dotsCount:
                      _carsouelImages.length == 0 ? 1 : _carsouelImages.length,
                  position: _currentIndexPage.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: AppColors.deep_orange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text(
                "Categories",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:Border.all(
                              color: Colors.grey
                            )
                          ),
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              _categoryList[index]["image"],
                            ),
                            
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "${_categoryList[index]["categoryName"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8),
              child: Text(
                "New Products",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _productList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: (() => Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return ProductDetailsScreen(
                                  product: _productList[index]);
                            })))),
                        child: Container(
                          width: 150,
                          height: 100,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 80,
                                      height: 80,
                                      child: Image.network(
                                        _productList[index]["product-img"],
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "${_productList[index]["product-name"]}",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "\$ ${_productList[index]["product-price"].toString()}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }))),
          ],
        ),
      )),
    );
  }
}
