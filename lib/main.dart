import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/mechanics/leaderboard_provider.dart';
import 'package:template/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LeaderboardProvider state = LeaderboardProvider();
  state.updateLeaderboard();
  runApp(ChangeNotifierProvider(create: (context) => state, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue), // App color scheme
      ),
      home: const MyHomePage(title: 'The One And Only Amazing Trivia App'),
      debugShowCheckedModeBanner: false,
    );
  }
}
