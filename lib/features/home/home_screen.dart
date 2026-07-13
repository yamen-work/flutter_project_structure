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
    BlocProvider.of<HomeScreenCubit>(context).getCoffeeBeansFromBackend();
    BlocProvider.of<HomeScreenCubit>(context).getDrinksFromBackend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: width > 600 ? 32 : 20),

        child: SingleChildScrollView(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Text("Coffee Beans", style: mediumWhiteTextStyle),

                BlocConsumer<HomeScreenCubit, HomeScreenState>(


                  listener:(context, state) async {


                    if(state.getCoffeeBeansState == StateValue.error)
                      {

                        await showSimpleFlushBar(context, state.getCoffeeBeansErrorMessage, "", Icons.info_outline_rounded, Colors.red);

                      }


                  } ,


                  builder: (context, state) {
                    if (state.getCoffeeBeansState == StateValue.error) {
                      return Center(
                        child: Text(
                          state.getCoffeeBeansErrorMessage,
                          style: bigBlackTextStyle.copyWith(color: Colors.red),
                        ),
                      );
                    }

                    if (state.getCoffeeBeansState == StateValue.loaded) {
                      return SizedBox(
                        height: 0.25.sh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.coffeeBeans.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: boxShadow,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: [
                                        Text(
                                          state.coffeeBeans[index].name,
                                          style: mediumWhiteTextStyle,
                                        ),
                                        Text(
                                          state.coffeeBeans[index].price
                                              .toString(),
                                          style: mediumTextStyle.copyWith(
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return CupertinoActivityIndicator(radius: 40);
                    }
                  },
                ),

                Text("Drinks", style: mediumWhiteTextStyle),

                BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    if (state.getDrinksState == StateValue.error) {
                      return Text(
                        state.getDrinksErrorMessage,
                        style: smallTextStyle.copyWith(color: Colors.red),
                      );
                    }

                    if (state.getDrinksState == StateValue.loaded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.drinks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade800,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: boxShadow,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: [
                                        Text(
                                          state.drinks[index].name,
                                          style: mediumWhiteTextStyle,
                                        ),
                                        Text(
                                          state.drinks[index].price.toString(),
                                          style: mediumTextStyle.copyWith(
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return CupertinoActivityIndicator(radius: 40);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(MyCustomIcons.bag,color: Colors.red,),
      ),
    );
  }
}
