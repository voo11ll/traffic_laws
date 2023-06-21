import 'dart:async';

import 'package:traffic/pages/Answer/answer.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ticker5 extends StatefulWidget {
  const Ticker5({Key? key}) : super(key: key);

  @override
  State<Ticker5> createState() => _HomeState();
}

class _HomeState extends State<Ticker5> {
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
    "1) Может ли владелец мотоцикла с рабочим объемом двигателя внутреннего сгорания не превышающим 125 см3 и максимальной мощностью, не превышающей 11 кВт, передавать управление этим транспортным средством в своем присутствии другому лицу, имея соответствующий страховой полис?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Можете при наличии у этого лица водительского удостоверения на право управления транспортным средством категории «А» или подкатегории «А1».",
        "scrore": true,
      },
      {
        "answerstext":
        "Может при наличии у этого лица водительского удостоверения на право управления транспортным средством подкатегории «B1»",
        "scrore": false,
      },
      {
        "answerstext":
        "Может при наличии у этого лица водительского удостоверения на право управления транспортным средством категории «M»",
        "scrore": false,
      },
      {
        "answerstext":
        "Может во всех перечисленных случаях",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "2) О чем информируют Вас эти дорожные знаки?",
    "images": "assets/images/pdd_7_2.jpg",
    "answers": [
      {
        "answerstext":
        "О приближении к таможне.",
        "scrore": false,
      },
      {
        "answerstext":
        "О приближении к перекрестку, где установлен знак «Уступите дорогу».",
        "scrore": false,
      },
      {
        "answerstext":
        "О приближении к перекрестку, где установлен знак «Движение без остановки запрещено».",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "3) Разрешено ли Вам произвести остановку в указанном месте?",
    "images": "assets/images/pdd_7_3.jpg",
    "answers": [
      {
        "answerstext":
        "Да",
        "scrore": true,
      },
      {
        "answerstext":
        "Нет",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "4) Действие каких знаков распространяется только до ближайшего по ходу движения перекрестка?",
    "images": "assets/images/pdd_7_4.jpg",
    "answers": [
      {
        "answerstext":
        "Б и Г",
        "scrore": true,
      },
      {
        "answerstext":
        "А и В",
        "scrore": false,
      },
      {
        "answerstext":
        "В и Г",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "5) Что обозначают прерывистые линии разметки на перекрестке?",
    "images": "assets/images/pdd_7_5.jpg",
    "answers": [
      {
        "answerstext":
        "Обязательное направление движения на перекрестке",
        "scrore": false,
      },
      {
        "answerstext":
        "Границы полос движения в пределах перекрестка",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "6) В каких направлениях Вам разрешено движение?",
    "images": "assets/images/pdd_7_6.jpg",
    "answers": [
      {
        "answerstext": "Только прямо",
        "scrore": true,
      },
      {
        "answerstext":
        "Только прямо, налево и в обратном направлении",
        "scrore": false,
      },
      {
        "answerstext":
        "В любом",
        "scrore": false,
      },
      {
        "answerstext":
        "Только прямо и направо",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "7) Когда Вы обязаны выключить левые указатели поворота, выполняя обгон?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "По своему усмотрению",
        "scrore": false,
      },
      {
        "answerstext":
        "Сразу же после перестроения на встречную полосу",
        "scrore": true,
      },
      {
        "answerstext":
        "После опережения обгоняемого транспортного средства",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "8) Обязаны ли Вы, двигаясь по правой полосе, уступить дорогу водителю автомобиля, который намерен перестроиться на Вашу полосу?",
    "images": "assets/images/pdd_7_8.jpg",
    "answers": [
      {
        "answerstext":
        "Обязаны",
        "scrore": false,
      },
      {
        "answerstext":
        "Обязаны, если водитель перестраивается после опережения Вашего автомобиля",
        "scrore": false,
      },
      {
        "answerstext":
        "Не обязаны",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "9) Разрешен ли Вам разворот на указанном участке дороги?",
    "images": "assets/images/pdd_7_9.jpg",
    "answers": [
      {
        "answerstext":
        "Не разрешен",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешен",
        "scrore": false,
      },
      {
        "answerstext":
        "Разрешен только при видимости дороги более 100 метров",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "10) По какой траектории следует двигаться, поворачивая налево?",
    "images": "assets/images/pdd_7_11.jpg",
    "answers": [
      {
        "answerstext":
        "Только по Б",
        "scrore": true,
      },
      {
        "answerstext":
        "По любой",
        "scrore": false,
      },
      {
        "answerstext":
        "Только по А",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "11) Разрешено ли Вам в конце подъема перестроиться на среднюю полосу для опережения грузового автомобиля?",
    "images": "assets/images/pdd_7_11.jpg",
    "answers": [
      {
        "answerstext":
        "Разрешено",
        "scrore": true,
      },
      {
        "answerstext":
        "Запрещено",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "12) В каком из указанных мест Вы можете поставить на стоянку легковой автомобиль?",
    "images": "assets/images/pdd_7_12.jpg",
    "answers": [
      {
        "answerstext":
        "Только А",
        "scrore": false,
      },
      {
        "answerstext":
        "А или В",
        "scrore": true,
      },
      {
        "answerstext":
        "Только В",
        "scrore": false,
      },
      {
        "answerstext":
        "Ни в каком",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "13) Как Вы должны действовать, если Вам необходимо повернуть налево?",
    "images": "assets/images/pdd_7_13.jpg",
    "answers": [
      {
        "answerstext":
        "Остановиться перед стоп-линией и после проезда легкового автомобиля повернуть налево",
        "scrore": false,
      },
      {
        "answerstext":
        "Проехать первым",
        "scrore": false,
      },
      {
        "answerstext":
        "Выехать за стоп-линию и остановиться на перекрестке, чтобы уступить дорогу встречному автомобилю",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "14) Вы имеете право выехать на перекресток, если за ним образовался затор:",
    "images": "assets/images/pdd_7_14.jpg",
    "answers": [
      {
        "answerstext":
        "В любом случае",
        "scrore": false,
      },
      {
        "answerstext":
        "Только если Вы намерены совершить поворот или разворот",
        "scrore": true,
      },
      {
        "answerstext":
        "Только если Вы намерены проехать перекресток в прямом направлении",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "15) Вы намерены продолжить движение прямо. Кому следует уступить дорогу?",
    "images": "assets/images/pdd_7_15.jpg",
    "answers": [
      {
        "answerstext":
        "Только мотоциклу",
        "scrore": false,
      },
      {
        "answerstext":
        "Мотоциклу и легковому автомобилю",
        "scrore": false,
      },
      {
        "answerstext":
        "Никому",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "16) Где могут двигаться пешеходы в жилой зоне?",
    "images": "assets/images/blanke.jpg",
    "answers": [
      {
        "answerstext":
        "Только по тротуарам",
        "scrore": false,
      },
      {
        "answerstext":
        "По тротуарам и в один ряд по краю проезжей части",
        "scrore": false,
      },
      {
        "answerstext":
        "По тротуарам и по всей ширине проезжей части",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "17) На каком рисунке изображен автомобиль, водитель которого не нарушает правил перевозки грузов?",
    "images": "assets/images/pdd_7_17.jpg",
    "answers": [
      {
        "answerstext":
        "Только на А",
        "scrore": false,
      },
      {
        "answerstext":
        "На обоих",
        "scrore": true,
      },
      {
        "answerstext":
        "Только на Б",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "18) В каких случаях Вам разрешается эксплуатация транспортного средства?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Уровень внешнего шума превышает установленные нормы",
        "scrore": false,
      },
      {
        "answerstext":
        "Негерметична топливная система",
        "scrore": false,
      },
      {
        "answerstext":
        "Не работает указатель температуры охлаждающей жидкости",
        "scrore": true,
      },
      {
        "answerstext":
        "Содержание вредных веществ в отработавших газах или дымность превышают установленные нормы",
        "scrore": true,
      },
    ]
  },
  {
    "qestions":
    "19) Двигаться по глубокому снегу на грунтовой дороге следует:",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "На заранее выбранной пониженной передаче, без резких поворотов и остановок",
        "scrore": true,
      },
      {
        "answerstext":
        "Изменяя скорость движения и передачу в зависимости от состояния дороги",
        "scrore": false,
      },
    ]
  },
  {
    "qestions":
    "20) В чем заключается первая помощь пострадавшему, находящемуся в сознании, при повреждении позвоночника?",
    "images": "assets/images/blank.jpg",
    "answers": [
      {
        "answerstext":
        "Лежащего пострадавшего не перемещать. Следует наложить ему на шею импровизированную шейную шину, не изменяя положения шеи и тела",
        "scrore": true,
      },
      {
        "answerstext":
        "Пострадавшему, лежащему на спине, подложить под шею валик из одежды и приподнять ноги",
        "scrore": false,
      },
      {
        "answerstext":
        "Уложить пострадавшего на бок",
        "scrore": false,
      },
    ]
  },
];