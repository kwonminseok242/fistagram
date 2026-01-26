import 'package:flutter/material.dart';
import '../../../data/models/story_model.dart';

class StoryProgressBar extends StatelessWidget {
  final List<StoryItem> items;
  final int currentIndex;
  final AnimationController progressController;

  const StoryProgressBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.progressController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(items.length, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(1),
            ),
            child: Stack(
              children: [
                if (index < currentIndex)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                if (index == currentIndex)
                  AnimatedBuilder(
                    animation: progressController,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressController.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
