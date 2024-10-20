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
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: "Select a category:\n", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
            );
          }
          index -= 1;
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, index);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 19, 29, 46),
                ),
                padding: EdgeInsets.all(15),
                child: Text(
                  categories[index],
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
