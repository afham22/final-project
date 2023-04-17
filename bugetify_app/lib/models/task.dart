class Task {
  int? id;
  String? title;
  String? date;
  int? color;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.date,
    this.color,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    date = json['date'];
    color = json['color'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['color'] = this.color;
    data['repeat'] = this.repeat;

    return data;
  }
}
