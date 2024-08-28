import 'dart:io';
import 'dart:math';

class Globals {
  Random random = Random();
  static String? cmpName;
  static String? cstName;
  static String? cstEmail;
  static File? cmpLogo;
  static int? invoiceNumber = Random().nextInt(1000000);
  static double totalPrice = 0;
  static List<Map<String, dynamic>> productList = [];
  static List<Map> userInvoiceData = [];

  static void updateTotalPrice() {
    double total = 0;

    Globals.productList.forEach((item) {
      double itemTotal = (item['price'] as double) * (item['quantity'] as int);
      item['total'] = itemTotal;
      total += itemTotal;
    });

    Globals.totalPrice = total;
  }
}
