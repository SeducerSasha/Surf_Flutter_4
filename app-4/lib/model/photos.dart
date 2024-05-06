import 'dart:convert';

/// Класс с данными о фотографии.
class Photos {
  /// Идентификатор (номер) фотографии.
  final int id;

  /// Адрес ссылки на фотографию.
  final String url;

  /// Заголовок фотографии.
  final String title;

  /// Описание фотографии.
  final String description;

  const Photos({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
  });

  /// Преобразование данных JSON в данные класса.
  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: (map["id"] ?? 0) as int,
      url: (map["url"] ?? '') as String,
      title: (map["title"] ?? '') as String,
      description: (map["description"] ?? '') as String,
    );
  }

  factory Photos.fromJson(String source) =>
      Photos.fromMap(json.decode(source) as Map<String, dynamic>);
}
