import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../utils/globals.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<Uint8List> generateDocument(int index) async {
    // Retrieve the data from the selected invoice
    Map data = Globals.userInvoiceData[index];

    // Create a PDF document
    final pw.Document doc = pw.Document();

    // Add a page to the document
    doc.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Company Name
              pw.Text(
                data['cmpName'].toString(),
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue900,
                ),
              ),
              pw.SizedBox(height: 16),

              // Client Name and Email
              pw.Text(
                "Client Name: ${data['cstName']}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                "Client Email: ${data['cstEmail']}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.SizedBox(height: 32),

              // Invoice Information
              pw.Text(
                "Invoice Number: ${data['invoiceNumber']}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                "Total Price: \$${data['totalPrice'].toStringAsFixed(2)}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "GST: \$${(data['totalWithGst'] - data['totalPrice']).toStringAsFixed(2)}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "Total with GST: \$${data['totalWithGst'].toStringAsFixed(2)}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 32),

              // Product List Title
              pw.Text(
                "Product List:",
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),

              // Product List Headers
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Product Name',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                        color: PdfColors.blue900,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Quantity',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                        color: PdfColors.blue900,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Price',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                        color: PdfColors.blue900,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Total',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                        color: PdfColors.blue900,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Divider(color: PdfColors.blue900),

              // Product List Items
              ...data['productList'].map<pw.Widget>((product) {
                final total = product['price'] * product['quantity'];
                return pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        product['name'].toString(),
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        product['quantity'].toString(),
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        "\$${product['price'].toStringAsFixed(2)}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                );
              }).toList(),

              pw.SizedBox(height: 32),

              // Billing Information Section
              pw.Divider(color: PdfColors.grey),
              pw.SizedBox(height: 16),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Subtotal:",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "GST:",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "Total:",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(width: 16),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "\$${data['totalPrice'].toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "\$${(data['totalWithGst'] - data['totalPrice']).toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "\$${data['totalWithGst'].toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 32),

              // Footer
              pw.Text(
                "Thank you for your business!",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the document and return the bytes
    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Page"),
      ),
      body: PdfPreview(
        build: (format) => generateDocument(index),
      ),
    );
  }
}
