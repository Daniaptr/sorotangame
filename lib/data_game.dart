class GameData {
  int? id;
  String? name;
  String? genre;
  String? avatar;
  String? rating;
  String? images;
  String? desk;
  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;

  GameData(
      {this.id,
      this.genre,
      this.name,
      this.avatar,
      this.rating,
      this.images,
      this.desk,
      this.imageUrl1,
      this.imageUrl2,
      this.imageUrl3});

  GameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    genre = json['genre'];
    avatar = json['avatar'];
    rating = json['rating'];
    images = json['images'];
    desk = json['desk'];
    imageUrl1 = json['imageUrl1'];
    imageUrl2 = json['imageUrl2'];
    imageUrl3 = json['imageUrl3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['genre'] = this.genre;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['rating'] = this.rating;
    data['images'] = this.images;
    data['desk'] = this.desk;
    data['imageUrl1'] = this.imageUrl1;
    data['imageUrl2'] = this.imageUrl2;
    data['imageUrl3'] = this.imageUrl3;
    return data;
  }
}

