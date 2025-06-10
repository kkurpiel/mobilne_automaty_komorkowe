/// Model pojedynczej siatki, zapisana jest ilosc wierszy i kolumn oraz aktualne wypelnienie siatki.
/// Jezeli do modelu jest przekazane wypelnienie siatki to model przyjmuje je, w przeciwnym razie uzueplniany jest false
class GridModel {
  int columns;
  int rows;
  late List<List<bool>> selectedCells;
  
  GridModel({
    required this.columns,
    required this.rows,
    List<List<bool>>? selectedCells,
  }) 
  {
    if (selectedCells != null && selectedCells.isNotEmpty) {
      this.selectedCells = selectedCells;
    } else {
      this.selectedCells = List.generate(
        rows,
        (_) => List.generate(columns, (_) => false),
      );
    }
  }
}
