import 'package:flutter/material.dart';

BoxDecoration borderDecoration(BuildContext context) {
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
    ),
  );
}
