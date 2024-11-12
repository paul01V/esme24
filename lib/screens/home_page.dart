import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: LocationUseCase().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Text("No data");
            }
            return ListView(children: [
              LocationCard(location: data[0]),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Nope"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Yep"),
                    ),
                  ],
                ),
              ),
              Center(
                child: FilledButton(
                    onPressed: () {
                      GoRouter.of(context).go('/selectpage');
                    },
                    child: const Text("Create plan")),
              )
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
