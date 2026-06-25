import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


Future<void> showSimpleFlushBar(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color color,
    ) {
  return Flushbar(
    borderRadius: BorderRadius.circular(20),
    backgroundColor: color,
    padding: EdgeInsets.all( MediaQuery.of(context).size.height*0.02),
    margin:EdgeInsets.all( MediaQuery.of(context).size.height*0.02) ,
    flushbarPosition: FlushbarPosition.BOTTOM,
    duration: const Duration(seconds: 2), // You can tweak the timing
    icon: Icon(
      icon,
      color: Colors.white,
      size: 45,
    ),
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          message,
          style: TextStyle(fontSize: 15,color: Colors.white),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  ).show(context);
}
