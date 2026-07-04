import 'package:exercise_projects/core/widgets/my_custom_icons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: width > 600 ? 32 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   height: height*0.25,
              //   decoration: BoxDecoration(
              //     color: Colors.blue.withOpacity(0.6),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //
              //   child: LayoutBuilder(
              //     builder: (context, constraints) {
              //       return Center(
              //         child: Container(
              //           height: constraints.maxHeight * 0.25,
              //           width: width * 0.05,
              //           decoration: BoxDecoration(
              //             color: Colors.red,
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //       maxCrossAxisExtent: 200,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10
              //     ),
              //     itemCount: 12,
              //     itemBuilder: (context, index) => Container(
              //       decoration: BoxDecoration(color: Colors.green.withOpacity(0.4),
              //       borderRadius: BorderRadius.circular(25)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MyCustomIcons.group87),
        onPressed: () {},
      ),
    );
  }
}
