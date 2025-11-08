import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../widgets/detail_info.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: Text(exam.subject),
        centerTitle: true,
        backgroundColor: exam.isPast ? Colors.grey : Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: exam.isPast
                        ? [Colors.grey.shade400, Colors.grey.shade600]
                        : [Colors.red.shade300, Colors.red.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      exam.isPast ? Icons.check_circle : Icons.timer,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exam.isPast ? 'ЗАВРШЕН' : 'ПРЕОСТАНУВА',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exam.getTimeRemaining(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Детали за испитот',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DetailInfo(
                      icon: Icons.book,
                      label: 'Предмет',
                      value: exam.subject,
                    ),
                    const Divider(height: 30),
                    DetailInfo(
                      icon: Icons.calendar_today,
                      label: 'Датум',
                      value: exam.formattedDate,
                    ),
                    const Divider(height: 30),
                    DetailInfo(
                      icon: Icons.access_time,
                      label: 'Време',
                      value: exam.formattedTime,
                    ),
                    const Divider(height: 30),
                    DetailInfo(
                      icon: Icons.meeting_room,
                      label: 'Простории',
                      value: exam.formattedRooms,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}