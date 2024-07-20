

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_buttons.dart';
import 'package:social_app/components/my_textFeild.dart';
import 'package:social_app/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
 
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   //text editing controller
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  //register user
  Future<void> registerUser() async {
    //show loading circle 
    showDialog(context: context, builder:(context)=> const Center(
      child: CircularProgressIndicator(),
    ));
    


    //make sure password match
    if (passwordController.text!=confirmPasswordController.text) {
      //pop loading cycle
      Navigator.pop(context);

      //show error message to user
      displayMessageToUser("Password not match!",context);
    }


    //try creating user
    else{
      try{
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);


        // create a user document and add to firestore
        createUserDocument(userCredential);

        //pop loading cycle
        if (context.mounted) Navigator.pop(context);


    } on FirebaseAuthException catch (e){
      //pop loading cycle
      Navigator.pop(context);

      displayMessageToUser(e.code, context);
    }
    }
    
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {

    if(userCredential!=null && userCredential.user!= null){
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
        'email' : userCredential.user!.email,
        'username': userNameController.text
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(25),
              
              child: Column(
                
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Icon(
                    Icons.person,
                    size: 90,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            
                  const SizedBox(
                    height: 15,
                  ),
            
                  // app name
            
                  const Text(
                    "M I N I M A L",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
            
                  const SizedBox(
                    height: 20,
                  ),
            
                  //Username textfeild
                  MyTextfeild(
                      hintText: "Username",
                      obscureText: false,
                      controller: userNameController),
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  //email textfeild
                  MyTextfeild(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController),
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  //password textfeild
            
                  MyTextfeild(
                      hintText: "Create a Password",
                      obscureText: true,
                      controller: passwordController),
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  //confirm password textfeild
            
                  MyTextfeild(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: confirmPasswordController),
            
                  const SizedBox(
                    height: 10,
                  ),
                  // sign in button
                  MyButtons(onTap: registerUser, text: "Register"),
            
                  const SizedBox(
                    height: 10,
                  ),
                  //Already have an account ? Register
            
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Already have an account ? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
