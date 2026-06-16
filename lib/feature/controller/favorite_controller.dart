import 'package:get/get.dart';

class FavoriteController extends GetxController {
  // Store the actual items so we can display them on the Favorites Screen
  var favoriteItems = <String, dynamic>{}.obs; 

  void toggleFavorite(String id, dynamic item) {
    if (favoriteItems.containsKey(id)) {
      favoriteItems.remove(id);
    } else {
      favoriteItems[id] = item;
    }
  }

  bool isFavorite(String id) => favoriteItems.containsKey(id);
  
  // Getter for the number of favorites
  int get favoriteCount => favoriteItems.length;

  
}