import 'package:app_news/core/service/news_services.dart';
import 'package:app_news/features/presentation/views/widgets/news_details_view.dart';
import 'package:app_news/features/presentation/views/widgets/news_detalis_view_body.dart';
import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatefulWidget {
  final int index;
  const NewsDetailsPage({super.key, required this.index});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  List<ArticleModel> articles = [];
  @override
  void initState() {
    getGeneralNews();
    super.initState();
  }

  Future<void> getGeneralNews() async {
    articles = await NewsService(Dio()).getNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (articles.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                NewsDetailsAppBar(index: widget.index),
                SliverToBoxAdapter(
                  child: NewsDetailsBody(articleModel: articles[widget.index]),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.white, Colors.white.withOpacity(0)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
