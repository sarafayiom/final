import 'package:flutter/material.dart';
class SignupStep1 extends StatelessWidget {
  const SignupStep1({super.key});
  @override
  Widget build(BuildContext context) {
   return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child:  Text( textAlign: TextAlign.center,"Welcome To HomeWorkout App",
            style: TextStyle(fontWeight: FontWeight.w600,
            fontSize: 35),),),
         SizedBox(height: 10,),
          Padding(padding: EdgeInsets.only(left: 40),child: 
          Text("The best application that allows you to exercise professionally from the comfort of your home!",
          style: TextStyle( color: Colors.black,fontSize: 15),),
          ),       
            SizedBox(height: 10,),
           Expanded(
  child: Container(
    width: 340,
    height: MediaQuery.of(context).size.height * 0.3,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/image/StartUp1.png"),
        fit: BoxFit.cover,
      ),
    ),
  ),
),
        ],
   );
  }
}