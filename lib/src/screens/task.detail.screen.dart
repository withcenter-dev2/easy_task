import 'package:flutter/material.dart';
import 'package:task_management_system/task_management_system.dart';

class TaskDetailScreen extends StatefulWidget {
  static const String routeName = '/TaskDetail';
  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task task;

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskDetail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Title: ${task.title}"),
            Text("Content: ${task.content}"),
            const SizedBox(height: 24),
            const Text("Assignees:"),
            const SizedBox(height: 12),
            Expanded(
              child: AssignListView(
                queryOptions: AssignQueryOptions(
                  task: task,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final assignUser = await showGeneralDialog<User?>(
                  context: context,
                  pageBuilder: (context, a1, a2) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text(
                            "TODO: list users by the search and Assign to"),
                      ),
                      body: const Text(''),
                    );
                  },
                );
                if (assignUser == null) return;
                await Assign.create(
                  uid: assignUser.uid,
                  taskId: task.id,
                );
                if (!mounted) return;
                setState(() {
                  task.assignTo.add(assignUser.uid);
                });
              },
              child: const Text('ASSIGN'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                final updatedTask = await showGeneralDialog<Task?>(
                  context: context,
                  pageBuilder: (context, a1, a2) =>
                      TaskUpdateScreen(task: task),
                );
                if (updatedTask == null) return;
                if (!mounted) return;
                setState(() {
                  task = updatedTask;
                });
              },
              child: const Text('UPDATE'),
            ),
            ElevatedButton(
              onPressed: () async {
                await task.delete();
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              child: const Text('DELETE'),
            ),
            const SafeArea(
              child: SizedBox(
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
