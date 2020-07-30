import 'package:flutter/material.dart';

class ExerciseSet {
  ExerciseSet({this.weight, this.repetitions});

  final int weight;
  final int repetitions;
  int completedRepetitions = -1;

  void markComplete(int repetitions) {
    completedRepetitions = repetitions;
  }

  void reset() {
    completedRepetitions = -1;
  }

  bool isComplete() => completedRepetitions >= 0;

  bool isAmrap() => repetitions == 1;

  String repetitionsToString() {
    var reps = repetitions.toString();
    if (isAmrap()) {
      reps = reps + '+';
    }
    return reps;
  }
}

class ExerciseSetWidget extends StatefulWidget {
  const ExerciseSetWidget({this.set});

  final ExerciseSet set;

  @override
  State<StatefulWidget> createState() => _ExerciseSetWidgetState(set: set);
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  _ExerciseSetWidgetState({this.set});

  final ExerciseSet set;

  final TextStyle textStyle = const TextStyle(fontSize: 20);
  final EdgeInsets insets = const EdgeInsets.all(4);

  TextEditingController _textEditingController;
  FocusNode _focusNode;
  String _text;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _text = set.repetitionsToString();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: insets,
      child: InkWell(
          onTap: () {
            setState(() {
              if (set.isComplete()) {
                set.reset();
                _textEditingController.text = '';
                _text = set.repetitionsToString();
              } else {
                set.markComplete(set.repetitions);
                _textEditingController.text = set.repetitions.toString();
                _text = '/' + set.repetitionsToString();
              }
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: set.isComplete()
                      ? (set.completedRepetitions >= set.repetitions
                          ? Color.fromRGBO(0, 255, 0, 0.1)
                          : Color.fromRGBO(255, 0, 0, 0.1))
                      : Color.fromRGBO(0, 0, 0, 0.1),
                  border: Border.all()),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: 30,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _textEditingController,
                            focusNode: _focusNode,
                            onChanged: (text) {
                              setState(() {
                                final int parsed = int.tryParse(text);
                                if (parsed != null) {
                                  set.markComplete(parsed);
                                  _text = '/' + set.repetitionsToString();
                                } else {
                                  set.reset();
                                  _text = set.repetitionsToString();
                                }
                              });
                            },
                            style: textStyle,
                            textAlign: TextAlign.right)),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _focusNode.requestFocus();
                          });
                        },
                        child: Text(_text,
                            style: textStyle, textAlign: TextAlign.left)),
                    Text(' reps at ${set.weight} kg',
                        style: textStyle, textAlign: TextAlign.center)
                  ]))));
}
