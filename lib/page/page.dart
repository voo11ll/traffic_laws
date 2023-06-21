import 'package:flutter/material.dart';

import '../ticketpage/ticket_1.dart';
import '../ticketpage/ticket_2.dart';
import '../ticketpage/ticket_7.dart';
class PDDSection {
  final String title;
  final IconData icon;
  final Color color;

  PDDSection({required this.title, required this.icon, required this.color});
}

class PDDHomePage extends StatelessWidget {
  final List<PDDSection> sections = [
    PDDSection(title: 'Дорожные знаки', icon: Icons.traffic, color: Colors.blue),
    PDDSection(title: 'Общие положения', icon: Icons.info, color: Colors.green),
    PDDSection(title: 'Дорожные разметки', icon: Icons.map, color: Colors.orange),
    PDDSection(title: 'Сигналы светофоров', icon: Icons.traffic_outlined, color: Colors.red),
    PDDSection(title: 'Скорость движения', icon: Icons.speed, color: Colors.purple),
    PDDSection(title: 'Остановка и стоянка', icon: Icons.local_parking, color: Colors.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопросы по темам'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Перейти на страницу с выбранным разделом
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ticker1(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ticker2(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ticker7(),
                    ),
                  );
                  break;
              // Добавьте дополнительные case для других страниц
              }
            },
            child: Card(
              color: sections[index].color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    sections[index].icon,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    sections[index].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PDDSectionPage extends StatelessWidget {
  final PDDSection section;

  PDDSectionPage({required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.title),
      ),
      body: Center(
        child: Text(
          'Страница с информацией о разделе "${section.title}"',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Страница 1'),
    ),
    body: Center(
    child: Text(
    'Страница 1 с информацией о разделе',
    style: TextStyle(fontSize: 18.0),
    ),
    ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница 2'),
      ),
      body: Center(
        child: Text(
          'Страница 2 с информацией о разделе',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница 3'),
      ),
      body: Center(
        child: Text(
          'Страница 3 с информацией о разделе',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PDDHomePage()));
}
