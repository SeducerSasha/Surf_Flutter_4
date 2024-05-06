import 'package:surf_flutter_courses_template/model/photos.dart';

/// Интерфейс для загрузки фотографий.
abstract interface class IPhotosApi {
  Future<List<Photos>> getPhotosData();
}
