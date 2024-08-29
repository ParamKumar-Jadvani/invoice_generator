import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/globals.dart';

import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle titleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.pdfPage);
            },
            icon: const Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: Globals.userInvoiceData.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      foregroundImage: Globals.userInvoiceData[index]
                                  ['cmpLogo'] !=
                              null
                          ? FileImage(Globals.userInvoiceData[index]['cmpLogo'])
                          : null,
                      child: Globals.userInvoiceData[index]['cmpLogo'] == null
                          ? const Icon(Icons.business,
                              size: 30, color: Colors.black54)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company : ${Globals.userInvoiceData[index]['cmpName']}",
                            style: titleStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Customer : ${Globals.userInvoiceData[index]['cstName']}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.picture_as_pdf, size: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.pdfPage,
                            arguments: index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.invoicePage).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
