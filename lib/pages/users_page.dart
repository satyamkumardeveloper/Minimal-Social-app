import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_back_button.dart';
import 'package:social_app/components/my_list_tile.dart';
import 'package:social_app/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            displayMessageToUser("Something went wrong", context);
          }

          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data==null) {
            return const Text("No Data");

          }

          final users=snapshot.data!.docs;
          return Column(
            children: [

              // back button 
              const  Padding(
                  padding:  EdgeInsets.only(left: 25.0,top: 50),
                  child: Row(children: [ MyBackButton()]),
                ),

              const SizedBox(height: 10,),


              //list of users in the app
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: users.length,
                  itemBuilder: (context,index){
                    final user=users[index];

                    //get data form each user
                    String title=user['username'];
                    String email=user['email'];

                    //return each user
                    return MyListTile(title: title, subTitle: email);
                  },
                ),
              ),
            ],
          );
        },
      )
    );
  }
}