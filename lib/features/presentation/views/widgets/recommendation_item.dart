import 'package:app_news/core/service/news_services.dart';
import 'package:app_news/features/presentation/views/news_details_view.dart';
import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatefulWidget {
  final List<NewsItem> news;

  const RecommendationItem({super.key, required this.news});

  @override
  State<RecommendationItem> createState() => _RecommendationItemState();
}

class _RecommendationItemState extends State<RecommendationItem> {
  bool isLoading = true;
  List<ArticleModel> articles = [];
  @override
  void initState() {
    super.initState();
    getGeneralNews();
  }

  Future<void> getGeneralNews() async {

    articles = await NewsService(Dio()).getNews();
    isLoading = false ;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          articles.asMap().entries.map((entry) {
            final index = entry.key;
            final articles = entry.value;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NewsDetailsPage(index: index),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child:  CachedNetworkImage(
                      imageUrl:articles.imgUrl?? '',
                      fit: BoxFit.cover,
                      width: 200,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.blue,)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articles.author != null && articles.author!.isNotEmpty
                                ? articles.author!.length > 20
                                ? articles.author!.substring(0, 20) + '...'
                                : articles.author!
                                : 'Unkown',
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            articles.title,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyLarge
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${articles.author} • ${articles.sharedAt}',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
