class Vote{
  String id;
  String user;
  String party;
  String comment;

  Vote({this.user, this.party, this.comment});

  Vote.fromMap(Map snapshot, String id):
        id = id ?? '',
        user = snapshot['user'],
        party = snapshot['address'],
        comment = snapshot['comment'];

  toJson(){
    return{
      "user":user,
      "party":party,
      "comment":comment,
    };
  }

}
