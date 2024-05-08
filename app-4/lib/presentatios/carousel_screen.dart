import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/constants/text_style.dart';
import 'package:surf_flutter_courses_template/model/photos.dart';

/// Экран с прокручивающимися фотографиями.
class CarouselScreen extends StatefulWidget {
  /// Список фотографий.
  final List<Photos> photos;

  /// Номер фотографии, на которой нажали.
  final int currentPhoto;
  const CarouselScreen({
    super.key,
    required this.photos,
    required this.currentPhoto,
  });

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  /// Контроллер, управляющий PageView.
  late PageController _pageController;

  /// Номер текущей страницы.
  late int currentPage;

  @override
  void initState() {
    /// Устанавливаем в качестве текущей страницы номер фотографии, на которой нажали.
    currentPage = widget.currentPhoto;

    /// Создаем контроллер, указывая в качестве текущей страницу с выбранной фотографией.
    _pageController = PageController(
      initialPage: widget.currentPhoto,
      viewportFraction: 0.8,
    );

    /// Устанавливаем подписку на изменение страницы PageView.
    _pageController.addListener(() {
      _onPageChanged();
    });
    super.initState();
  }

  void _onPageChanged() {
    /// Запоминаем предыдущую страницу.
    final prevPage = currentPage;

    /// Вычисляем новую страницу, которая станет текущей.
    currentPage = _pageController.page?.round() ?? currentPage;

    /// Перерисовываем, если страница изменилась.
    if (prevPage != currentPage) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Выводим в AppBar номер текущей фотографии и сколько всего фотографий есть в списке.
        actions: [
          Text(
            '${currentPage + 1}',
            style: TextStyleConstants.styleCurrentPhoto,
          ),
          Text(
            '/${widget.photos.length}',
            style: TextStyleConstants.styleCountPhoto,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: PageView.builder(
        /// Создаем PageView на основе списка фотографий.
        itemCount: widget.photos.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          return AnimatedScale(
            duration: const Duration(milliseconds: 300),
            scale: currentPage == index ? 1 : 0.8,
            child: ShowImage(
              widget: widget,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

/// Отображение фотографии.
class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.widget, required this.index});

  final CarouselScreen widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          /// Получаем изображение из сети по переданному адресу.
          widget.photos[index].url,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
