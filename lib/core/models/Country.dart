class Country{
  String id;
  String title;

  Country({this.id,this.title});

  Country.fromMap(Map snapshot, String id):
        id = id ?? '',
        title = snapshot['title'];

  toJson(){
    return{
      "id":id,
      "title":title,
    };
  }
}