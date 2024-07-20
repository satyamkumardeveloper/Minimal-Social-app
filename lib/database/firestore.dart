/*

this database store posts that user have published in the app .
it is stored in a collection called 'Posts' in firebase

Each post contains:
-- a message
-- email of user 
-- timestamp

*/ 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{

//current logged in user
  User? user=FirebaseAuth.instance.currentUser;


//get collection of post fro user 
  final CollectionReference posts=FirebaseFirestore.instance.collection('Posts');



//post a message
  Future<void> addPost(String message){
    return posts.add({
    'UserEmail' :user!.email,
    'PostMessage' :message,
    'TimeStamp' :Timestamp.now(),
    });
  }

//read posts from database
  Stream<QuerySnapshot> getPostStream(){
    final postStream=FirebaseFirestore.instance.
    collection('Posts').
    orderBy('TimeStamp',descending: true).
    snapshots();

    return postStream;
  }
}