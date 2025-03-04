import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListFinished = false;

  void _resetList() {
    setState(() {
      LocationManager().reset();
      isListFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Container(
        decoration: _buildBackgroundGradient(),
        child: FutureBuilder(
          future: LocationUseCase().getLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return _buildEmptyState();
            }

            LocationManager().locations = data;
            isListFinished = LocationManager().currentIndex >= data.length - 1;

            return _buildMainContent(data);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  BoxDecoration _buildBackgroundGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1E1E2C),
          Color(0xFF2A2A3A),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "Aucun lieu disponible",
        style: TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }

  Widget _buildMainContent(List<dynamic> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isListFinished
                ? _buildFinishedState()
                : LocationCard(location: data[LocationManager().currentIndex]),
          ),
        ),
        _buildSwipeButtons(),
        _buildStats(),
        _buildActionButtons(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFinishedState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Vous avez parcouru tous les monuments !",
            style: TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _resetList,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              "Recommencer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _customButton(
          onTap: isListFinished ? null : () => setState(() => LocationManager().Idontwant()),
          icon: Icons.thumb_down,
          color: isListFinished ? Colors.grey : Colors.redAccent,
          label: "Nope",
        ),
        const SizedBox(width: 20),
        _customButton(
          onTap: isListFinished ? null : () => setState(() => LocationManager().Iwant()),
          icon: Icons.thumb_up,
          color: isListFinished ? Colors.grey : Colors.greenAccent,
          label: "Yep",
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _statText("👎 ${LocationManager().unwantedLocations.length}", Colors.redAccent),
          const SizedBox(width: 20),
          _statText("👍 ${LocationManager().filters.length}", Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () => GoRouter.of(context).go('/selectpage'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 6,
              ),
              child: const Text(
                "Créer un plan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: () => GoRouter.of(context).go('/nfcscan'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 6,
              ),
              child: const Text(
                "J'y suis allé",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton({required VoidCallback? onTap, required IconData icon, required Color color, required String label}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 26),
      label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }

  Widget _statText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
    );
  }
}

