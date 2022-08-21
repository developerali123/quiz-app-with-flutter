import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'homescreen.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(duration: const Duration(seconds: 2),
      vsync: this)..repeat(reverse: true);
  @override
  void initState(){
    super.initState();
    _navigate();
  }

  void _navigate() async{
    await Future.delayed(Duration(milliseconds: 5000),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(animation: _controller,child: Container(
              height: 200,
              width: 200,
              child: const Center(
                child: Image(height: 500,width:500,
                    image: NetworkImage('https://img.icons8.com/external-flaticons-lineal-color-flat-icons/344/external-quiz-online-education-flaticons-lineal-color-flat-icons.png')),
              ),
            ), builder: (context,Widget?child){
              return Transform.rotate(angle: _controller.value*2.0*math.pi,child: child,);
            }),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('BMI calculator',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black
              ),),
            )
          ],
        ),
      ),
    );
  }
}
