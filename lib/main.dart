import 'package:defiled_nsuns/cycle/dayprogram.dart';
import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:flutter/material.dart';

const List<DayProgram> programs = const <DayProgram>[
  DayProgram(title: 'Bench/Overhead Press', exercises: const <Exercise>[
    Exercise(
        name: 'Bench Press',
        targetMuscle: TargetMuscle.chest,
        sets: const <ExerciseSet>[
          ExerciseSet(weight: 60, repetitions: 8),
          ExerciseSet(weight: 65, repetitions: 6),
          ExerciseSet(weight: 70, repetitions: 1),
          ExerciseSet(weight: 65, repetitions: 6),
        ]),
    Exercise(
        name: 'Overhead Press',
        targetMuscle: TargetMuscle.shoulders,
        sets: const <ExerciseSet>[
          ExerciseSet(weight: 20, repetitions: 8),
          ExerciseSet(weight: 30, repetitions: 6),
          ExerciseSet(weight: 35, repetitions: 1),
          ExerciseSet(weight: 30, repetitions: 6),
        ])
  ])
];

class CycleConfigurator extends StatefulWidget {
  @override
  _CycleConfiguratorState createState() => _CycleConfiguratorState();
}

class _CycleConfiguratorState extends State<CycleConfigurator>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _title = 'Loading...';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: programs.length, vsync: this);
    _title = programs[0].title;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
    setState(() {
      _title = programs[newIndex].title;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
          home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(_title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _nextPage(-1);
                }),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    _nextPage(1);
                  })
            ]),
        body: TabBarView(
            controller: _tabController,
            children: programs
                .map((program) => DayProgramWidget(dayProgram: program))
                .toList()),
      ));
}

void main() => runApp(CycleConfigurator());
