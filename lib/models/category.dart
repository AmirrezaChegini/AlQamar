class Category {
  final int? _id;
  final String? _name;
  final String? _description;
  final String? _photo;

  Category(this._id, this._name, this._description, this._photo);

  factory Category.fromMapJson(Map<String, dynamic> jsonObject) {
    return Category(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['description'],
      jsonObject['photo_path'],
    );
  }

  int get id => _id ?? 0;
  String get name => _name ?? '';
  String get description => _description ?? '';
  String get photo => _photo ?? '';
}
