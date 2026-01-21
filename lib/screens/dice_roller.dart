import 'package:flutter/material.dart';
import 'package:dnd_dice_roller/models/die.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key, required this.diceNumber});
  final String diceNumber;
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  String rolledDiceNumber = '4';
  List<Die> diceList = availableDice;
  double _turns = 0;
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _rollDice() async {
    await _player.stop();
    await _player.setVolume(0.6);
    await _player.play(AssetSource('sounds/dice_roll.mp3'));
    for (int i = 0; i < 12; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _turns += 1.5; // numero di giri (1 = 360°)
        rolledDiceNumber = (Random().nextInt(int.parse(widget.diceNumber)) + 1)
            .toString();
      });
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      AnimatedRotation(
                        turns: _turns,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          'assets/images/d${widget.diceNumber}.png',
                          height: 400,
                        ),
                      ),
                      Positioned(
                        top: 175,
                        bottom: 172,
                        left: 30,
                        right: 30,
                        child: Container(
                          color: const Color.fromARGB(139, 0, 0, 0),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Center(
                            child: Text(
                              rolledDiceNumber,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    rolledDiceNumber,
                    key: ValueKey(rolledDiceNumber),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(onPressed: _rollDice, child: Text('Roll Dice')),
          ],
        ),
      ),
    );
  }
}
