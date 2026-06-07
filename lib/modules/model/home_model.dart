// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
  Data? data;

  HomeModel({this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      HomeModel(data: Data.fromJson(json["data"] ?? json));

  factory HomeModel.fromApi(dynamic json) {
    if (json is Map<String, dynamic>) {
      return HomeModel.fromJson(json);
    }

    if (json is List) {
      final allItems = json
          .whereType<Map>()
          .map((item) => Late.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      final items = allItems.where((item) => item.hasValidImage).toList();
      final displayItems = items.isNotEmpty ? items : allItems;
      final popular = items.where((item) => item.isPopular).toList();
      final lates = items.where((item) => item.isLatest).toList();

      if (popular.isNotEmpty || lates.isNotEmpty) {
        return HomeModel(
          data: Data(
            popular: popular.isNotEmpty ? popular : displayItems,
            lates: lates.isNotEmpty ? lates : displayItems,
          ),
        );
      }

      final middle = (displayItems.length / 2).ceil();
      return HomeModel(
        data: Data(
          popular: displayItems.take(middle).toList(),
          lates: displayItems.skip(middle).toList(),
        ),
      );
    }

    return HomeModel(data: Data(popular: [], lates: []));
  }
}

class Data {
  List<Late>? popular;
  List<Late>? lates;

  Data({this.popular, this.lates});

  factory Data.fromJson(Map<String, dynamic> json) {
    final popularJson = json["Popular"] ?? json["popular"] ?? [];
    final latestJson = json["Lates"] ??
        json["lates"] ??
        json["Latest"] ??
        json["latest"] ??
        [];

    return Data(
      popular: popularJson is List
          ? popularJson
                .whereType<Map>()
                .map((x) => Late.fromJson(Map<String, dynamic>.from(x)))
                .toList()
          : [],
      lates: latestJson is List
          ? latestJson
                .whereType<Map>()
                .map((x) => Late.fromJson(Map<String, dynamic>.from(x)))
                .toList()
          : [],
    );
  }
}

class Late {
  String? id;
  String? name;
  String? images;
  String? description;
  String? category;
  num? price;

  Late({
    this.id,
    this.name,
    this.images,
    this.description,
    this.category,
    this.price,
  });

  factory Late.fromJson(Map<String, dynamic> json) => Late(
        id: _readString(json, ["id"]),
        name: _readString(json, ["name", "title"]),
        images: _readString(json, [
          "images",
          "img",
          "image",
          "avatar",
          "thumbnail",
          "photo",
          "url",
        ]),
        description: _readString(json, ["description", "desc", "detail"]),
        category: _readString(json, ["category", "type", "collection"]),
        price: _readNum(json, ["price"]),
      );

  bool get isPopular => _matchesCategory(["popular", "trend"]);

  bool get isLatest => _matchesCategory(["late", "latest", "new"]);

  bool get hasValidImage {
    final image = images;
    return image != null &&
        (image.startsWith('http://') || image.startsWith('https://'));
  }

  String get displayPrice {
    final value = price;
    if (value == null) return r'$0';
    if (value % 1 == 0) return '\$${value.toInt()}';
    return '\$${value.toStringAsFixed(2)}';
  }

  bool _matchesCategory(List<String> values) {
    final normalizedCategory = category?.toLowerCase() ?? "";
    return values.any(normalizedCategory.contains);
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }

  static num? _readNum(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is num) return value;
      if (value is String) return num.tryParse(value);
    }
    return null;
  }
}
