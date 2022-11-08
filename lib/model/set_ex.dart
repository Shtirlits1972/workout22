class SetEx {
  int id = 0;
  int RowId = 0;

  double weight = 0;
  int qty = 1;

  SetEx(this.id, this.RowId, this.weight, this.qty);
  SetEx.empty();

  @override
  String toString() {
    return 'id = $id, RowId = $RowId, weight = $weight, qty = $qty';
  }
}
