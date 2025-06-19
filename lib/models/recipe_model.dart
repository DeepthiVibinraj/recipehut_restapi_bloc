class RecipeModel {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'readyInMinutes': readyInMinutes,
        'servings': servings,
      };
}
