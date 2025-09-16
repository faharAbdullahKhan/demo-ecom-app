class ProductsListResponse {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductsListResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  ProductsListResponse toDomain() {
    return ProductsListResponse(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: Rating(rate: rating.rate, count: rating.count), // adapt to your domain types
    );
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });
}

