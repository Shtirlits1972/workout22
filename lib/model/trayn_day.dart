class train_day {
  int id = 0;
  DateTime data = DateTime.now();

  train_day(this.id, this.data);
  train_day.empty();

  @override
  String toString() {
    return 'id = $id, data = $data';
  }
}
