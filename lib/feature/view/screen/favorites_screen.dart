import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/controller/favorite_controller.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoriteController favController = Get.find<FavoriteController>();

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text("My Favorites",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (favController.favoriteItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_outline,
                    size: 64, color: scheme.outlineVariant),
                const SizedBox(height: 16),
                Text("No favorites yet",
                    style: TextStyle(color: scheme.onSurfaceVariant)),
              ],
            ),
          );
        }

        final items = favController.favoriteItems.values.toList();

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: scheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.images ?? '',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name ?? 'Unknown',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: scheme.onSurface)),
                          const SizedBox(height: 4),
                          Text(item.displayPrice ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.primary)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => favController.toggleFavorite(
                          item.id.toString(), item),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
