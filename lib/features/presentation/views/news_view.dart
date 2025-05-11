import 'package:app_news/features/presentation/views/widgets/custom_app_bar.dart';
import 'package:app_news/features/presentation/views/widgets/custom_carousel_slider_widgets.dart';
import 'package:app_news/features/presentation/views/widgets/home_title_widget.dart';
import 'package:app_news/features/presentation/views/widgets/recommendation_item.dart';
import 'package:app_news/models/news_item.dart';

import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {

  const NewsView({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const CustomAppBar(),
              const SizedBox(height: 10),
              const HomeTitleWidget(title: 'Breaking News'),
              const SizedBox(height: 10),

              CustomCarouselSlider(),
              const SizedBox(height: 10),
              const HomeTitleWidget(title: 'Recommendations'),
              const SizedBox(height: 10),

              RecommendationItem(news: news,),
            ],
          ),
        ),
      ),
    );
  }
}
