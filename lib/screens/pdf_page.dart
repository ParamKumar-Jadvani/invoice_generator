import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/globals.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import "package:printing/printing.dart";

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<Uint8List> generateDocument(int index) async {
    Map Data = Globals.userInvoiceData[index];
    final pw.Document doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "${Data}",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ); // Center
        },
      ),
    ); // Page
    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDf Page"),
      ),
      body: PdfPreview(
        build: (format) => generateDocument(index),
      ),
    );
  }
}
