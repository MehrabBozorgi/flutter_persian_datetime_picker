import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('persian_datetime_picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Jalali? picked = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1385, 8),
                  lastDate: Jalali(1450, 9),
                );
                print(picked);
                // final label = picked!.formatFullDate();
              },
              child: const Text(
                'تاریخ پیکر',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                print(picked);
                // final label = picked!.persianFormat(context);
              },
              child: const Text(
                'تایم پیکر',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showModalBottomSheet<Jalali>(
                  context: context,
                  builder: (context) {
                    Jalali? tempPickedDate;
                    return SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                child: const Text(
                                  'لغو',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: const Text(
                                  'تایید',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(tempPickedDate ?? Jalali.now());
                                },
                              ),
                            ],
                          ),
                          const Divider(
                            height: 0,
                            thickness: 1,
                          ),
                          Expanded(
                            child: PCupertinoDatePicker(
                              mode: PCupertinoDatePickerMode.dateAndTime,
                              onDateTimeChanged: (Jalali dateTime) {
                                tempPickedDate = dateTime;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'تاریخ و تایم پیکر',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showPersianDateRangePicker(
                  context: context,
                  initialEntryMode: PDatePickerEntryMode.input,
                  initialDateRange: JalaliRange(
                    start: Jalali(1400, 1, 2),
                    end: Jalali(1400, 1, 10),
                  ),
                  firstDate: Jalali(1385, 8),
                  lastDate: Jalali(1450, 9),
                );
                print(picked);
              },
              child: const Text(
                'از تاریخه، تا تاریخ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
