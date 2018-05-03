class Photo {
  final String url;

  Photo(this.url);

  Photo.fromMap(Map<String, dynamic> map) : url = map["url"];
}
