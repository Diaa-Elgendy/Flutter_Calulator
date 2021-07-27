import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class HistoryScreen extends StatefulWidget {

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: isLight ? greenLight : greenDark,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(15),
          color: isLight ? backgroundLight : backgroundDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data[index]['equation']}",
                style: TextStyle(
                  fontSize: 30,
                  color: isLight ? textColorLight : textColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data[index]['result']}",
                style: TextStyle(
                  fontSize: 26,
                  color: isLight ? textColorLight : textColorDark,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount: data.length,
      ),
    );
  }
}
