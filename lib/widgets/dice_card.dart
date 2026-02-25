import 'package:dnd_dice_roller/providers/basic_provider.dart';
import 'package:dnd_dice_roller/screens/basic_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceCard extends ConsumerWidget {
  const DiceCard({super.key, required this.diceNumber});
  final String diceNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          //Dice Frame
          /* decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/stone_round.png'),
              fit: BoxFit.cover,
            ),
          ), */

          //Dice Clickable Pictures
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: Theme.of(context).hintColor,
            onTap: () {
              ref.read(diceProvider.notifier).getFaces(int.parse(diceNumber));
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => BasicModalSheet(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/d${diceNumber}_blu.png',
                  ),
                  alignment: AlignmentGeometry.bottomRight,
                  fit: BoxFit.contain,
                 ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
