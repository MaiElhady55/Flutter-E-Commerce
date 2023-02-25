import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/consts/AppColors.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users-cart-items')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('items')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  //final docs = snapshot.data!.docs;
                  if (snapshot.hasError) {
                    return Center(child: Text('Something Went Wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Text(_documentSnapshot['name']),
                            title: Text(
                              "\$ ${_documentSnapshot['price']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            trailing: GestureDetector(
                              child: CircleAvatar(
                                backgroundColor:  Colors.red,
                                child: Icon(Icons.remove_circle,color: Colors.white),
                              ),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('users-cart-items')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection("items")
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),
                        );
                      }));
                })));
  }
}
