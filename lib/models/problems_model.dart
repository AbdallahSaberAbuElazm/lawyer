class ProblemsModel {
  String? title;
  String? desc;
  String? category;
  String? userID;
  String? date;
  String? username;
  bool? isSolved;

  ProblemsModel(this.title, this.desc, this.category, this.userID,this.date,this.username,this.isSolved);
  ProblemsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    category = json['category'];
    userID = json['userID'];
    date = json['date'];
    username = json['username'];
    isSolved = json['isSolved'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'category': category,
      'userID': userID,
      'date': date,
      'username': username,
      'isSolved': isSolved,
    };
  }
}
