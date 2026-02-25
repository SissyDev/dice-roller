class DiceStats {
  const DiceStats({
    required this.multiplier,
    required this.faces,
    required this.modifier,
    required this.total,
  });
  final int multiplier;
  final int faces;
  final int modifier;
  final int total;

  DiceStats copyWith({int? multiplier, int? faces, int? modifier, int? total}) {
    return DiceStats(
      multiplier: multiplier ?? this.multiplier,
      faces: faces ?? this.faces,
      modifier: modifier ?? this.modifier,
      total: total ?? this.total,
    );
  }
}
