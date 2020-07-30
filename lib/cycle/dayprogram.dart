import 'package:defiled_nsuns/cycle/accessorypopup.dart';
import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:defiled_nsuns/cycle/exerciseset.dart';
import 'package:flutter/material.dart';

class DayProgram {
  const DayProgram({this.title, this.exercises});

  final String title;
  final List<Exercise> exercises;
}

List<DayProgram> programs = <DayProgram>[
  DayProgram(title: 'Bench/Overhead Press', exercises: <Exercise>[
    Exercise(
        name: 'Bench Press',
        targetMuscle: TargetMuscle.chest,
        accessory: false,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 60, repetitions: 8),
          ExerciseSet(weight: 65, repetitions: 6),
          ExerciseSet(weight: 70, repetitions: 1),
          ExerciseSet(weight: 65, repetitions: 6),
        ]),
    Exercise(
        name: 'Overhead Press',
        targetMuscle: TargetMuscle.shoulders,
        accessory: false,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 20, repetitions: 8),
          ExerciseSet(weight: 30, repetitions: 6),
          ExerciseSet(weight: 35, repetitions: 1),
          ExerciseSet(weight: 30, repetitions: 6),
        ]),
    Exercise(
        name: 'Bicep Curl',
        targetMuscle: TargetMuscle.arms,
        accessory: true,
        sets: <ExerciseSet>[
          ExerciseSet(weight: 10, repetitions: 8),
          ExerciseSet(weight: 10, repetitions: 8),
          ExerciseSet(weight: 10, repetitions: 8)
        ])
  ])
];

class DayProgramWidget extends StatefulWidget {
  const DayProgramWidget({this.dayProgram});

  final DayProgram dayProgram;

  @override
  State<StatefulWidget> createState() =>
      _DayProgramWidgetState(dayProgram: dayProgram);
}

class _DayProgramWidgetState extends State<DayProgramWidget> {
  _DayProgramWidgetState({this.dayProgram});

  final DayProgram dayProgram;

  bool extended = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(dayProgram.title),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  // Save workout and go to next program
                })
          ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                child: AccessoryPopup(
                    callback: addExercise, dayProgram: dayProgram));
          }),
      body: ListView(
          children: dayProgram.exercises
              .map((e) => ExerciseWidget(exercise: e))
              .toList()));

  void addExercise(Exercise exercise) {
    setState(() {
      dayProgram.exercises.add(exercise);
    });
  }
}
