// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:surf_flutter_courses_template/model/photos.dart';

/// Модель получаемых данных с сервера.
class PhotosData {
  /// Результат ответа
  final bool success;

  /// Список данных о фотографии.
  final List<Photos> photos;
  const PhotosData({
    required this.success,
    required this.photos,
  });

  /// Преобразование данных из JSON в данные класса.
  factory PhotosData.fromMap(Map<String, dynamic> map) {
    return PhotosData(
      success: (map["success"] ?? false) as bool,
      photos: List<Photos>.from(
        ((map['photos'] ?? const <Photos>[]) as List).map<Photos>((x) {
          return Photos.fromMap(
              (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
    );
  }

  factory PhotosData.fromJson(String source) =>
      PhotosData.fromMap(json.decode(source) as Map<String, dynamic>);
}
