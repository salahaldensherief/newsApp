import 'package:app_news/core/service/news_services.dart';
import 'package:app_news/features/presentation/views/widgets/app_bar_icon.dart';
import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsDetailsAppBar extends StatefulWidget {
  final int index;
  const NewsDetailsAppBar({super.key, required this.index});

  @override
  State<NewsDetailsAppBar> createState() => _NewsDetailsAppBarState();
}

class _NewsDetailsAppBarState extends State<NewsDetailsAppBar> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return isLoading
        ? SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator(color: Colors.blue)),
        )
        : SliverAppBar(
          expandedHeight: size.height * 0.4,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: AppBarIcon(
              icon: Icons.chevron_left,
              iconSize: 30,
              onTap: Navigator.of(context).pop,
            ),
          ),
          leadingWidth: 40,
          actions: [const SizedBox(width: 6.0), const SizedBox(width: 6.0)],
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: FlexibleSpaceBar(
            background:
                articles.isNotEmpty
                    ? Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            articles[widget.index].imgUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    articles[widget.index].author ??
                                        'Unknown Author',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              SizedBox(
                                width: size.width * 0.9,
                                child: Text(
                                  articles[widget.index].title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${articles[widget.index].author} • ${articles[widget.index].sharedAt}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    :  Center(
                      child: SliverToBoxAdapter(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            stretchModes:  [
              StretchMode.blurBackground,

              StretchMode.zoomBackground,
            ],
          ),
          pinned: true,
          bottom:  PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox(
              height: 30,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(36.0),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
