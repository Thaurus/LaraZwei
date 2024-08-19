import 'package:flutter/material.dart';

const double _kMyLinearProgressIndicatorHeight = 6.0;

class ChapterProgressBar extends LinearProgressIndicator
    implements PreferredSizeWidget {
  ChapterProgressBar({
    Key? key,
    double? value,
    Color backgroundColor = Colors.white,
    Animation<Color> valueColor = const AlwaysStoppedAnimation<Color>(Colors.green),
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {
    preferredSize = const Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
  late final Size preferredSize;
}