class TodoData {
  String _title = "";
  String _description = "";
  bool _status = true;
  DateTime _dateTime = new DateTime(new DateTime.now().year,
      new DateTime.now().month, new DateTime.now().day);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  TodoData(
      {String title = "",
      String description = "",
      bool status = true,
      required DateTime dateTime}) {
    this._title = title;
    this._description = description;
    this._status = status;
    this._dateTime = dateTime;
  }

  @override
  String toString() {
    return 'Todo: ${this._title} -> ${this._description} -> ${this._status}';
  }

  TodoData clone() {
    return new TodoData(
        title: this._title,
        description: this._description,
        status: this._status,
        dateTime: this._dateTime);
  }
}
