import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(Map article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: article['urlToImage'] != null? Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            // color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}'
                ),
                fit: BoxFit.fill
            ),
          ),
        ) : Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              'Image Not Found!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
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
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${article['publishedAt']}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),
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
        itemBuilder: (context, index) => buildArticleItem(list[index]),
        separatorBuilder: (context, index) => mySeparator(),
        itemCount: list.length),
    fallback: (context) => const Center(child: CircularProgressIndicator()));