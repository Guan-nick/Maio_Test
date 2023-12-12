import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/data/photos.dart';
import '../database/database_helper.dart';
import '../widgets/api_item.dart';
import '../services/json_api_to_db.dart';
import '../main.dart';

class RequestApiGridScreen extends ConsumerStatefulWidget {
  const RequestApiGridScreen({super.key});

  @override
  ConsumerState<RequestApiGridScreen> createState() =>
      _RequestApiGridScreenState();
}

class _RequestApiGridScreenState extends ConsumerState<RequestApiGridScreen> {
  List<Photos> memoryData = [];
  List<Map<String, dynamic>> photosFromDatabase = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDatabase();
    _loadApi();
  }

  void loadDatabase() async {
    photosFromDatabase = await SQLHelper.getItems();
    ref.read(isLoadingProvider.notifier).update((state) => false);
  }

  void _loadApi() async {
    final memoryData = await JsonApiToDB().jsonToMemory();
    ref.read(photosMemoryProvider.notifier).equalJsonData(memoryData);
    ref.read(isLoadingProvider.notifier).update((state) => false);
  }

  @override
  Widget build(BuildContext context) {
    memoryData = ref.watch(photosMemoryProvider);
    isLoading = ref.watch(isLoadingProvider);

    Widget content = GridView.builder(
      itemCount: photosFromDatabase.length, //itemCount: memoryData.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        return ApiItem(
            photosData: photosFromDatabase[
                index]); //ApiItem(photosData: memoryData[index]);
      },
    );

    if (isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    // if (memoryData.isEmpty) {
    if (photosFromDatabase.isEmpty) {
      content = const Center(child: Text('Nothing here'));
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: TextButton.icon(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary),
          label: Text(
            'Back',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: content,
      ),
    );
  }
}
