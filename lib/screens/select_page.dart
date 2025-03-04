import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class SelectPage extends StatefulWidget {
  final String title;

  const SelectPage({super.key, required this.title});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  Map<Location, bool> plans = {};

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    try {
      Map<Location, bool> fetchedPlans = await LocationManager().filters;
      setState(() {
        plans = fetchedPlans;
      });
    } catch (e) {
      print("Erreur lors du chargement des plans : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1E2C),
              Color(0xFF2A2A3A),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    Location location = plans.keys.elementAt(index);
                    bool isCheck = plans[location] ?? false;

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            location.photoUrl ?? "",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                        title: Text(
                          location.nom,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        trailing: Switch(
                          value: isCheck,
                          onChanged: (val) {
                            setState(() {
                              plans[location] = val;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FilledButton(  // Changé de ElevatedButton à FilledButton
                onPressed: () {
                  List<Location> selectedLocations = plans.keys.where((location) => plans[location] == true).toList();
                  GoRouter.of(context).go('/mappage', extra: selectedLocations);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,  // Même couleur que dans HomePage
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),  // Mêmes dimensions
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),  // Même bordure arrondie
                  elevation: 6,  // Même élévation
                ),
                child: const Text(
                  "Afficher sur la carte",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),  // Même style de texte
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

