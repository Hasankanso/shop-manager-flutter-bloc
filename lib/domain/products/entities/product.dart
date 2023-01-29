class Product {
  String name;
  String description;
  String price;
  String image;
  String category;
  String id;
  String cost;
  String quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.id,
    required this.cost,
    required this.quantity,
  });

  toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "category": category,
      "id": id,
      "cost": cost,
      "quantity": quantity,
    };
  }
}
