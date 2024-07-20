
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_drawer.dart';
import 'package:social_app/components/my_list_tile.dart';
import 'package:social_app/components/my_post_button.dart';
import 'package:social_app/components/my_textFeild.dart';
import 'package:social_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firebase access
  final FirestoreDatabase database=FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController() ;


  //post message 
  void postMessage(){
    // only post message if there is something in the textfirld
    if(newPostController.text.isNotEmpty){
      String message=newPostController.text;
      database.addPost(message);
    }

    //clear the controller
    newPostController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("W A L L")),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleSpacing: 0,
      ),
      drawer: MyDrawer(),
      body: Column(children: [


        //textfeild for user to type
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              //textfeild
              Expanded(child: MyTextfeild(hintText: "Say something", obscureText: false, controller: newPostController)),

              //postButton
              MyPostButton(
                onTap: postMessage)
            ],
          ),
        ),

        //posts//
        StreamBuilder(stream: database.getPostStream(), builder: (context,snapshot){

          //show laoding cycle
          if( snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: 
            CircularProgressIndicator());
          }


          //get all posts
          final posts=snapshot.data!.docs;


          //no data?
          if(snapshot.data==null || posts.isEmpty){
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text("No Posts avoilable."),
              ),
             );
          }


          //return as a list

          return Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context,index){
                //get each indivisula posts
                final post=posts[index];


                //get data from each posts
                String message=post['PostMessage'];
                String userEmail=post['UserEmail'];
                Timestamp timestamp=post['TimeStamp'];


                //return as a list tile
                return MyListTile(title: message, subTitle: userEmail);
              }),
          );




        })
      ],),
    );
  }
}