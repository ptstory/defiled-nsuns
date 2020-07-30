import 'package:defiled_nsuns/cycle/dayprogram.dart';
import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:defiled_nsuns/cycle/exerciseset.dart';
import 'package:flutter/material.dart';

class Accessories {
  static final bicepCurls = 'Bicep Curls';
  static final inclineBicepCurls = 'Incline Bicep Curls';
  static final tricepExtensions = 'Tricep Extensions';

  static final latPulldowns = 'Lat Pulldowns';
  static final machineRows = 'Machine Rows';

  static final dips = 'Dips';

  static final all = <String>[
    bicepCurls,
    inclineBicepCurls,
    tricepExtensions,
    latPulldowns,
    machineRows,
    dips
  ];
}

class AccessoryPopup extends StatefulWidget {
  const AccessoryPopup({this.callback, this.dayProgram});

  final Function(Exercise) callback;
  final DayProgram dayProgram;

  @override
  State<StatefulWidget> createState() =>
      _AccessoryPopupState(callback: callback, dayProgram: dayProgram);
}

class _AccessoryPopupState extends State<AccessoryPopup> {
  _AccessoryPopupState({this.callback, this.dayProgram});

  final Function(Exercise) callback;
  final DayProgram dayProgram;

  String _accessory;
  TextEditingController _repsController;
  FocusNode _repsFocusNode;
  TextEditingController _weightController;
  FocusNode _weightFocusNode;

  @override
  void initState() {
    super.initState();
    _accessory = Accessories.bicepCurls;
    _repsController = TextEditingController(text: '8');
    _repsFocusNode = FocusNode();
    _weightController = TextEditingController(text: '10');
    _weightFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Add Accessory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton(
                value: _accessory,
                items: Accessories.all
                    .map((accessory) => DropdownMenuItem(
                        value: accessory, child: Text(accessory)))
                    .toList(),
                onChanged: (accessory) {
                  setState(() {
                    _accessory = accessory;
                  });
                  _repsFocusNode.requestFocus();
                }),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SizedBox(
                  width: 22,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _repsController,
                      focusNode: _repsFocusNode,
                      onSubmitted: (text) => _weightFocusNode.requestFocus(),
                      textAlign: TextAlign.right)),
              Text(' reps at '),
              SizedBox(
                  width: 22,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _weightController,
                      focusNode: _weightFocusNode,
                      textAlign: TextAlign.right)),
              Text(' kg')
            ])
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                callback(Exercise(
                    name: _accessory,
                    targetMuscle: TargetMuscle.arms,
                    accessory: true,
                    sets: <ExerciseSet>[
                      ExerciseSet(
                          weight: int.tryParse(_weightController.text),
                          repetitions: int.tryParse(_repsController.text))
                    ]));
                Navigator.of(context).pop();
              })
        ],
      );
}
