import 'package:dnd_dice_roller/models/die.dart';
import 'package:dnd_dice_roller/screens/dice_roller.dart';
import 'package:flutter/material.dart';

class DiceCard extends StatelessWidget {
  const DiceCard({super.key, required this.diceNumber});
  final String diceNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Theme.of(context).hintColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiceRoller(diceNumber: diceNumber,)),
            );
          },
          child: Stack(
            children: [
              Image.asset('assets/images/d$diceNumber.png', width: 150),
              Positioned(
                top: 32,
                bottom: 32,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color.fromARGB(139, 0, 0, 0),
                  padding: EdgeInsets.symmetric(vertical: 4),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Center(
                    child: Text(
                      'D$diceNumber',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
