import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart' as charts;
import 'package:spe_66_days/classes/HabitManager.dart';
import 'dart:ui' as ui show Paint;
import 'package:flutter/material.dart' as material show Colors;
import 'dart:math';
import 'progress/progress_chart.dart';
import 'progress/progress_chart_alt.dart';

class ProgressWidget extends StatefulWidget implements BottomNavigationBarItem {
  final Icon icon;
  final Text title;
  final Icon activeIcon;
  final Color backgroundColor;

  ProgressWidget(this.icon, this.title, {this.activeIcon, this.backgroundColor});

  @override
  State<StatefulWidget> createState(){return _ProgressState();}
}


class _ProgressState extends State<ProgressWidget>{

  _ProgressState();

  int _habitsChecked(){
    DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int checked = 0;
    HabitManager.instance.getHabits().forEach((_, val) {
      if (val.markedOff.contains(_currentDate)){
        checked += 1;
      }
    });
    return checked;
  }

  Widget build(context){
    return Container( padding: EdgeInsets.all(5.0), child: Column(
        children: <Widget>[
          /*Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Expanded(child: ProgressChartWidget())]
            )
          ),*/
          Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [Expanded(child: AltProgressChart.allHabitsCombined())]
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Habits tracked today: ${_habitsChecked()}/"
                  "${HabitManager.instance.getHabits().length}",
                  style: Theme.of(context).textTheme.title)
            ],
          )
        ]
    ));
  }
}
