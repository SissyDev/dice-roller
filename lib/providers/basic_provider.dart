import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:dnd_dice_roller/models/dice_stats.dart';
import 'package:dnd_dice_roller/models/roll_details.dart';
import 'package:dnd_dice_roller/screens/basic_modal_sheet.dart';
import 'package:dnd_dice_roller/screens/custom_modal_sheet.dart';
import 'package:flutter_riverpod/legacy.dart';

class DiceNotifier extends StateNotifier<RollDetails> {
  DiceNotifier() : super(RollDetails(results: [], totalSum: 0, diceFaces: 0));
  late final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  //Get Dice Faces
  void getFaces(int faces) {
    state = state.copyWith(diceFaces: faces);
  }
  //Get Sound
  void playSound() async {
    await _player.stop();
    await _player.setVolume(0.6);
    await _player.play(AssetSource('sounds/dice_roll.mp3'));
  }

  //Get Basic Total
  Future<void> getBasicTotal(List<BasicRow> rows, int faces) async {
    state = state.copyWith(isRolling: true);
    playSound();
    int finalSum = 0;
    List<DiceStats> rollDetails = [];
    await Future.delayed(const Duration(seconds: 2)); //Wait for 2 Seconds
    //For Each Row Get the Multiplier, Modifier, Faces, Sum
    for (final row in rows) {
      int currentRowSum = 0;
      int randomSum = 0;
      int multiplier = int.tryParse(row.multiController.text.trim()) ?? 1;
      int modifier = int.tryParse(row.modController.text.trim()) ?? 0;
      for (var i = 0; i < (multiplier > 20 ? 20 : multiplier); i++) {
        randomSum += Random().nextInt(faces) + 1;
      }
      currentRowSum = randomSum + modifier;
      finalSum += currentRowSum;
      rollDetails.add(
        DiceStats(
          multiplier: multiplier,
          faces: faces,
          modifier: modifier,
          total: currentRowSum,
        ),
      );
    }
    state = state.copyWith(
      results: rollDetails,
      totalSum: finalSum,
      isRolling: false,
      isRolled: true,
    );
  }

  //Get Custom Total
  Future<void> getCustomTotal(List<CustomRow> rows) async {
    state = state.copyWith(isRolling: true); 
    playSound();
    int finalSum = 0;
    List<DiceStats> rollDetails = [];
    await Future.delayed(const Duration(seconds: 2)); //Wait for 2 Seconds
    //for each row get the faces, multiplier, modifier, sum
    for (final row in rows) {
      int faces = int.tryParse(row.facesController.text.trim()) ?? 1;
      int multiplier = int.tryParse(row.multiController.text.trim()) ?? 1;
      int modifier = int.tryParse(row.modController.text.trim()) ?? 0;
      int currentRowSum = 0;
      if (faces < 3 || faces > 100) continue;
      int randomSum = 0;
      for (var i = 0; i < (multiplier > 20 ? 20 : multiplier); i++) {
        randomSum += Random().nextInt(faces) + 1;
      }
      currentRowSum = randomSum + modifier;
      finalSum += currentRowSum;
      rollDetails.add(
        DiceStats(
          multiplier: multiplier,
          faces: faces,
          modifier: modifier,
          total: currentRowSum,
        ),
      );
    }
    state = state.copyWith(
      results: rollDetails,
      totalSum: finalSum,
      isRolling: false,
      isRolled: true,
    );
  }
}

final diceProvider = StateNotifierProvider<DiceNotifier, RollDetails>((ref) {
  return DiceNotifier();
});
