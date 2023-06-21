import 'dart:async';

import 'package:traffic/pages/Answer/answer.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ticker2 extends StatefulWidget {
  const Ticker2({Key? key}) : super(key: key);

  @override
  State<Ticker2> createState() => _HomeState();
}

class _HomeState extends State<Ticker2> {
  bool dialgoue = false;
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;

  var value;

  truedialouge() {
    print("=====>>>>>");
    print("Truee");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'ПРАВИЛЬНО',
      desc: 'Вы великолепны 😍',
      // btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (endOfQuiz == true) {
          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Посмотреть результат ',
            desc: 'Ты набрал ${_totalScore}/${questions.length} ',
            btnOkOnPress: () {},
          )..show();
        } else {}
      },
    ).show();
  }

  falsedialouge() {
    print("=====>>>>>");
    print("Falsee");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'НЕПРАВИЛЬНО',
      desc: 'На этот раз неверно 😕',
      // btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (endOfQuiz == true) {
          // ignore: avoid_single_cascade_in_expression_statements
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Посмотреть результат ',
            desc: 'Ты набрал ${_totalScore}/${questions.length} ',
            btnOkOnPress: () {},
          )..show();
        } else {}
      },
    ).show();
  }

  void _questionsAnswers(bool answerScore) {
    print(answerScore);
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
      }
      //show dialouge
      answerScore ? truedialouge() : falsedialouge();
      if (_questionIndex + 1 == questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
    });
    //What happened at the end of QUIZ
    if (_questionIndex >= questions.length) {
      _resetQuiz();
    }
  }

  _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      endOfQuiz = false;
    });
  }

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  void _doSomething() async {
    // Timer(Duration(seconds: 2), () {
    //   if (!answerWasSelected) {
    //     return;
    //   }
    //   _btnController.success();
    //   _nextQuestion();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: 350.h,
                      width: 300.w,
                      child: Image.asset(
                        questions[_questionIndex]["images"].toString(),
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    questions[_questionIndex]["qestions"].toString(),
                    style: TextStyle(
                        fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ...(questions[_questionIndex]["answers"]
                as List<Map<String, Object>>)
                    .map((answer) => Answer(
                  AnswerText: answer["answerstext"].toString(),
                  answerColor: answerWasSelected
                      ? answer["scrore"] == true
                      ? Colors.green
                      : Colors.red
                      : Colors.transparent,
                  answerTap: () {
                    //If Answer was already selected nothing happens on tap
                    if (answerWasSelected) {
                      return;
                    }
                    value = answer["scrore"];

                    _questionsAnswers(value);
                  },
                )),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    if (!answerWasSelected) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'ВЫБИРЕТЕ ОТВЕТ',
                        desc: 'НЕ ВЫБРАН ОТВЕТ!',
                        btnOkOnPress: () {},
                      ).show();
                      return;
                    }
                    _nextQuestion();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      height: 46,
                      width: double.infinity,
                      child: Text(
                        endOfQuiz ? "Пройти еще раз" : "Следующий вопрос",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}

final questions = [
  {
    "qestions":
    "1) При движении на легковом автомобиле, оборудованном ремнями безопасности, пристегиваться ремнями должны:",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Все лица, находящиеся в автомобил",
        "scrore": true,
      },
      {
        "answerstext":
        "Только водитель и пассажир на переднем сиденье ",
        "scrore": false,
      },
      {
        "answerstext":
        "Только водитель",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "2) Можете ли Вы въехать на мост первым?",
    "images": "assets/images/pdd_02_02.jpg",
    "answers": [
      {
        "answerstext":
        "Нет",
        "scrore": false,
      },
      {
        "answerstext":
        "Да",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "3) С какой максимальной скоростью Вы можете продолжить движение на грузовом автомобиле с разрешенной максимальной массой не более 3,5 т?",
    "images": "assets/images/pdd_02_03.jpg",
    "answers": [
      {
        "answerstext":
        "80 км/ч.",
        "scrore": true,
      },
      {
        "answerstext":
        "60 км/ч.",
        "scrore": false,
      },
      {
        "answerstext":
        "70 км/ч.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "4) Что запрещено в зоне действия этого знака:",
    "images": "assets/images/pdd_02_04.jpg",
    "answers": [
      {
        "answerstext":
        "Движение со скоростью более 20 км/ч.",
        "scrore": false,
      },
      {
        "answerstext":
        "Движение любых транспортных средств.",
        "scrore": true,
      },
      {
        "answerstext":
        "Движение только механических транспортных средств.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions": "5) Разрешен ли Вам обгон, если реверсивные светофоры отключены?",
    "images": "assets/images/pdd_02_05.jpg",
    "answers": [
      {
        "answerstext":
        "Не разрешен",
        "scrore": true,
      },
      {
        "answerstext":
        "Разрешен",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешен, если скорость автобуса менее 30 км/ч",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "6) В каких направлениях Вам разрешено продолжить движение?",
    "images": "assets/images/pdd_02_06.jpg",
    "answers": [
      {
        "answerstext": " Налево и в обратном направлении.",
        "scrore": false,
      },
      {
        "answerstext":
        "Прямо и налево.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только налево",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "7) Поднятая вверх рука водителя легкового автомобиля является сигналом, информирующим Вас:",
    "images": "assets/images/pdd_02_07.jpg",
    "answers": [
      {
        "answerstext":
        "О его намерении снизить скорость, чтобы остановиться и уступить дорогу мотоциклисту.",
        "scrore": true,
      },
      {
        "answerstext":
        " О его намерении продолжить движение прямо.",
        "scrore": false,
      },
      {
        "answerstext":
        " О его намерении повернуть направо.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "8) Двигаясь по левой полосе, Вы намерены перестроиться на правую. На каком из рисунков показана ситуация, в которой Вы обязаны уступить дорогу?",
    "images": "assets/images/pdd_02_08.jpg",
    "answers": [
      {
        "answerstext":
        "На обоих.",
        "scrore": true,
      },
      {
        "answerstext":
        "На правом.",
        "scrore": false,
      },
      {
        "answerstext":
        "На левом.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "9)  Разрешен ли Вам разворот в указанном месте?",
    "images": "assets/images/pdd_02_09.jpg",
    "answers": [
      {
        "answerstext":
        "Запрещен.",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешен только при отсутствии приближающегося поезда.",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешен.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "10)  В каких случаях Вы можете наезжать на прерывистые линии разметки, разделяющие проезжую часть на полосы движения?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Только если на дороге нет других транспортных средств.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только при перестроении.",
        "scrore": true,
      },
      {
        "answerstext":
        "Во всех перечисленных случаях.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только при движении в темное время суток.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "11)  Разрешено ли Вам обогнать мотоциклиста?",
    "images": "assets/images/pdd_02_11.jpg",
    "answers": [
      {
        "answerstext":
        "Разрешено.",
        "scrore": false,
      },
      {
        "answerstext":
        "Запрещено.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "12)  Нарушил ли водитель грузового автомобиля с разрешенной максимальной массой не более 3,5 т правила стоянки в данной ситуации?",
    "images": "assets/images/pdd_02_12.jpg",
    "answers": [
      {
        "answerstext":
        "Да.",
        "scrore": true,
      },
      {
        "answerstext":
        "Нет.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "13)  Вы намерены повернуть налево. Кому следует уступить дорогу?",
    "images": "assets/images/pdd_02_13.jpg",
    "answers": [
      {
        "answerstext":
        "Автобусу и пешеходам.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только автобусу.",
        "scrore": false,
      },
      {
        "answerstext":
        "Никому.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только пешеходам.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "14) Вы намерены повернуть налево. Ваши действия?",
    "images": "assets/images/pdd_02_14.jpg",
    "answers": [
      {
        "answerstext":
        "Уступите дорогу автомобилю.",
        "scrore": false,
      },
      {
        "answerstext":
        "Проедете перекресток первым.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "15) Обязан ли мотоциклист уступить Вам дорогу в данной ситуации?",
    "images": "assets/images/pdd_02_15.jpg",
    "answers": [
      {
        "answerstext":
        "Да.",
        "scrore": true,
      },
      {
        "answerstext":
        "Нет.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "16) В данной ситуации Вы:",
    "images": "assets/images/pdd_02_16.jpg",
    "answers": [
      {
        "answerstext":
        "Имеете преимущество, так как водитель автобуса начинает движение с выездом на вторую полосу.",
        "scrore": false,
      },
      {
        "answerstext":
        "Должны уступить дорогу автобусу, начинающему движение от обозначенного места остановки.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "17) В каких из перечисленных случаев запрещена буксировка на гибкой сцепке?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Только в гололедицу.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только в темное время суток и в условиях недостаточной видимости.",
        "scrore": false,
      },
      {
        "answerstext":
        "Во всех перечисленных случаях.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только на горных дорогах.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "18) При какой максимальной величине остаточной глубины рисунка протектора шин (при отсутствии индикаторов износа) запрещается эксплуатация мототранспортных средств (категории L)?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "2,0 мм.",
        "scrore": false,
      },
      {
        "answerstext":
        "1,6 мм.",
        "scrore": false,
      },
      {
        "answerstext":
        "1,0 мм.",
        "scrore": false,
      },
      {
        "answerstext":
        "0,8 мм.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "19) Что подразумевается под остановочным путем?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Расстояние, пройденное транспортным средством с момента обнаружения водителем опасности до полной остановки.",
        "scrore": true,
      },
      {
        "answerstext":
        "Расстояние, соответствующее тормозному пути, определенному технической характеристикой данного транспортного средства.",
        "scrore": false,
      },
      {
        "answerstext":
        "Расстояние, пройденное транспортным средством с момента начала срабатывания тормозного привода до полной остановки.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "20) Что подразумевается под временем реакции водителя?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Время с момента обнаружения водителем опасности до начала принятия мер по ее избежанию.",
        "scrore": true,
      },
      {
        "answerstext":
        "Время, необходимое для переноса ноги с педали подачи топлива на педаль тормоза.",
        "scrore": false,
      },
      {
        "answerstext":
        "Время с момента обнаружения водителем опасности до полной остановки транспортного средства.",
        "scrore": false,
      },
    ]
  },
];
