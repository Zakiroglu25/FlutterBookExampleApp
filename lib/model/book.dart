class Book {
  String id;
  String url;
  int book_code;
  String book_name;
  String desc;

  Book(this.id, this.url, this.book_code, this.book_name,this.desc);

  factory Book.fromJson(String key, Map<dynamic, dynamic> json) {
    return Book(key, json["url"] as String, json["book_code"] as int,
        json["book_name"] as String,
    json["desc"] as String
    );
  }
}
