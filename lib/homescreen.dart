import 'package:flutter/material.dart';
import 'package:quizzler/result.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz APP'),
        centerTitle: true,),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int points=0;
  int correctanswers=0;
  int totalquestions=1;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    Widget Button =alertbutton();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (quizBrain.isFinished() == true) {
        double percentage=((correctanswers/quizBrain.getQuestionNumber())*100);

        print(percentage);
        showDialog(context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  height: 200,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.check_box,color: Colors.green,size: 60,),
                      Text('your answer is correct',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left:10,right: 10),
                          child: RaisedButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Resultpage(points: points,
                                qno: totalquestions,
                                cno: correctanswers,percentage: percentage,)),
                            );
                          }, padding: EdgeInsets.all(20),
                              color: Colors.blue,
                              child: Text('See Result'))
                      )
                    ],
                  ),
                ),
              );
            });
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        // Alert(
        //   context: context,
        //   title: 'Finished!',
        //   desc: 'You\'ve reached the end of the quiz.',
        // ).show();

        // Dialog(
        //   child: Container(
        //     height: 200,
        //     width: 100,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Icon(Icons.check_box,color: Colors.green,size: 60,),
        //         Text('your answer is correct',
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 20
        //           ),
        //           textAlign: TextAlign.center,
        //         ),
        //         Container(
        //             width: double.infinity,
        //             margin: EdgeInsets.only(left:10,right: 10),
        //             child: Button
        //         )
        //       ],
        //     ),
        //   ),
        // );

        //TODO Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          showDialog(context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    height: 200,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_box,color: Colors.green,size: 60,),
                        Text('your answer is correct',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left:10,right: 10),
                            child: Button
                        )
                      ],
                    ),
                  ),
                );
              });
          points=points+10;
          correctanswers=correctanswers+1;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          showDialog(context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    height: 200,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.close,color: Colors.red,size: 60,),
                        Text('your answer is wrong',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left:10,right: 10),
                            child: Button
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        print(points);
        totalquestions=totalquestions+1;
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Text('Question No '+quizBrain.getQuestionNumber().toString(),textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.green,
                    ),),
                  Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    //The user picked true.
                    checkAnswer(true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: FlatButton(
                  color: Colors.red,
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(false);
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

class alertbutton extends StatelessWidget {
  const alertbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Text('Next'),
      onPressed: ()=> {
        Navigator.of(context).pop()
      },
    );
  }
}
