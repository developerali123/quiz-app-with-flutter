import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'homescreen.dart';
import 'main.dart';

class Resultpage extends StatelessWidget {
  int points=0;
  int qno;
  int cno;
  double percentage;
  Color green=Colors.green;
  String getpercentage(){
    if(percentage<70){
      green=Colors.red;
      return 'you are fail';
    }else{
      return 'you are passed';
    }
  }
  String Quote(){
    if(percentage<70){
      return 'practice more';
    }else{
      return 'Good Job';
    }
  }
  Resultpage({Key? key,required this.points,required this.qno,required this.cno,required this.percentage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Text('Your Result',style: TextStyle(fontSize: 30),),
            ),
          ),
          Expanded(flex: 5,child: Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new  CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 15.0,
                  animation: true,
                  percent: percentage/100,
                  animationDuration: 1200,
                  center: new Text(percentage.toStringAsFixed(1),style: TextStyle(fontSize: 20),),
                  progressColor: Colors.green,
                ),
                Text('Total Points: '+points.toString(),style: TextStyle(fontSize: 30),),
                Text(cno.toString()+' out of '+qno.toString()+' questions are correct',style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,),
                Text(getpercentage(),style: TextStyle(fontSize: 50,color: green),textAlign: TextAlign.center,),
                Text(Quote(),style: TextStyle(fontSize: 30),)
              ],
            ),
          )),
          FirstRoute(),
        ],
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.red,
        margin: EdgeInsets.only(top:10),
        width: double.infinity,
        height: 80,
        child: Center(child: Text('Try Again'.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20)),),
      ),
      onTap: (){
        print('tap');
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
      },
    );
  }
}