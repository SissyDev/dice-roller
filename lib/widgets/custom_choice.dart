import 'package:dnd_dice_roller/providers/basic_provider.dart';
import 'package:dnd_dice_roller/screens/custom_modal_sheet.dart';
import 'package:dnd_dice_roller/models/dice_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomChoice extends ConsumerStatefulWidget {
  const CustomChoice({
    super.key,
    required this.onChanged,
    this.initialDiceList,
    this.initialResult,
  });
  final Function(String? value) onChanged;
  final List<DiceStats>? initialDiceList;
  final int? initialResult;
  @override
  ConsumerState<CustomChoice> createState() => _CustomChoiceState();
}

class _CustomChoiceState extends ConsumerState<CustomChoice> {
  void _openModalSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => CustomModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final diceProv = ref.watch(diceProvider);
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/images/pergamena.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              right: 50,
              bottom: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Roll Details',
                    style: TextStyle(
                      fontFamily: 'Modesto-Condensed',
                      fontSize: 40,
                      color: const Color.fromARGB(255, 102, 58, 25),
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Divider(color: Color(0x442D1B0D), thickness: 1.5),

                  Expanded(
                    child: diceProv.results.isEmpty
                        ? const Center(
                            child: Text(
                              'No Dice Rolled Yet.',
                              style: TextStyle(
                                fontFamily: 'Modesto-Text-Light',
                                fontSize: 18,
                                color: Color.fromARGB(255, 102, 58, 25),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: diceProv.results.length,
                            itemBuilder: (ctx, index) => Text(
                              '• ${diceProv.results[index].multiplier}d${diceProv.results[index].faces} + ${diceProv.results[index].modifier} = ${diceProv.results[index].total}',
                              style: const TextStyle(
                                fontFamily: 'Modesto-Text-Light',
                                fontSize: 18,
                                color: Color.fromARGB(255, 102, 58, 25),
                              ),
                            ),
                          ),
                  ),

                  const Divider(color: Color(0x442D1B0D), thickness: 1.5),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 35, top: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/plus.png'),
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(89, 0, 0, 0),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: _openModalSheet,
                            child: SizedBox(width: 35, height: 40),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/insegna.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 6,
                              top: 2,
                              left: 15,
                              right: 15,
                            ),
                            child: Text(
                              'Total: ${diceProv.totalSum}',
                              style: TextStyle(
                                fontFamily: 'Modesto-Condensed',
                                fontSize: 30,
                                letterSpacing: 1.2,
                                color: Color(0xFFFFF5D7),
                                shadows: [
                                  Shadow(
                                    offset: Offset(-0.5, -0.5),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(0.5, -0.5),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(0.5, 0.5),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(-0.5, 0.5),
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
