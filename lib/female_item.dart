class FemaleItem {
  String name;

  FemaleItem({this.name});

  FemaleItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    return data;
  }
}
