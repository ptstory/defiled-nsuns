import 'package:defiled_nsuns/cycle/exerciseset.dart';
import 'package:flutter/material.dart';

class Exercise {
  const Exercise({this.name, this.targetMuscle, this.sets});

  final String name;
  final TargetMuscle targetMuscle;
  final List<ExerciseSet> sets;
}

class ExerciseWidget extends StatefulWidget {
  ExerciseWidget({this.exercise});

  final Exercise exercise;

  @override
  State<StatefulWidget> createState() =>
      _ExerciseWidgetState(exercise: exercise);
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  _ExerciseWidgetState({this.exercise});

  final Exercise exercise;
  final EdgeInsets insets = const EdgeInsets.all(4);

  @override
  Widget build(BuildContext context) => Padding(
      padding: insets,
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1), border: Border.all()),
          child: Padding(
              padding: insets,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(exercise.name, style: TextStyle(fontSize: 30)),
                        ...exercise.sets.map((set) =>
                            ExerciseSetWidget(set: set))
                      ]))));
}

enum TargetMuscle { chest, shoulders, back, legs, abs, arms }
