import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:flutter/material.dart';

class NewsDetailsBody extends StatelessWidget {
  final ArticleModel articleModel;
  const NewsDetailsBody({super.key, required this.articleModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(articleModel.imgUrl!)),
              const SizedBox(width: 8.0),
              Text(
                articleModel.author!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            articleModel.content,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Read Full Article',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
