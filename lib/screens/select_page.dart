import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  final String title;

  const SelectPage({super.key, required this.title});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }
}