import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail_model.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  final MealDetail? mealDetail;

  const MealDetailScreen({
    Key? key,
    required this.mealId,
    this.mealDetail,
  }) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _apiService = ApiService();
  MealDetail? _mealDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.mealDetail != null) {
      _mealDetail = widget.mealDetail;
      _isLoading = false;
    } else {
      _loadMealDetail();
    }
  }

  Future<void> _loadMealDetail() async {
    setState(() => _isLoading = true);
    final detail = await _apiService.getMealDetail(widget.mealId);
    setState(() {
      _mealDetail = detail;
      _isLoading = false;
    });
  }

  Future<void> _launchYouTube(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mealDetail?.strMeal ?? 'Детали'),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mealDetail == null
              ? const Center(child: Text('Грешка при вчитување'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        _mealDetail!.strMealThumb,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _mealDetail!.strMeal,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Chip(
                                  label: Text(_mealDetail!.strCategory),
                                  backgroundColor: Colors.orange[100],
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  label: Text(_mealDetail!.strArea),
                                  backgroundColor: Colors.blue[100],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Состојки:',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...List.generate(
                              _mealDetail!.ingredients.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        size: 8, color: Colors.orange),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${_mealDetail!.measures[index]} ${_mealDetail!.ingredients[index]}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Инструкции:',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _mealDetail!.strInstructions,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_mealDetail!.strYoutube.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      _launchYouTube(_mealDetail!.strYoutube),
                                  icon: const Icon(Icons.play_circle_filled),
                                  label: const Text('Гледај на YouTube'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}