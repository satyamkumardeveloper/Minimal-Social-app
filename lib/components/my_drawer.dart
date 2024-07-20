import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

               //drawer header 
         const DrawerHeader(child: Icon(Icons.favorite)),

              // home tile 
              Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading:const Icon(Icons.home),
              title:const Text("H O M E"),
              onTap:() {
                // this is already the home screen so pop ther drawer just
                Navigator.pop(context);

                
              },
            ),
          ),


          //profile Tile
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading:const Icon(Icons.person),
              title:const Text("P R O F I L E"),
              onTap:() {
                // this is already the home screen so pop ther drawer just
                Navigator.pop(context);

                //navigate to profile page
                Navigator.pushNamed(context, '/profile_page');
              },
            ),
          ),

          //user tile

          Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading:const Icon(Icons.people),
              title:const Text("U S E R S"),
              onTap:() {
                // this is already the home screen so pop ther drawer just
                Navigator.pop(context);


                //navigate to users page
                Navigator.pushNamed(context, '/users_page');
              },
            ),
          ),
            ],
          ),
          


          // logout tile
          Padding(
            padding:const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              leading:const Icon(Icons.logout),
              title:const Text("L O G O U T"),
              onTap:() {
                // pop there drawer just
                Navigator.pop(context);

                //logout
                logout();


                
              },
            ),
          )
        ],
      ),
    );
  }
}