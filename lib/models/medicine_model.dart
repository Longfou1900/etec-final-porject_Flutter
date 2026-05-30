class Medicine{
  String id;
  String name;
  String description;
  int stock;
  int qty;
  double price;
  String image;  
  String country;
  String type;
  DateTime dateIn;
  DateTime dateOut;

  Medicine({
    required this.id, required this.name,
    required this.qty, required this.price,
    required this.stock, required this.description,
    required this.image, required this.country,
    required this.dateIn, required this.dateOut,
    required this.type
  });

  factory Medicine.fromJson(Map<String, dynamic> json){
    return Medicine(
      id: json['id'].toString(),
      name: json['name'] ?? 'null', 
      qty: json['qty'] ?? 0, 
      price: (json['price'] as num).toDouble(), 
      stock: json['stock'] ?? 0, 
      description: json['description'] ?? 'null', 
      image: json['image'] ?? 'https://placeholder.com/150', 
      country: json['country'] ?? 'null', 
      dateIn: DateTime.parse(json['date_in']), 
      dateOut: DateTime.parse(json['date_out']), 
      type: json['type'] ?? 'null'
    );
  }

  Map<String, dynamic> toJson(){
  return{
    'id': id,
    'name': name,
    'qty': qty,
    'price':price,
    'stock': stock,
    'description': description,
    'image': image,
    'country': country,
    'date_in': dateIn,
    'date_out': dateOut,
    'type':type
  };
}
}

