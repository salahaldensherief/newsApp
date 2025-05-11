import 'package:app_news/core/service/news_services.dart';
import 'package:app_news/features/presentation/views/news_details_view.dart';
import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  @override
  State<CustomCarouselSlider> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CustomCarouselSlider> {
  bool isLoading = true;
  List<ArticleModel> articles = [];
  @override
  void initState() {
    super.initState();
    getGeneralNews();
  }

  Future<void> getGeneralNews() async {
    articles = await NewsService(Dio()).getNews();
    isLoading = false;
    setState(() {});
  }

  int _current = 0;
  final carousel.CarouselSliderController _controller =
      carousel.CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(color: Colors.blue))
        : Column(
          children: [
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: articles.length,
              itemBuilder: (context, index, realIndex) {
                final article = articles[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (_) => NewsDetailsPage(index: index),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: article.imgUrl!,
                            fit: BoxFit.cover,
                            width: 1000.0,
                            placeholder:
                                (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ), // صورة التحميل
                            errorWidget:
                                (context, url, error) =>
                                    Icon(Icons.error), // صورة في حالة وجود خطأ
                          ),
                          Positioned(
                            top: 10,
                            left: 20,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.author != null && article.author!.isNotEmpty
                                      ? article.author!.length > 20
                                      ? article.author!.substring(0, 20) + '...'
                                      : article.author!
                                      : 'Unkown',

                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    maxLines: 2,
                                    '${article.author} • ${article.sharedAt}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    maxLines: 2,
                                    article.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.15,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  articles.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        );
  }
}
