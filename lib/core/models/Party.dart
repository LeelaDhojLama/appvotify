class Party{
  String country;
  String title;
  String id;

  Party({this.country,this.title});

  Party.fromMap(Map snapshot, String id):
        id = id ?? '',
        country = snapshot['country'],
        title = snapshot['title'];

  toJson(){
    return{
      "id":id,
      "title":title,
      "country":country
    };
  }
}