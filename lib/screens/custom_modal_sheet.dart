import 'package:dnd_dice_roller/providers/basic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class CustomRow {
  final String id;
  final TextEditingController facesController = TextEditingController();
  final TextEditingController multiController = TextEditingController();
  final TextEditingController modController = TextEditingController();
  CustomRow(this.id);

  void dispose() {
    facesController.dispose();
    multiController.dispose();
    modController.dispose();
  }
}

class CustomModalSheet extends ConsumerStatefulWidget {
  const CustomModalSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CustomModalSheetState();
  }
}

class _CustomModalSheetState extends ConsumerState<CustomModalSheet> {
  bool isChanged = false;
  bool isLimitReached = false;
  bool isError = false;
  List<CustomRow> customRow = [CustomRow('')];

  //Error Text Management
  String? _getRowError(int index) {
    final row = customRow[index];
    final int? faces = int.tryParse(row.facesController.text.trim());
    final int? multi = int.tryParse(row.multiController.text.trim());
    final int? mod = int.tryParse(row.modController.text.trim());
    //Faces
    if (row.facesController.text.isNotEmpty) {
      if (faces == null || faces < 3 || faces == 0) return 'Faces min: 3';
      if (faces > 100) return 'Faces max: 100';
    }
    //Multiplier
    if (row.multiController.text.isNotEmpty) {
      if (multi == null || multi < 1 || multi == 0) return 'Multiplier min: 1';
      if (multi > 20) return 'Multiplier max: 20';
    }
    //Modifier
    if (row.modController.text.isNotEmpty) {
      if (mod! > 20) return 'Modifier: max 20';
    }
    return null;
  }

  @override
  void dispose() {
    for (var row in customRow) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() {
    if (customRow.length < 5) {
      setState(() {
        customRow.add(CustomRow(uuid.v4()));
      });
    } else {
      setState(() {
        isLimitReached = true;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final diceNot = ref.watch(diceProvider.notifier);
    double keyboardHeigth = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Stack(
        children: [
          //Background Image
          Positioned.fill(
            child: Image.asset('assets/images/modal_bg.png', fit: BoxFit.cover),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Column(
              children: [
                // Scrollable Part
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: keyboardHeigth + 20),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: customRow.length,
                          itemBuilder: (context, index) => Padding(
                            key: ValueKey(customRow[index].id),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Faces Container
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/insegna.png',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 55,
                                          child: TextField(
                                            controller: customRow[index]
                                                .facesController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              hintText: 'Faces',
                                            ),
                                            onChanged: (String? value) =>
                                                setState(() {
                                                  isChanged = true;
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    // Multiplier Container
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/insegna.png',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: 60,
                                        height: 55,
                                        child: TextField(
                                          controller:
                                              customRow[index].multiController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            hintText: 'x1',
                                          ),
                                          onChanged: (String? value) =>
                                              setState(() {}),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    // Modifier Container
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/insegna.png',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: 60,
                                        height: 55,
                                        child: TextField(
                                          controller:
                                              customRow[index].modController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            hintText: '+0',
                                          ),
                                          onChanged: (String? value) =>
                                              setState(() {}),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    /// Remove Row Button
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/meno.png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (customRow.length > 1) {
                                              customRow.remove(
                                                customRow[index],
                                              );
                                              isLimitReached = false;
                                            } else {
                                              return;
                                            }
                                          });
                                        },
                                        child: SizedBox(height: 45, width: 45),
                                      ),
                                    ),
                                  ],
                                ),

                                //Error Text Builder
                                Builder(
                                  builder: (context) {
                                    final errorMsg = _getRowError(index);
                                    return SizedBox(
                                      height: 9,
                                      child: Text(
                                        errorMsg ?? '',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                            255,
                                            243,
                                            150,
                                            150,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Buttons Row
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 43),
                  child: Row(
                    children: [
                      //Add Dice Button
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/add_dice.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: InkWell(
                                onTap: _addRow,
                                child: SizedBox(width: 120, height: 55),
                              ),
                            ),
                          ),
                          if (isLimitReached)
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // stesso raggio del bottone
                                child: Container(
                                  color: Colors.black.withAlpha(150),
                                ),
                              ),
                            ),
                        ],
                      ),

                      const Spacer(),
                      //Roll Dice Button
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/roll_dice.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            diceNot.getCustomTotal(customRow);
                            isChanged = false;
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(width: 150, height: 60),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
