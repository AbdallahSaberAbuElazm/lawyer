class OfferModel {
  String? offer;
  String? lawID;
  String? problemID;
  String? category;
  String? userID;
  String? date;
  String? username;
  String? profileImage;

  OfferModel(this.offer, this.problemID, this.category, this.userID, this.date,
      this.username, this.profileImage, this.lawID);
  OfferModel.fromJson(Map<String, dynamic> json) {
    offer = json['title'];
    lawID = json['lawID'];
    problemID = json['problemID'];
    category = json['category'];
    userID = json['userID'];
    date = json['date'];
    username = json['username'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': offer,
      'category': category,
       'lawID': lawID,
       'problemID': problemID,
      'userID': userID,
      'date': date,
      'username': username,
      'profileImage': profileImage,
      
    };
  }
}
