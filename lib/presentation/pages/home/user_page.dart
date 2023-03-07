import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:ddd_lesson/presentation/components/zoom_tab_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late ConfettiController _controllerCenter;
  final ScrollController scrollController = ScrollController();
  bool isGridView = false;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    scrollController.addListener(() {
      print("object1 offset : ${scrollController.offset}");
      print("object1 min : ${scrollController.position.minScrollExtent}");
      print("object1 min : ${scrollController.position.pixels}");
      print("object2 : ${scrollController.offset}");
      print("object3 : ${scrollController.initialScrollOffset}");
      final direction = scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        print("reverse");
      } else if (direction == ScrollDirection.forward) {
        print("forward");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              scrollController.animateTo(1909,
                  duration: Duration(milliseconds: 750),
                  curve: Curves.bounceIn);
              setState(() {});
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: !isGridView
          ? AnimationLimiter(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: 32,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: SardorAnimation(
                            child: Container(
                              height: 64,
                              margin: const EdgeInsets.all(8),
                              color: Colors.lightBlueAccent,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : SizedBox(
              child: AnimationLimiter(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: 32,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 3,
                        child: FadeInAnimation(
                          child: Container(
                            height: 64,
                            margin: const EdgeInsets.all(8),
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      );
                    }),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality.explosive,
        // don't specify a direction, blast randomly
        shouldLoop: true,
        // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ],
        // manually specify the colors to be used
        createParticlePath: drawStar,
        child: FloatingActionButton(
          onPressed: () {
            _controllerCenter.play();
            Future.delayed(const Duration(seconds: 1), () {
              _controllerCenter.stop();
            });

            // showTopSnackBar(
            //   context,
            //   CustomSnackBar.error(
            //     message:
            //     "Something went wrong. Please check your credentials and try again",
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
