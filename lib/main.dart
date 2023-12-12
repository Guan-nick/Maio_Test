import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maio_test/screen/home.dart';

import 'database/data/photos.dart';
import 'provider/riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RunMyApp(),
    ),
  );
}

class RunMyApp extends StatelessWidget {
  const RunMyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          primary: const Color.fromARGB(255, 0, 127, 231),
          secondary: const Color.fromARGB(255, 29, 68, 138),
          tertiary: const Color.fromARGB(255, 1, 6, 45),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

final photosMemoryProvider =
    StateNotifierProvider<PhotosNotifier, List<Photos>>((ref) {
  return PhotosNotifier(dummyData);
});

final isLoadingProvider = StateProvider<bool>((ref) => true);
