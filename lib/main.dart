import 'package:defiled_nsuns/cycle/dayprogram.dart';
import 'package:flutter/material.dart';

class CycleConfigurator extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: DayProgramWidget(dayProgram: programs[0]));
}

void main() => runApp(CycleConfigurator());
