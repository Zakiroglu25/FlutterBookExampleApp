class Aforizmler{
  String content_id;
  String content;
  String name_person;

  Aforizmler(this.content, this.name_person,this.content_id);


  factory Aforizmler.fromJson(String key, Map<dynamic,dynamic> json){
    return Aforizmler(key,
        json["content"] as String,
        json["name_person"] as String);
  }

}