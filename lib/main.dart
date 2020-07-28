import 'package:defiled_nsuns/cycle/dayprogram.dart';
import 'package:defiled_nsuns/cycle/exercise.dart';
import 'package:flutter/material.dart';

const List<DayProgram> programs = const <DayProgram>[
  DayProgram(day: 'Monday', exercises: const <Exercise>[
    Exercise(
        name: 'Bench Press',
        targetMuscle: TargetMuscle.chest,
        sets: const <ExerciseSet>[
          ExerciseSet(weight: 60, repetitions: 8, amrap: false),
          ExerciseSet(weight: 65, repetitions: 6, amrap: false),
          ExerciseSet(weight: 70, repetitions: 1, amrap: true),
          ExerciseSet(weight: 65, repetitions: 6, amrap: false),
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
    _title = programs[0].day;
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
      _title = programs[newIndex].day;
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