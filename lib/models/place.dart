class Place {
  final int id;
  final String name;
  final String description;
  final String image;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: int.parse(json['id']),
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}