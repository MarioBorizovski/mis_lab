import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';
import '../models/meal_detail_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> loadCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories.php'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoriesJson = data['categories'];
        return categoriesJson.map((json) => Category.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error loading categories: $e');
      return [];
    }
  }

  Future<List<Meal>> loadMealsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/filter.php?c=$category'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> mealsJson = data['meals'] ?? [];
        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error loading meals: $e');
      return [];
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?s=$query'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];
        
        if (mealsJson == null) return [];
        
        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error searching meals: $e');
      return [];
    }
  }

  Future<MealDetail?> getMealDetail(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/lookup.php?i=$id'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];
        
        if (mealsJson != null && mealsJson.isNotEmpty) {
          return MealDetail.fromJson(mealsJson[0]);
        }
      }
      return null;
    } catch (e) {
      print('Error loading meal detail: $e');
      return null;
    }
  }

  Future<MealDetail?> getRandomMeal() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/random.php'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];
        
        if (mealsJson != null && mealsJson.isNotEmpty) {
          return MealDetail.fromJson(mealsJson[0]);
        }
      }
      return null;
    } catch (e) {
      print('Error loading random meal: $e');
      return null;
    }
  }
}