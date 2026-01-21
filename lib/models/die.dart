import 'package:flutter/material.dart';

class Die {
  const Die({required this.number, required this.mainImage});
  final String number;
  final Image mainImage;
}

final availableDice = [
  Die(
    number: '4',
    mainImage: Image.asset('assets/images/d4.png'),
  ),
  Die(
    number: '6',
    mainImage: Image.asset('assets/images/d6.png'),
  ),
  Die(
    number: '8',
    mainImage: Image.asset('assets/images/d8.png'),
  ),
    Die(
    number: '10',
    mainImage: Image.asset('assets/images/d10.png'),
  ),
    Die(
    number: '12',
    mainImage: Image.asset('assets/images/d12.png'),
  ),
    Die(
    number: '20',
    mainImage: Image.asset('assets/images/d20.png'),
  ),
];
