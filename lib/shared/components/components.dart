import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(Map article, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 160,
        height: 120,
        child: article['urlToImage'] != null? Container(
          decoration: BoxDecoration(
            // color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}'
                ),
                fit: BoxFit.cover
            ),
          ),
        ) : Container(
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              'Image Not Found!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              )
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${article['title']}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${article['publishedAt']}',
              style: Theme.of(context).textTheme.bodyText2
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget mySeparator() =>Container(
  height: 1,
  width: double.infinity,
  color: Colors.grey[400],
);

Widget buildArticles(list) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => mySeparator(),
        itemCount: list.length),
    fallback: (context) => const Center(child: CircularProgressIndicator()));