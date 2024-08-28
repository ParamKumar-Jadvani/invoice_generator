import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/invoice_page.dart';
import '../screens/pdf_page.dart';

class AppRoutes {
  static String homePage = "/";
  static String invoicePage = "invoicePage";
  static String pdfPage = "pdfPage";

  static Map<String, Widget Function(BuildContext)> allRoutes = {
    homePage: (context) => const HomePage(),
    invoicePage: (context) => const InvoicePage(),
    pdfPage: (context) => const PdfPage(),
  };
}
