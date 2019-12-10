class Candidate{
  String name;
  String party;

  Candidate({this.party,this.name});

  Candidate.fromMap(Map snapshot, String id):
        party = snapshot['party'],
        name = snapshot['name'];

  toJson(){
    return{
      "name":name,
      "party":party,
    };
  }
}