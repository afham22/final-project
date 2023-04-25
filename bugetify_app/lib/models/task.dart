class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  int? color;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.date,
    this.color,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['amount'].toString();
    note = json['note'];
    date = json['date'];
    color = json['color'];
    repeat = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.title;
    data['note'] = this.note;
    data['date'] = this.date;
    data['color'] = this.color;
    data['category'] = this.repeat;

    return data;
  }
}
