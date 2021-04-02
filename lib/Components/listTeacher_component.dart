import 'package:flutter/material.dart';
import 'package:site_historia/Widgets/teacherTile_widget.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
  int _currentPage = 0;
  final sizeRowsDefault = 5;
  int numRows = 5;
  @override
  Widget build(BuildContext context) {
    final List<String> teachers = [
      "Teacher Name 1",
      "Teacher Name 2",
      "Teacher Name 3",
      "Teacher Name 4",
      "Teacher Name 5",
      "Teacher Name 6",
      "Teacher Name 7",
      "Teacher Name 8",
      "Teacher Name 9",
      "Teacher Name 10",
      "Teacher Name 11",
    ];
    return Row(children: [
      Expanded(
        flex: 1,
        child: IconButton(
          onPressed: _currentPage == 0
              ? null
              : () {
                  setState(() {
                    numRows = sizeRowsDefault;
                    _currentPage -= numRows;
                  });
                },
          icon: Icon(Icons.arrow_left),
        ),
      ),
      Expanded(
        flex: 8,
        child: Column(
          children: List.generate(numRows,
              (i) => TeacherTile(teachers[_currentPage + i].toString())),
        ),
      ),
      Expanded(
        flex: 1,
        child: IconButton(
          onPressed: _currentPage == (teachers.length - _currentPage) ||
                  numRows < sizeRowsDefault
              ? null
              : () {
                  setState(() {
                    _currentPage += numRows;
                    if ((teachers.length - _currentPage) < sizeRowsDefault) {
                      numRows = (teachers.length - _currentPage);
                    }
                  });
                },
          icon: Icon(Icons.arrow_right),
        ),
      ),
    ]);
  }
}
