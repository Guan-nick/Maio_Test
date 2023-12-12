import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ApiItem extends StatefulWidget {
  const ApiItem({super.key, required this.photosData});
  final Map<String, dynamic> photosData;

  @override
  State<ApiItem> createState() => _ApiItemState();
}

class _ApiItemState extends State<ApiItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.photosData['thumbnailUrl'],
          cacheKey: widget.photosData['thumbnailUrl'] +
              DateTime.now().hour.toString(),
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.photosData['id'].toString(),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.photosData['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
