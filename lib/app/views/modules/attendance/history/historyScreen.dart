import 'package:flutter/material.dart';
import 'package:vnatpro2/app/views/modules/attendance/history/widgets/historyListWidget.dart';

class HistoryScreen extends StatelessWidget {
  static const url = '/history';
  List<Widget> historyList = [
    Text('1'),
    Text('1'),
    Text('1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance History'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: historyList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryListWidget();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
