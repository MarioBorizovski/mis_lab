import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../widgets/exam_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Exam> _exams = [
    Exam(
      subject: 'Математичка анализа 1',
      dateTime: DateTime(2025, 11, 20, 10, 0),
      rooms: ['Амфитеатар 1', 'Амфитеатар 2'],
    ),
    Exam(
      subject: 'Веројатност и статистика',
      dateTime: DateTime(2025, 11, 23, 12, 0),
      rooms: ['Лаб 1'],
    ),
    Exam(
      subject: 'Алгоритми и податочни структури',
      dateTime: DateTime(2025, 11, 25, 9, 0),
      rooms: ['Амфитеатар 3'],
    ),
    Exam(
      subject: 'Оперативни системи',
      dateTime: DateTime(2025, 11, 28, 14, 0),
      rooms: ['Лаб 2', 'Лаб 3'],
    ),
    Exam(
      subject: 'Бази на податоци',
      dateTime: DateTime(2025, 12, 1, 11, 0),
      rooms: ['Амфитеатар 1'],
    ),
    Exam(
      subject: 'Дискретна математика',
      dateTime: DateTime(2025, 12, 4, 10, 0),
      rooms: ['Амфитеатар 2'],
    ),
    Exam(
      subject: 'Веб програмирање',
      dateTime: DateTime(2025, 12, 6, 13, 0),
      rooms: ['Лаб 1', 'Лаб 2'],
    ),
    Exam(
      subject: 'Софтверско инженерство',
      dateTime: DateTime(2025, 12, 10, 9, 0),
      rooms: ['Амфитеатар 3'],
    ),
    Exam(
      subject: 'Компјутерски мрежи',
      dateTime: DateTime(2025, 10, 25, 15, 0),
      rooms: ['Лаб 3'],
    ),
    Exam(
      subject: 'Вештачка интелигенција',
      dateTime: DateTime(2025, 10, 28, 11, 0),
      rooms: ['Амфитеатар 1', 'Амфитеатар 2'],
    ),
    Exam(
      subject: 'Мобилни информациски системи',
      dateTime: DateTime(2025, 11, 5, 10, 0),
      rooms: ['Лаб 1'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Распоред за испити - 213246'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _exams.length,
              itemBuilder: (context, index) {
                return ExamCard(exam: _exams[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Вкупно испити: ${_exams.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}