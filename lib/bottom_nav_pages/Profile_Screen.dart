import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/widgets/CustomButton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;


  setDataToTextField(data){
    return  Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        SizedBox(height:20),
        customButton( "Update", ()=>updateData(), context)
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,
        }
        ).then((value) => print("Updated Successfully"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      )),
    );
  }
}
