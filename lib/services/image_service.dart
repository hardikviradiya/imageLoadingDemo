import 'package:dio/dio.dart';
import 'package:image_loading_demo/models/image_model.dart';
import 'package:image_loading_demo/utils/api_constants.dart';

class ImageService {
  final Dio _dio = Dio();

  Future<List<ImageModel>> fetchImages(int page) async {
    try {
      final response = await _dio.get(
        '$pixabayBaseUrl?key=$pixabayApiKey',
        queryParameters: {
          'page': page,
          'per_page': 20,
        },
      );
      final List<dynamic> data = response.data['hits'];
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load images');
    }
  }
}
