import 'dart:async';

import 'package:traffic/pages/Answer/answer.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ticker1 extends StatefulWidget {
  const Ticker1({Key? key}) : super(key: key);

  @override
  State<Ticker1> createState() => _HomeState();
}

class _HomeState extends State<Ticker1> {
  bool dialgoue = false;
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  late Timer _timer;

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
    "1) Выезжая с грунтовой дороги, Вы попадаете:",
    "images": "assets/images/pdd_3_1.jpg",
    "answers": [
      {
        "answerstext":
        "На главную дорогу.",
        "scrore": true,
      },
      {
        "answerstext":
        "На равнозначную дорогу. ",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "2) В каком месте Вы должны остановиться?",
    "images": "assets/images/pdd_3_2.jpg",
    "answers": [
      {
        "answerstext":
        "Перед знаком (А).",
        "scrore": false,
      },
      {
        "answerstext":
        "Перед краем пересекаемой проезжей части (В).",
        "scrore": true,
      },
      {
        "answerstext":
        "Перед перекрестком (Б).",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "3)В каком случае Вам необходимо двигаться со скоростью до 40 км/ч?",
    "images": "assets/images/pdd_3_3.jpg",
    "answers": [
      {
        "answerstext":
        "Во всех случаях.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только в том случае, когда покрытие на дороге влажное.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "4) Какие из знаков устанавливают в начале дороги с односторонним движением?",
    "images": "assets/images/pdd_3_4.jpg",
    "answers": [
      {
        "answerstext":
        "Б или В.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только А.",
        "scrore": false,
      },
      {
        "answerstext":
        "Б или Г.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только Б.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions": "5) Можете ли Вы остановиться в этом месте для посадки или высадки пассажиров?",
    "images": "assets/images/pdd_3_5.jpg",
    "answers": [
      {
        "answerstext":
        "Нет.",
        "scrore": false,
      },
      {
        "answerstext":
        "Да, если Вы не создадите помех движению маршрутных транспортных средств.",
        "scrore": true,
      },
      {
        "answerstext":
        "Да.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "6) В каких направлениях может продолжить движение водитель автомобиля с включенным проблесковым маячком?",
    "images": "assets/images/pdd_3_6.jpg",
    "answers": [
      {
        "answerstext": " Только направо.",
        "scrore": false,
      },
      {
        "answerstext":
        "В любом.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только прямо или направо.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "7) В каких случаях Вы не должны подавать предупредительный сигнал указателями поворота?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "В обоих перечисленных случаях.",
        "scrore": false,
      },
      {
        "answerstext":
        " Только при отсутствии на дороге других участников движения.",
        "scrore": false,
      },
      {
        "answerstext":
        " Только если сигнал может ввести в заблуждение других участников движения.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "8) По какой траектории Вы можете выполнить правый поворот?",
    "images": "assets/images/pdd_3_8.jpg",
    "answers": [
      {
        "answerstext":
        "По любой.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только по А.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только по Б.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "9)  Разрешено ли Вам таким образом выполнить разворот на перекрестке?",
    "images": "assets/images/pdd_3_9.jpg",
    "answers": [
      {
        "answerstext":
        "Да.",
        "scrore": false,
      },
      {
        "answerstext":
        "Нет.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "10) По какой полосе Вам разрешено движение в данной ситуации?",
    "images": "assets/images/pdd_3_10.jpg",
    "answers": [
      {
        "answerstext":
        "Только по правой.",
        "scrore": true,
      },
      {
        "answerstext":
        "По любой.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "11) В каком случае Вы можете начать обгон, если такой маневр на данном участке дороги не запрещен?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Только если полоса встречного движения свободна на достаточном для обгона расстоянии..",
        "scrore": false,
      },
      {
        "answerstext":
        "Только если Вас никто не обгоняет.",
        "scrore": false,
      },
      {
        "answerstext":
        "В случае, если выполнены оба условия.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "12)  Нарушил ли водитель грузового автомобиля с разрешенной максимальной массой не более 3,5 т правила стоянки в данной ситуации?",
    "images": "assets/images/pdd_3_12.jpg",
    "answers": [
      {
        "answerstext":
        "Разрешена.",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешена, если при этом не будет создано помех для движения маршрутных транспортных средств.",
        "scrore": true,
      },
      {
        "answerstext":
        "Запрещена.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "13) При движении прямо Вы:",
    "images": "assets/images/pdd_3_13.jpg",
    "answers": [
      {
        "answerstext":
        "Должны уступить дорогу транспортным средствам, движущимся с других направлений.",
        "scrore": false,
      },
      {
        "answerstext":
        "Должны остановиться перед стоп-линией.",
        "scrore": false,
      },
      {
        "answerstext":
        "Можете продолжить движение через перекресток без остановки.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "14) Вы намерены повернуть налево. Ваши действия?",
    "images": "assets/images/pdd_3_14.jpg",
    "answers": [
      {
        "answerstext":
        "Уступите дорогу легковому автомобилю.",
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
    "15) Вы намерены повернуть налево. Кому следует уступить дорогу?",
    "images": "assets/images/pdd_3_15.jpg",
    "answers": [
      {
        "answerstext":
        "Всем транспортным средствам.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только трамваю А.",
        "scrore": true,
      },
      {
        "answerstext":
        "Никому.",
        "scrore": false,
      },
      {
        "answerstext":
        "Трамваю А и легковому автомобилю.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "16) Кто из водителей нарушил правила остановки?",
    "images": "assets/images/pdd_3_16.jpg",
    "answers": [
      {
        "answerstext":
        "Оба нарушили.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только водитель грузового автомобиля.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только водитель легкового автомобиля.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "17) Какие из перечисленных требований предъявляются к обучаемому, допущенному к учебной езде на дорогах?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Знание Правил дорожного движения.",
        "scrore": false,
      },
      {
        "answerstext":
        "Возраст не менее 16 лет.",
        "scrore": false,
      },
      {
        "answerstext":
        "Наличие первоначальных навыков управления.",
        "scrore": false,
      },
      {
        "answerstext":
        "Все перечисленные требования.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "18) В каких случаях запрещается эксплуатация мотоцикла?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "При отсутствии предусмотренных конструкцией дуг безопасности, подножек, поперечных рукояток для пассажиров на седле.",
        "scrore": true,
      },
      {
        "answerstext":
        "Только при отсутствии предусмотренных конструкцией дуг безопасности.",
        "scrore": false,
      },
      {
        "answerstext":
        "Только при отсутствии предусмотренных конструкцией подножек, поперечных рукояток для пассажиров на седле.",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "19) На повороте возник занос задней оси переднеприводного автомобиля. Ваши действия?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Притормозите и повернете рулевое колесо в сторону заноса.",
        "scrore": false,
      },
      {
        "answerstext":
        "Уменьшите подачу топлива, рулевым колесом стабилизируете движение.",
        "scrore": false,
      },
      {
        "answerstext":
        "Слегка увеличите подачу топлива, корректируя направление движения рулевым колесом.",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "20) Какие сведения необходимо сообщить диспетчеру для вызова «Скорой помощи» при ДТП?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Указать улицу и номер дома, ближайшего к месту ДТП. Сообщить, кто пострадал в ДТП (пешеход, водитель автомобиля или пассажиры), и описать травмы, которые они получили.",
        "scrore": false,
      },
      {
        "answerstext":
        "Указать общеизвестные ориентиры, ближайшие к месту ДТП. Сообщить о количестве пострадавших, указать их пол и возраст. ",
        "scrore": false,
      },
      {
        "answerstext":
        "Указать точное место совершенного ДТП (назвать улицу, номер дома и общеизвестные ориентиры, ближайшие к месту ДТП). Сообщить о количестве пострадавших, их пол, примерный возраст и о наличии у них признаков жизни, а также сильного кровотечения.",
        "scrore": true,
      },
    ]
  },
];
