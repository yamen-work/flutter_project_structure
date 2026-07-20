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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: width > 600 ? 32 : 20),
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(MyCustomIcons.bag,color: Colors.red,),
      ),
    );
  }
}
