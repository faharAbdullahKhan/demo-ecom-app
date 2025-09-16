import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'products_list_reponse.g.dart';


@HiveType(typeId: 2) // choose a unique typeId
@JsonSerializable()
class ProductsListResponseDto {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String image;

  @HiveField(6)
  RatingDto rating;

  @JsonKey(ignore: true)
  @HiveField(7)
  int quantity;

  ProductsListResponseDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 1, // default 1 for cart
  });

  factory ProductsListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsListResponseDtoToJson(this);

  ProductsListResponseDto copyWith({int? quantity}) {
    return ProductsListResponseDto(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

@HiveType(typeId: 3) // unique id for rating model
@JsonSerializable()
class RatingDto {
  @HiveField(0)
  double rate;

  @HiveField(1)
  int count;

  RatingDto({
    required this.rate,
    required this.count,
  });

  factory RatingDto.fromJson(Map<String, dynamic> json) => _$RatingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);
}
