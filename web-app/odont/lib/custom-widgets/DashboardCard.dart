import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  DashboardCard(
      {required this.title, required this.onTapped, required this.aspectRatio});
  final String title;
  final Function onTapped;
  final double aspectRatio;
  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          widget.onTapped();
        },
        child: Container(
          constraints: BoxConstraints(maxWidth: 500, maxHeight: 250),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
