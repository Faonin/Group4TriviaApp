import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  final List categories = [
    "All Categories",
    "General Knowledge",
    "Entertainment: Books",
    "Entertainment: Film",
    "Entertainment: Music",
    "Entertainment: Musicals & Theatres",
    "Entertainment: Television",
    "Entertainment: Video Games",
    "Entertainment: Board Games",
    "Science & Nature",
    "Science: Computers",
    "Science: Mathematics",
    "Mythology",
    "Sports",
    "Geography",
    "History",
    "Politics",
    "Art",
    "Celebrities",
    "Animals",
    "Vehicles",
    "Entertainment: Comics",
    "Science: Gadgets",
    "Entertainment: Japanese Anime & Manga",
    "Entertainment: Cartoon & Animations"
  ];

  SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Text(
            categories[index],
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}
