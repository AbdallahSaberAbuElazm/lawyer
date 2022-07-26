class Legal {
  String? legalUrl;
  String? legalName;

  Legal({required this.legalUrl, required this.legalName});

  Legal.fromJson(Map<String, dynamic> json) {
    legalUrl = json['legalUrl'];
    legalName = json['legalName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'legalUrl': legalUrl,
      'legalName': legalName,
    };
  }
}
