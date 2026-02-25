import 'package:dnd_dice_roller/providers/basic_provider.dart';
import 'package:dnd_dice_roller/screens/custom_modal_sheet.dart';
import 'package:dnd_dice_roller/widgets/custom_choice.dart';
import 'package:dnd_dice_roller/widgets/dice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_background/animated_background.dart';

const availableDice = ['4', '6', '8', '10', '12', '20'];

class DiceChoice extends ConsumerStatefulWidget {
  const DiceChoice({super.key});
  @override
  ConsumerState<DiceChoice> createState() => _DiceChoiceState();
}

class _DiceChoiceState extends ConsumerState<DiceChoice>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(context) {
    final diceProv = ref.watch(diceProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      //AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dice_roller.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const SizedBox(width: 220, height: 60),
        ),
      ),

      body: Stack(
        children: [
         //Animated Background
          AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                image: Image.asset('assets/images/sparkle.png', height: 10,),
                baseColor:Color.fromARGB(255, 0, 255, 251),
                minOpacity: 0.1,
                maxOpacity: 0.9,
                opacityChangeRate: 0.25,
                particleCount: 300,
                spawnOpacity: 0,
                spawnMaxSpeed: 10.0,
                spawnMinSpeed: 5.0,
                spawnMinRadius: 1,
                spawnMaxRadius: 10,
              ),
            ),
            vsync: this,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  //Results Screen
                  diceProv.isRolled ==
                          true //If isRolled Show Results
                      ? Column(
                          children: [
                            //Scroll + Results Text
                            CustomChoice(
                              initialDiceList: diceProv.results,
                              initialResult: diceProv.totalSum,
                              onChanged: (value) {},
                            ),
                            Container(
                              //Reset Button
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/reset_button.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(89, 0, 0, 0),
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () =>
                                    setState(() => diceProv.isRolled = false),
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      //Normal Screen if !isRolled
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/tavola.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                        ),
                                    itemCount: availableDice.length,
                                    itemBuilder: (context, index) => DiceCard(
                                      diceNumber: availableDice[index]
                                          .toString(),
                                    ), //Standard Dice Card Widget
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 60),
                            //Custom Roll
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/custom_dice.png',
                                  height: 200,
                                ),
                                Positioned(
                                  top: 80,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/custom_roll.png',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (ctx) =>
                                              CustomModalSheet(), //Custom Modal Sheet + Reset Button
                                        );
                                      },
                                      child: const SizedBox(
                                        width: 150,
                                        height: 70,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Rolling Animation
          if (diceProv.isRolling)
            Container(
              color: Colors.black87,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/rolling_dice.json',
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Rolling Dice...",
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
