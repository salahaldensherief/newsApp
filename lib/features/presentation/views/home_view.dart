import 'package:app_news/features/presentation/views/widgets/bottom_navigation_bar_widget.dart';
import 'package:app_news/models/news_item.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BottomNavigationBarWidget( news: news,),
    );
  }
}
