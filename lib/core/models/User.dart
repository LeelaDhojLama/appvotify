class User{
  String id;
  String name;
  String age;
  String address;
  String insurance;

  User({this.id, this.name, this.age,this.address,this.insurance});

  User.fromMap(Map snapshot, String id):
      id = id ?? '',
      name = snapshot['name'],
      address = snapshot['address'],
      age = snapshot['age'],
      insurance = snapshot['insurance'];

  toJson(){
    return{
      "name":name,
      "address":address,
      "age":age,
      "insurance":insurance,
    };
  }

}
