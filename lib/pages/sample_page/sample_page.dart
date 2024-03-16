import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  static String get path => '/sample-page';
  static String get name => 'sample_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 16, 16),
      body: Center(
        child: Text(
          'Sample Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
