import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //create logged in user
  User? currentUser=FirebaseAuth.instance.currentUser;


  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
    .collection("Users")
    .doc(currentUser!.email)
    .get();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(future: getUserDetails(), builder: (context,snapshot){
        //loading circle
        if(snapshot.connectionState==ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        

        //error display
        else if(snapshot.hasError){
          return Text("Error: ${snapshot.error}");
        }
        

        //data recived
        else if(snapshot.hasData){
          //extract data
          Map<String ,dynamic>? user =snapshot.data!.data();

          return Center(
            child: Column(
             
              
              children: [


              const  Padding(
                  padding: const EdgeInsets.only(left: 25.0,top: 50),
                  child: Row(children: [const MyBackButton()]),
                ),

              const  SizedBox(height: 25,),

                //person
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: const EdgeInsets.all(25),

                  child:const Icon(Icons.person,size: 65,),
                ),

               const SizedBox(height: 25,),
                //username
                Text(user!['username'],
                style:const TextStyle(fontSize: 24,
                fontWeight: FontWeight.bold),),




                //email
                Text(user['email'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]
                ),),

                
              ],
            ),
          );
        }

        else{
          return const Text("No Data");
        }
      }),
    );
  }
}