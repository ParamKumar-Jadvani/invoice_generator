import 'dart:io';
import 'dart:math';

class Globals {
  Random random = Random();
  static String? cmpName;
  static String? cstName;
  static String? cstEmail;
  static File? cmpLogo;
  static DateTime? invoiceDate;
  static DateTime? dueDate;
  static int? invoiceNumber = Random().nextInt(1000000);
  static double? totalPrice = 0;
  static List<Map<String, dynamic>>? productList;
}

class ItemData {
  String? itemName;
  double? itemPrice;
  int? itemQuantity;
  List<Map<String, dynamic>>? itemDetails;

  ItemData(
      {required this.itemName,
      required this.itemPrice,
      required this.itemQuantity});

  get getList => itemDetails;
}
