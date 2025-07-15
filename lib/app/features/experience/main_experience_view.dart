import 'package:flutter/material.dart';

import '../../../assets/style/custom_style.dart';

class MainExperienceView extends StatelessWidget {
  const MainExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomStyle.maxWidth(context),
      height: CustomStyle.maxHeight(context),
      color: Colors.green.shade100,
      alignment: Alignment.center,
      child: const Text(
        "This Experience",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
