import 'package:flutter/material.dart';

class TimeWaiting extends StatefulWidget {
  final String hourWaitingTime;
  final String minWaitingTime;
  final String hourPostWaitTime;
  final String minPostWaitTime;
  const TimeWaiting(
      {Key? key,
      required this.hourWaitingTime,
      required this.minWaitingTime,
      required this.hourPostWaitTime,
      required this.minPostWaitTime})
      : super(key: key);

  @override
  State<TimeWaiting> createState() => _TimeWaitingState();
}

class _TimeWaitingState extends State<TimeWaiting> {
  String hourWaitingTime = '0';
  String minWaitingTime = '00';
  String hourPostWaitTime = '0';
  String minPostWaitTime = '00';

  @override
  void initState() {
    super.initState();
    hourWaitingTime = widget.hourWaitingTime;
    minWaitingTime = widget.minWaitingTime;
    hourPostWaitTime = widget.hourPostWaitTime;
    minPostWaitTime = widget.minPostWaitTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Text(
                'Média de tempo de espera: ',
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
                  const Text('Horas'),
                  DropdownButton<String>(
                    value: hourWaitingTime,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (value) {
                      setState(() {
                        hourWaitingTime = value!;
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
                      '12'
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
                  const Text('Minutos'),
                  DropdownButton<String>(
                    value: minWaitingTime,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (value) {
                      setState(() {
                        minWaitingTime = value!;
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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Text(
                'Média de tempo pós espera: ',
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
                  const Text('Horas'),
                  DropdownButton<String>(
                    value: hourPostWaitTime,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (value) {
                      setState(() {
                        hourPostWaitTime = value!;
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
                      '12'
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
                  const Text('Minutos'),
                  DropdownButton<String>(
                    value: minPostWaitTime,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (value) {
                      setState(() {
                        minPostWaitTime = value!;
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
        )
      ],
    );
  }
}
