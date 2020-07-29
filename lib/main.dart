import 'package:defiled_nsuns/cycle/dayprogram.dart';
import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:defiled_nsuns/cycle/exerciseset.dart';
import 'package:flutter/material.dart';

List<DayProgram> programs = <DayProgram>[
  DayProgram(title: 'Bench/Overhead Press', exercises: <Exercise>[
    Exercise(
        name: 'Bench Press',
        targetMuscle: TargetMuscle.chest,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 60, repetitions: 8),
          ExerciseSet(weight: 65, repetitions: 6),
          ExerciseSet(weight: 70, repetitions: 1),
          ExerciseSet(weight: 65, repetitions: 6),
        ]),
    Exercise(
        name: 'Overhead Press',
        targetMuscle: TargetMuscle.shoulders,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 20, repetitions: 8),
          ExerciseSet(weight: 30, repetitions: 6),
          ExerciseSet(weight: 35, repetitions: 1),
          ExerciseSet(weight: 30, repetitions: 6),
        ]),
    Exercise(
        name: 'Bicep Curl',
        targetMuscle: TargetMuscle.arms,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 10, repetitions: 8),
          ExerciseSet(weight: 10, repetitions: 8),
          ExerciseSet(weight: 10, repetitions: 8)
        ])
  ])
];

class CycleConfigurator extends StatefulWidget {
  @override
  _CycleConfiguratorState createState() => _CycleConfiguratorState();
}

class _CycleConfiguratorState extends State<CycleConfigurator> {
  String _title = 'Loading...';

  @override
  void initState() {
    super.initState();
    _title = programs[0].title;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
          home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(_title),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.check),
                onPressed: () {
                  // Save workout and go to next program
                })
            ]),
              body: DayProgramWidget(dayProgram: programs[0])
      ));
}

void main() => runApp(CycleConfigurator());
