import 'package:flutter/material.dart';
import 'package:task_management_system/task_management_system.dart';

class TestScreen extends StatelessWidget {
  static const routeName = '/test';
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              testAllTask();
            },
            child: const Text('Test ALL'),
          ),
          ElevatedButton(
            onPressed: () {
              testTaskCrud();
            },
            child: const Text('Test CRUD'),
          ),
        ],
      ),
    );
  }
}
