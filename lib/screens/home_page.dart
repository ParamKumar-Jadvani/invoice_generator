import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/extensions.dart';
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
    fontSize: 20,
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
      body: Center(
        child: ListView.builder(
          itemCount: Globals.userInvoiceData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.pdfPage,
                    arguments: index);
              },
              child: ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Company : ${Globals.userInvoiceData[index]['cmpName']}"
                                  .ts(),
                              "Customer : ${Globals.userInvoiceData[index]['cstName']}"
                                  .ts(),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          foregroundImage:
                              Globals.userInvoiceData[index]['cmpLogo'] != null
                                  ? FileImage(
                                      Globals.userInvoiceData[index]['cmpLogo'])
                                  : null,
                        ),
                      ],
                    ),
                  ),
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
