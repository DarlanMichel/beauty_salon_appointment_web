import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_schedules_entity.dart';
import 'package:flutter/material.dart';

class TabViewSchedule extends StatefulWidget {
  final String week;
  final List<CollaboratorSchedulesEntity> listSchedule;
  const TabViewSchedule(
      {Key? key, required this.week, required this.listSchedule})
      : super(key: key);

  @override
  _TabViewScheduleState createState() => _TabViewScheduleState();
}

class _TabViewScheduleState extends State<TabViewSchedule> {
  String initialHour = '0';
  String initialMinute = '00';
  String endHour = '0';
  String endMinute = '00';
  String initialEveningHour = '0';
  String initialEveningMinute = '00';
  String endEveningHour = '0';
  String endEveningMinute = '00';
  bool exist = false;

  @override
  void initState() {
    super.initState();
    for (var item in widget.listSchedule) {
      if (item.week == widget.week) {
        exist = true;
        int fullTimeStartMorning = (item.startMorning * 100).toInt();
        int fullTimeEndMorning = (item.endMorning * 100).toInt();
        int fullTimeStartEvening = (item.startEvening! * 100).toInt();
        int fullTimeEndEvening = (item.endEvening! * 100).toInt();
        if (fullTimeStartMorning >= 100) {
          initialHour = fullTimeStartMorning
              .toString()
              .substring(0, fullTimeStartMorning.toString().length - 2);
          initialMinute = fullTimeStartMorning
              .toString()
              .substring(fullTimeStartMorning.toString().length - 2);
        } else {
          initialHour = '0';
          initialMinute = fullTimeStartMorning == 0
              ? '00'
              : fullTimeStartMorning.toString();
        }

        if (fullTimeEndMorning >= 100) {
          endHour = fullTimeEndMorning
              .toString()
              .substring(0, fullTimeEndMorning.toString().length - 2);
          endMinute = fullTimeEndMorning
              .toString()
              .substring(fullTimeEndMorning.toString().length - 2);
        } else {
          endHour = '0';
          endMinute =
              fullTimeEndMorning == 0 ? '00' : fullTimeEndMorning.toString();
        }

        if (fullTimeStartEvening >= 100) {
          initialEveningHour = fullTimeStartEvening
              .toString()
              .substring(0, fullTimeStartEvening.toString().length - 2);
          initialEveningMinute = fullTimeStartEvening
              .toString()
              .substring(fullTimeStartEvening.toString().length - 2);
        } else {
          initialEveningHour = '0';
          initialEveningMinute = fullTimeStartEvening == 0
              ? '00'
              : fullTimeStartEvening.toString();
        }

        if (fullTimeEndEvening >= 100) {
          endEveningHour = fullTimeEndEvening
              .toString()
              .substring(0, fullTimeEndEvening.toString().length - 2);
          endEveningMinute = fullTimeEndEvening
              .toString()
              .substring(fullTimeEndEvening.toString().length - 2);
        } else {
          endEveningHour = '0';
          endEveningMinute =
              fullTimeEndEvening == 0 ? '00' : fullTimeEndEvening.toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Inicio: ',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const Text('Hora'),
                DropdownButton<String>(
                  value: initialHour,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      initialHour = value!;
                      if (exist) {
                        widget
                                .listSchedule[widget.listSchedule.indexWhere(
                                    (element) => element.week == widget.week)]
                                .startMorning =
                            double.parse(initialHour + '.' + initialMinute);
                      } else {
                        _addSchedule();
                      }
                    });
                  },
                  items: <String>[
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                    '13',
                    '14',
                    '15',
                    '16',
                    '17',
                    '18',
                    '19',
                    '20',
                    '21',
                    '22',
                    '23'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                const Text('Minuto'),
                DropdownButton<String>(
                  value: initialMinute,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      initialMinute = value!;
                      if(exist){
                        widget
                            .listSchedule[widget.listSchedule.indexWhere(
                                (element) => element.week == widget.week)]
                            .startMorning =
                            double.parse(initialHour + '.' + initialMinute);
                      } else {
                        _addSchedule();
                      }
                    });
                  },
                  items: <String>['00', '10', '20', '30', '40', '50']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 70,
            ),
            const Text(
              'Fim: ',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const Text('Hora'),
                DropdownButton<String>(
                  value: endHour,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      endHour = value!;
                      widget
                          .listSchedule[widget.listSchedule.indexWhere(
                              (element) => element.week == widget.week)]
                          .endMorning = double.parse(endHour + '.' + endMinute);
                    });
                  },
                  items: <String>[
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                    '13',
                    '14',
                    '15',
                    '16',
                    '17',
                    '18',
                    '19',
                    '20',
                    '21',
                    '22',
                    '23'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                const Text('Minuto'),
                DropdownButton<String>(
                  value: endMinute,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      endMinute = value!;
                      widget
                          .listSchedule[widget.listSchedule.indexWhere(
                              (element) => element.week == widget.week)]
                          .endMorning = double.parse(endHour + '.' + endMinute);
                    });
                  },
                  items: <String>['00', '10', '20', '30', '40', '50']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Inicio: ',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const Text('Hora'),
                DropdownButton<String>(
                  value: initialEveningHour,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      initialEveningHour = value!;
                      widget
                              .listSchedule[widget.listSchedule.indexWhere(
                                  (element) => element.week == widget.week)]
                              .startEvening =
                          double.parse(
                              initialEveningHour + '.' + initialEveningMinute);
                    });
                  },
                  items: <String>[
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                    '13',
                    '14',
                    '15',
                    '16',
                    '17',
                    '18',
                    '19',
                    '20',
                    '21',
                    '22',
                    '23'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                const Text('Minuto'),
                DropdownButton<String>(
                  value: initialEveningMinute,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      initialEveningMinute = value!;
                      widget
                              .listSchedule[widget.listSchedule.indexWhere(
                                  (element) => element.week == widget.week)]
                              .startEvening =
                          double.parse(
                              initialEveningHour + '.' + initialEveningMinute);
                    });
                  },
                  items: <String>['00', '10', '20', '30', '40', '50']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 70,
            ),
            const Text(
              'Fim: ',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const Text('Hora'),
                DropdownButton<String>(
                  value: endEveningHour,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      endEveningHour = value!;
                      widget
                              .listSchedule[widget.listSchedule.indexWhere(
                                  (element) => element.week == widget.week)]
                              .endEvening =
                          double.parse(endEveningHour + '.' + endEveningMinute);
                    });
                  },
                  items: <String>[
                    '0',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                    '13',
                    '14',
                    '15',
                    '16',
                    '17',
                    '18',
                    '19',
                    '20',
                    '21',
                    '22',
                    '23'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                const Text('Minuto'),
                DropdownButton<String>(
                  value: endEveningMinute,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onChanged: (value) {
                    setState(() {
                      endEveningMinute = value!;
                      widget
                              .listSchedule[widget.listSchedule.indexWhere(
                                  (element) => element.week == widget.week)]
                              .endEvening =
                          double.parse(endEveningHour + '.' + endEveningMinute);
                    });
                  },
                  items: <String>['00', '10', '20', '30', '40', '50']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  void _addSchedule(){
    final value = CollaboratorSchedulesEntity(
      week: widget.week,
      startMorning:
      double.parse(initialHour + '.' + initialMinute),
      endMorning: double.parse(endHour + '.' + endMinute),
      startEvening: double.parse(
          initialEveningHour + '.' + initialEveningMinute),
      endEvening: double.parse(
          endEveningHour + '.' + endEveningMinute),
    );
    widget.listSchedule.add(value);
    exist = true;
  }
}
