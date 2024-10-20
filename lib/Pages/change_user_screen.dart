import 'package:flutter/material.dart';
import 'package:template/mechanics/player.dart';

class ChangeUserScreen extends StatelessWidget {
  final Player user;
  ChangeUserScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: "Next players turn:\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, color: Colors.black), children: [
              TextSpan(
                text: "${user.name}!",
                style: TextStyle(fontSize: 50, color: user.color),
              )
            ]),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Phone Recived!",
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
        Image(
          image: AssetImage('assets/hand_over_phone.png'),
        )
      ]),
    );
  }
}
