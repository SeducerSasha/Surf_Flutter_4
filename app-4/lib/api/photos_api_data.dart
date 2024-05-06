import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_courses_template/api/photos_api.dart';
import 'package:surf_flutter_courses_template/model/data.dart';
import 'package:surf_flutter_courses_template/model/photos.dart';

/// Класс для загрузки фотографий.
class PhotosApi implements IPhotosApi {
  /// Получение и обработка данных о фотографиях.
  @override
  Future<List<Photos>> getPhotosData() async {
    /// Получение данных о фотографиях в формате JSON.
    String photosJSON = await _loadJSonData();

    /// Преобразование данных JSON в данные класса Photos.
    return PhotosData.fromJson(photosJSON).photos;
  }

  Future<String> _loadJSonData() async {
    /// Адрес сайта с фотографиями, получаемы через API.
    const url = 'https://api.slingacademy.com/v1/sample-data/photos';

    /// Номер фотографии, с которой начинать.
    const offset = 0;

    /// Количество получаемых фотографий.
    const limit = 40;

    /// Отправка запроса на сервер и получение результата.
    final response =
        await (http.get(Uri.parse('$url?offset=$offset&limit=$limit')));

    /// Обработка статусов ответа сервера.
    if (response.statusCode >= 500) {
      throw 'Ошибка сервера';
    } else if (response.statusCode >= 400) {
      throw 'Ошибка клиента';
    } else if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == false) {
        return '';
      } else {
        return response.body;
      }
    } else {
      throw Exception('Неизвестная ошибка');
    }
  }
}
