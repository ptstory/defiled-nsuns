import 'package:flutter/material.dart';

class Exercise {
  const Exercise({this.name, this.targetMuscle, this.sets});

  final String name;
  final TargetMuscle targetMuscle;
  final List<ExerciseSet> sets;
}

class ExerciseSet {
  const ExerciseSet({this.weight, this.repetitions, this.amrap});

  final int weight;
  final int repetitions;
  final bool amrap;

  String repetitionsToString() {
    var reps = repetitions.toString();
    if (amrap) {
      reps = reps + '+';
    }
    return reps;
  }
}

// Add field to log actual reps
class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({this.exercise});

  final Exercise exercise;
  final TextStyle textStyle = const TextStyle(fontSize: 20);
  final EdgeInsets insets = const EdgeInsets.all(4);

  @override
  Widget build(BuildContext context) => Padding(
      padding: insets,
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 0, 0, 0.1), border: Border.all()),
          child: Padding(
              padding: insets,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(exercise.name, style: TextStyle(fontSize: 30)),
                    ...exercise.sets.map((set) => Padding(
                        padding: insets,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 255, 0.1),
                                border: Border.all()),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text('weight'),
                                    Text('${set.weight} kg', style: textStyle)
                                  ]),
                                  Column(
                                    children: <Widget>[
                                      Text('reps'),
                                      Text(set.repetitionsToString(),
                                          style: textStyle)
                                    ],
                                  )
                                ]))))
                  ]))));
}

enum TargetMuscle { chest, shoulders, back, legs, abs }
