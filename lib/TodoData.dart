class TodoData {
  String title;
  String description;
  bool status;
  DateTime? dateTime;

  String getTtle() {
    return this.title;
  }

  String getDescription() {
    return this.description;
  }

  bool getStatus() {
    return this.status;
  }

  DateTime? getDateTime() {
    return this.dateTime;
  }

  TodoData(
      //   {String title = "",
      //   String description = "",
      //   bool status = true,
      //   DateTime dateTime}) {
      // this._title = title;
      // this._description = description;
      // this._status = status;
      // this._dateTime = dateTime;
      {
    required this.title,
    required this.description,
    required this.status,
    this.dateTime,
  });

  @override
  String toString() {
    return 'Todo: ${this.title} -> ${this.description} -> ${this.status} -> ${this.dateTime.toString()}';
  }

  TodoData clone() {
    return new TodoData(
        title: this.title,
        description: this.description,
        status: this.status,
        dateTime: this.dateTime);
  }


}
