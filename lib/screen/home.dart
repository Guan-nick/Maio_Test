import 'package:flutter/material.dart';

import '../screen/request_api_grid.dart';
import '../database/database_helper.dart';
import '../services/json_api_to_db.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void refreshJournals() async {
      List<Map<String, dynamic>> data = await SQLHelper.getItems();

      if (data.isEmpty) {
        await JsonApiToDB().jsonToDB();
      }
    }

    refreshJournals();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'JSON Placeholder',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 150),
              TextButton(
                child: const Text(
                  'Request API',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestApiGridScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
