import 'package:exercise_projects/core/models/enums/state_value.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:exercise_projects/core/widgets/my_custom_icons.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_cubit.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routing/routing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }


  Stream<int> stopwatchStream() async* {
    int seconds = 0;
    while (true) {
      yield seconds;
      await Future.delayed(const Duration(seconds: 1),);
      seconds++;
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: width > 600 ? 32 : 20),
        child:  StreamBuilder<int>(
          stream: stopwatchStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final time = Duration(seconds: snapshot.data!);

            return Center(
              child: Text(
                "${time.inHours} : ${time.inMinutes} : ${time.inSeconds}",
                textDirection: TextDirection.ltr,
                style: const TextStyle(fontSize: 40),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(MyCustomIcons.bag,color: Colors.red,),
      ),
    );
  }
}
