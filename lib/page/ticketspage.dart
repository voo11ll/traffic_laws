import 'package:traffic/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';

import '../ticketpage/ticket_1.dart';
import '../ticketpage/ticket_2.dart';
import '../ticketpage/ticket_5.dart';
import '../ticketpage/ticket_7.dart';


class TicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Билеты'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Количество блоков в одной строке
        padding: EdgeInsets.all(16.0),
        children: List.generate(10, (index) {
          return TicketBlock(index + 1, () {
            // Замените на нужную страницу
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => getPage(index + 1),
              ),
            );
          });
        }),
      ),
    );
  }

  Widget getPage(int ticketNumber) {
    switch (ticketNumber) {
      case 1:
        return Ticker1();
      case 2:
        return Ticker2();
      case 3:
        return Page3();
      case 5:
        return Ticker5();
      case 7:
        return Ticker7();
    // Добавьте другие страницы по аналогии
      default:
        return Page1();
    }
  }
}

class TicketBlock extends StatelessWidget {
  final int ticketNumber;
  final VoidCallback onPressed;

  TicketBlock(this.ticketNumber, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            'Билет $ticketNumber',
            style: TextStyle(fontSize: 20.0),
          ),
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
        child: Text('Вы выбрали страницу 1'),
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
        child: Text('Вы выбрали страницу 2'),
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
        child: Text('Вы выбрали страницу 3'),
      ),
    );
  }
}
class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница 5'),
      ),
      body: Center(
        child: Text('Вы выбрали страницу 5'),
      ),
    );
  }
}

class Page7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница 7'),
      ),
      body: Center(
        child: Text('Вы выбрали страницу 7'),
      ),
    );
  }
}

// Добавьте другие страницы по аналогии
