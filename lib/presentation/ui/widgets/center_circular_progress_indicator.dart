import 'package:flutter/material.dart';

class CenterCircularProgressIndicator extends StatefulWidget {
  const CenterCircularProgressIndicator({super.key});

  @override
  State<CenterCircularProgressIndicator> createState() => _CenterCircularProgressIndicatorState();
}

class _CenterCircularProgressIndicatorState extends State<CenterCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
