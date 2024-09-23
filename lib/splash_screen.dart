import 'package:final_proj_todo/function.dart';
import 'package:final_proj_todo/home.dart';
import 'package:final_proj_todo/login.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash_screen> {
   
  @override
  void initState(){
     super.initState();
     moveToNext();
     
  }

 void moveToNext() async{
    await Future.delayed(Duration(seconds: 2));
    final bool isloggedin = await gettingBoolData();
    if(isloggedin)
    {
   Navigator.push(context, MaterialPageRoute(builder: (context) => Firstpage(),));
 
    }
    else{
   Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
       
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwu-PoDKsazxzc3IUxcx17ZpOy0EARw7M60Q&s", 
                width: 190,
                height: 110,
              ),
 ],
          ),
          
        ]
     ),
     
    );
  }
}