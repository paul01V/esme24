import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScanPage extends StatefulWidget {
  @override
  _NFCScanPageState createState() => _NFCScanPageState();
}

class _NFCScanPageState extends State<NFCScanPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void _startNfcScan() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner NFC'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade400,
            ],
          ),
        ),
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (snapshot.data == false) {
              return Center(
                child: Text(
                  'NFC non disponible sur cet appareil.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: _startNfcScan,
                      icon: Icon(Icons.nfc, color: Colors.white, size: 28),
                      label: Text(
                        'Scanner une étiquette NFC',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: result,
                    builder: (context, value, _) {
                      return value == null
                          ? Container()
                          : Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Résultat : $value',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

