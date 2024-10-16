import 'package:flutter/material.dart';
import 'package:template/question_class.dart';
import 'package:template/question_featcher.dart';
import 'package:template/question_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The One And Only Amazing Trivia App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<QuestionClass> questions = await Questionfeatcher.getQuestions(1);
          QuestionClass question = questions.first;
          if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(question)));
        },
        tooltip: 'Testing',
        child: const Icon(Icons.question_mark, color: Colors.black),
      ),
    );
  }
}
