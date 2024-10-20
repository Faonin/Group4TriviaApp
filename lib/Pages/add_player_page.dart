import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:template/mechanics/player.dart';
import 'package:template/mechanics/mechanic.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({super.key});

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  List<Player> players = []; // To store added players' info
  Color _selectedColor = Colors.blue; // Default color
  final TextEditingController _playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Page title
            const Text(
              "Add players:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAddPlayerDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                '+',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Display added players
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: player.color,
                    ),
                    title: Text(player.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          players.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Bottom button to move to the next step
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            var multiplayer = GameMechanics(true, 10);
            multiplayer.addPlayers(players);
            multiplayer.start(context);
            // Implement navigation to the next step, such as selecting a category
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Select category',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showAddPlayerDialog() {
    String playerName = "";
    Color tempColor = _selectedColor; // Temporary color for the dialog

    DialogBackground(
      blur: 3,
      dialog: StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Add players:",
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Player name input field
                TextField(
                  controller: _playerNameController,
                  decoration: const InputDecoration(
                    labelText: "Player Name",
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    playerName = value;
                  },
                ),
                const SizedBox(height: 10),
                // Color picker for player
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Player color:",
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Show the color picker and update tempColor when done
                        Color? selectedColor = await _showColorPickerDialog();
                        if (selectedColor != null) {
                          setState(() {
                            tempColor = selectedColor; // Update the temporary color
                          });
                        }
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: tempColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog without saving
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (playerName.isNotEmpty) {
                    // Call setState on the parent widget to ensure the list updates
                    this.setState(() {
                      players.add(Player(playerName, tempColor)); // Use tempColor
                      _playerNameController.text = "";
                      _selectedColor = Colors.blue; // Reset the color
                    });
                    Navigator.of(context).pop(); // Close dialog after saving
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    ).show(context);
  }

  Future<Color?> _showColorPickerDialog() async {
    Color tempSelectedColor = _selectedColor; // Temporary variable to hold the selected color

    return showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Pick Player Color",
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              availableColors: [
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.lightBlue,
                Colors.cyan,
                Colors.teal,
                Colors.green,
                Colors.lightGreen,
                Colors.lime,
                Colors.yellow,
                Colors.amber,
                Colors.orange,
                Colors.deepOrange,
                Colors.brown,
                Colors.grey,
                Colors.blueGrey,
                Colors.black
              ],
              onColorChanged: (color) {
                tempSelectedColor = color; // Update the temp color when selected
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(null); // Return null if canceled
              },
            ),
            TextButton(
              child: const Text(
                "Select",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(tempSelectedColor); // Return selected color
              },
            ),
          ],
        );
      },
    );
  }
}
