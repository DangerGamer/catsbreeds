import 'package:dio/dio.dart';
import '../infrastructure/models/cat.dart';

class CatService {
  final Dio _dio = Dio();

  Future<List<Cat>> fetchCatsBreeds(String filter) async {
    final String baseUrl = "https://api.thecatapi.com/v1/breeds";
    final Map<String, String> parameters = {
      'api_key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
    };
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: parameters,
      );
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (filter.isEmpty) {
          return data.map((item) => Cat.fromJson(item)).toList();
        } else {
          final lowerCaseFilter = filter.toLowerCase();
          List<dynamic> filteredNames = data.where((item) {
            final name = item['name']?.toLowerCase() ?? '';
            return name.contains(lowerCaseFilter);
          }).toList();
          return filteredNames.map((item) => Cat.fromJson(item)).toList();
        }
      } else {
        throw Exception('Failed to load cat breeds: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cat breeds: $e');
      rethrow;
    }
  }

  Future<String?> fetchImageUrl(String id) async {
    final String baseUrl = 'https://api.thecatapi.com/v1/images/search';

    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'api_key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr',
          'limit': '1',
          'breed_ids': id,
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        if (data.isNotEmpty) {
          return data[0]['url'];
        }
      } else {
        throw Exception('Failed to load image URL: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      rethrow;
    }
    return null;
  }
}
