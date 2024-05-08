// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:surf_flutter_courses_template/api/photos_api_data.dart';
import 'package:surf_flutter_courses_template/model/photos.dart';
import 'package:surf_flutter_courses_template/presentatios/carousel_screen.dart';

/// Главный экран с мини-фотографиями.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset('assets/postogram.png'),
      ),
      body: const GridPhotos(),
    );
  }
}

/// Формирование сетки фотографий.
class GridPhotos extends StatelessWidget {
  const GridPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    /// Получаем список фотографий из сети.
    final Future<List<Photos>> photos = PhotosApi().getPhotosData();
    return FutureBuilder(
      /// Строим сетку на основе полученных данных.
      future: photos,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          /// Если данных еще нет - показывает индикатор прогресса.
          return const Center(child: CircularProgressIndicator());
        } else {
          /// Формируем сетку по полученным данным.
          return GridPhotosView(photos: snapshot.data!);
        }
      },
    );
  }
}

/// Построение сетки с фотографиями.
class GridPhotosView extends StatelessWidget {
  /// Список с данными фотографий.
  final List<Photos> photos;
  const GridPhotosView({
    Key? key,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        itemCount: photos.length,
        gridDelegate:

            /// Сетка с тремя колонками.
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, int index) {
          return PhotoItem(
            photos: photos,
            photoItem: photos[index],
            index: index,
          );
        });
  }
}

/// Вывод изображения фотографии.
class PhotoItem extends StatelessWidget {
  /// Список фотографий.
  final List<Photos> photos;

  /// Данные фотографии из списка.
  final Photos photoItem;

  /// Номер фотографии.
  final int index;
  const PhotoItem({
    Key? key,
    required this.photos,
    required this.photoItem,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      child: GestureDetector(
        /// При выборе фотографии открываем экран с каруселью фотографий.
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CarouselScreen(
              currentPhoto: index,
              photos: photos,
            ),
          ),
        ),
        child: Image.network(
          /// Вывод изображения в сетку по адресу в сети.
          photoItem.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
