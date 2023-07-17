
class Utility {
  static String formatDecimalNumber(String amount) {
   // NumberFormat df = NumberFormat('###.0#', 'en_US');
   // String ap = df.format(double.parse(amount));
   // print("Decimal value $ap");
    return double.parse(amount).toStringAsFixed(2);
  }
}
