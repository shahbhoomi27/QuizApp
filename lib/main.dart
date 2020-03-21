import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() => runApp(MyAppbar());

QuestionBrain qb = new QuestionBrain();

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          title: Text("Quiz"),
          backgroundColor: Colors.grey.shade800,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
              qb.getQuestionText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  checkAnswer(true);
                },
                child: Text(
                  "True",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
                color: Colors.red,
                onPressed: () {
                  checkAnswer(false);
                },
                child: Text(
                  "False",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        Row(
          children: scorKeeper,
        )
      ],
    );
  }

  void checkAnswer(bool user_ans) {
    setState(() {

      if(qb.isFinished() == true){

        Alert(context: context, title: "Finished!", desc: "You have reached the end of the quiz.").show();
        qb.reset();
        scorKeeper=[];

      }else {
        if (qb.getQueAns() == user_ans) {
          scorKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        qb.nextQuestion();
      }
    });
  }
}
