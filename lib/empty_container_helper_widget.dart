import 'package:flutter/material.dart';

///Simple widget to show as empty
///In case of Error or an Issue
///When the Image is unable to load | not found in worst case scenerios
class EmptyContainerHelperWidget extends StatelessWidget {
  const EmptyContainerHelperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 0, width: 0);
  }
}
