import 'package:dnd_dice_roller/models/dice_stats.dart';

class RollDetails {
  final List<DiceStats> results; // La lista dei dadi lanciati
  final int totalSum;                  // Il totale calcolato
  final int diceFaces;
  bool isRolling;
  bool isRolled;
  
  RollDetails({
    required this.results,
    required this.totalSum,
    required this.diceFaces,
    this.isRolling = false,
    this.isRolled = false,
  });

  // copyWith per Riverpod
  RollDetails copyWith({
    List<DiceStats>? results,
    int? totalSum,
    int? diceFaces,
    bool? isRolling,
    bool? isRolled,
  }) {
    return RollDetails(
      results: results ?? this.results,
      totalSum: totalSum ?? this.totalSum,
      diceFaces: diceFaces ?? this.diceFaces,
      isRolling: isRolling ?? this.isRolling,
      isRolled: isRolled ?? this.isRolled,
    );
  }
}