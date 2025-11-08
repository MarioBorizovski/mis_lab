import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final isPast = exam.isPast;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: exam);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPast ? Colors.grey.shade300 : Colors.red.shade300,
            width: 2,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: isPast
                  ? [Colors.grey.shade100, Colors.grey.shade200]
                  : [Colors.red.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Наслов на предметот
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: isPast ? Colors.grey : Colors.red,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exam.subject,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isPast ? Colors.grey.shade700 : Colors.black,
                        ),
                      ),
                    ),
                    if (isPast)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: isPast ? Colors.grey : Colors.red.shade700,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      exam.formattedDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: isPast ? Colors.grey.shade600 : Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      color: isPast ? Colors.grey : Colors.red.shade700,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      exam.formattedTime,
                      style: TextStyle(
                        fontSize: 16,
                        color: isPast ? Colors.grey.shade600 : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.meeting_room,
                      color: isPast ? Colors.grey : Colors.red.shade700,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exam.formattedRooms,
                        style: TextStyle(
                          fontSize: 16,
                          color: isPast ? Colors.grey.shade600 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}