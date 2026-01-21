import 'package:dnd_dice_roller/widgets/dice_card.dart';
import 'package:flutter/material.dart';
import 'package:dnd_dice_roller/models/die.dart';

class DiceChoice extends StatefulWidget {
  const DiceChoice({super.key});
  @override
  State<DiceChoice> createState() {
    return _DiceChoiceState();
  }
}

class _DiceChoiceState extends State<DiceChoice> {
  final List<Die>diceList = availableDice;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dice Roller')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a Die',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: diceList.length,
                itemBuilder: (context, index) =>
                    DiceCard(diceNumber: diceList[index].number),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
