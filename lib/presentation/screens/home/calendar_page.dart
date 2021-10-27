import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> _tabSelectedDay = [];
  TimeOfDay StartTime = TimeOfDay.now();
  TimeOfDay EndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return containDate(day);
            },
            onDaySelected: (selectedDay, focusedDay) {

              //print(_tabSelectedDay.se);
              setState(() {
                if(containDate(selectedDay)){
                  _tabSelectedDay.remove(selectedDay);
                }else{
                  _tabSelectedDay.add(selectedDay);
                }

                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Divider(
            thickness: 3,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text("Choose Time"),
          ),
          Text("${StartTime.hour}:${StartTime.minute}"),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              _selectTimeEnd(context);
            },
            child: Text("Choose Time"),
          ),
          Text("${EndTime.hour}:${EndTime.minute}"),

          SizedBox(height: 80,),
          ElevatedButton(
            onPressed: () {
              SaveSlots();
            },
            child: Text("Sauvegarder"),
          ),
        ],
      )
    );
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: StartTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != StartTime)
    {
      setState(() {
        StartTime = timeOfDay;
      });
    }
  }

  _selectTimeEnd(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: EndTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != EndTime)
    {
      setState(() {
        EndTime = timeOfDay;
      });
    }
  }

  void SaveSlots(){

  }

  bool containDate(day){
    bool result = false;
    _tabSelectedDay.forEach((element) {
      if(isSameDay(element, day)){
        result= true;
      }
    });
    return result;
  }
}
