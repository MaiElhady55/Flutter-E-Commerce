import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/widgets/CustomButton.dart';

import '../consts/AppColors.dart';

class ProductDetailsScreen extends StatefulWidget {
  var product;
  ProductDetailsScreen({required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.product["product-name"],
      "price": widget.product["product-price"],
      "images": widget.product["product-img"],
    }).then((value) => print("Added to cart"));
  }

  Future addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.product["product-name"],
      "price": widget.product["product-price"],
      "images": widget.product["product-img"],
    }).then((value) => print("Added to favorite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.deep_orange,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users-favorite-items')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('items')
                  .where("name", isEqualTo: widget.product['product-name'])
                  .snapshots(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () =>snapshot.data.docs.length==0? addToFavorite():print('Aready Aded'),
                        icon:snapshot.data.docs.length==0? Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ):Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )),
                    backgroundColor: AppColors.deep_orange,
                  ),
                );
              }),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.product['product-img'],
                          ),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.product['product-name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Text(
                "\$ ${widget.product['product-price'].toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.product['product-description'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              customButton('Add to Cart', () => addToCart(), context)
            ],
          ),
        ));
  }
}
