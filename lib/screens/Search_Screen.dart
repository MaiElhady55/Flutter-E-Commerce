import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/screens/Products_Details_Screen.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'Search Screen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
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
              onChanged: ((value) {
                setState(() {
                  inputText = value;
                });
              }),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('product-name', isGreaterThanOrEqualTo: inputText)
                      .snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    final docs = snapshot.data!.docs;
                    if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(docs[index]['product-name']),
                              leading:
                                  Image.network(docs[index]['product-image']),
                            ),
                          );
                        }));
                  })),
            ))
          ],
        ),
      )),
    );
  }
}
