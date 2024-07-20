import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_buttons.dart';
import 'package:social_app/components/my_textFeild.dart';
import 'package:social_app/helper/helper_functions.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {


  

  final void Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  void login() async{

    //show loading cycle
    showDialog(context: context, builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ));

    //try to sign in
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      //pop loading cycle

      if (context.mounted){
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e){
      //pop loading cycle
      Navigator.pop(context);

      //display message to user
      displayMessageToUser(e.code, context);

    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            
                const SizedBox(height: 25,),
            
            // app name 
            
               Text("M I N I M A L",style: TextStyle(
                fontSize: 25 ,
                fontWeight: FontWeight.bold
               ),),
            
            
            const SizedBox(height: 25,),
            
            //email textfeild
            MyTextfeild(hintText: "Email", obscureText: false, controller: emailController),
            
            
            
            const SizedBox(height: 10,),
            
            //password textfeild
          
            MyTextfeild(hintText: "Password", obscureText: true, controller: passwordController),
            
          
          
            SizedBox(height: 10,),
            //forget Password
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              
              children: [
                Text("Forget password !",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary
                  ),
                  )]
                ),
            
          
            SizedBox(height: 10,),
            // sign in button
            MyButtons(onTap: login , text: "Login"),
          
          
            
            SizedBox(height: 10,),
            //don't have an account ? Register
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account ? ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
              ),),
          
              GestureDetector(
                onTap:widget.onTap ,
                child:const Text("Register Here",
                style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              ])
            
            
            ],),
          ),
        ),


      )
    );
  }
}