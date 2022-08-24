import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_game/Util/my_button.dart';

import 'Util/result_message.dart';
import 'constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> numberPad = ['7', '8', '9', 'C', '4', '5', '6', 'DEL', '1', '2', '3', '=', '0',];
  //answer box
  String userAnswer = '';
  var randomNumber = Random();
   int numberA=2 ;
   int numberB=3 ;


//user tapped a button
  void buttonTapped(String button) {
    setState(() {
      if(button=='='){
        checkResult();
      }
      else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        userAnswer += button;
      }
    });
  }

  void goToNextQuestion() {
    Navigator.of(context).pop() ;
    setState(() {
      userAnswer = '';
    });
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }
  void goBackToQuestion(){
    Navigator.of(context).pop();

  }

  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(message: 'Correct',
                onTap: goToNextQuestion,
                icon: Icons.arrow_forward);
          });
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(message: 'Sorry try again',
                onTap: goBackToQuestion,
                icon: Icons.rotate_left);
          });
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.deepPurple[300],
          body: Column(
            children: [
              Container(
                height: 100,
                color: Colors.deepPurple,
              ),
              Expanded(
                  child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Question
                      Text(numberA.toString() + '+' + numberB.toString() + '=',
                          style: whitTextStyle),
                      //answer box
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                            child: Text(
                          userAnswer,
                          style: whitTextStyle,
                        )),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GridView.builder(
                      itemCount: numberPad.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        return MyButton(
                          child: numberPad[index],
                          onTap: () => buttonTapped(numberPad[index]),
                        );
                      }),
                ),
              ),
            ],
          )
      );

  }}
