import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:flutter/material.dart';

class DayProgram {
  const DayProgram({this.title, this.exercises});

  final String title;
  final List<Exercise> exercises;
}

class DayProgramWidget extends StatelessWidget {
  const DayProgramWidget({this.dayProgram});

  final DayProgram dayProgram;

  @override
  Widget build(BuildContext context) => Column(
      children: dayProgram.exercises
          .map((e) => ExerciseWidget(exercise: e))
          .toList());
}
