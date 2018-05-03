import 'package:flutter_demo/model/entity/photo.dart';

class Hotel {
  final int id;
  final String name;
  final int stars;
  final String address;
  final List<Photo> photos;

  Hotel(this.id, this.name, this.stars, this.address, this.photos);

  Hotel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map["name"]["en"],
        stars = map["stars"],
        address = map["address"]["en"],
        photos =
            (map['photos'] as List)?.map((i) => new Photo.fromMap(i))?.toList();
}
