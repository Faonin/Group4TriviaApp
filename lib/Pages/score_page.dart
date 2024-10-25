import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/mechanics/player.dart';
import 'package:template/pages/home_page.dart';
import 'package:template/pages/player_select_page.dart';

class ScorePage extends StatelessWidget {
  final List<Player> players;
  ScorePage(this.players, {super.key});

  @override
  Widget build(BuildContext context) {
    // Sort players by score in descending order
    players.sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {}, // Placeholder for future menu functionality
            ),
          ),
        ],
      ),
      body: players.isEmpty
          ? Center(
              child: Text(
                'No players available',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Winner: ${players.first.name}!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: players.first.color,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (players.length > 2)
                      Column(
                        children: [
                          Text(
                            players[2].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: players[2].color,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: 80,
                                height: 120,
                                color: Colors.orange,
                              ),
                              Positioned(
                                top: 10,
                                child: Text(
                                  'Score: ${players[2].score}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(width: 20),
                    if (players.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            players[0].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: players[0].color,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: 80,
                                height: 160,
                                color: Colors.yellow,
                              ),
                              Positioned(
                                top: 10,
                                child: Text(
                                  'Score: ${players[0].score}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(width: 20),
                    if (players.length > 1)
                      Column(
                        children: [
                          Text(
                            players[1].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: players[1].color,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: 80,
                                height: 140,
                                color: Colors.grey,
                              ),
                              Positioned(
                                top: 10,
                                child: Text(
                                  'Score: ${players[1].score}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: players.length > 3 ? players.length - 3 : 0,
                    itemBuilder: (context, index) {
                      final player = players[index + 3];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: Container(
                          color: Colors.grey[300],
                          child: ListTile(
                            title: Text('${index + 4}th: ${player.name}'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerSelectionPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Play Again',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(title: "Trivia App"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Main Menu',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 75),
                        child: ElevatedButton(
                          onPressed: () {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Exit Game',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
