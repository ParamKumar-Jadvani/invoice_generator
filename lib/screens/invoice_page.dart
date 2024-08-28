import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_generator/utils/extensions.dart';
import 'package:invoice_generator/utils/globals.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  TextStyle titleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemQTYController = TextEditingController();

  final TextEditingController cmpNameController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController clientEmailController = TextEditingController();

  final formKey_ForData = GlobalKey<FormState>();
  final formKey_ForItem = GlobalKey<FormState>();
  double? gst, totalWithGst;

  @override
  void initState() {
    Globals.productList.clear();

    gst = Globals.totalPrice * 0.18;
    totalWithGst = Globals.totalPrice + gst!;
    super.initState();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemPriceController.dispose();
    itemQTYController.dispose();
    cmpNameController.dispose();
    clientNameController.dispose();
    clientEmailController.dispose();
    super.dispose();
  }

  void saveItem() {
    if (formKey_ForItem.currentState!.validate()) {
      setState(() {
        Globals.productList.add({
          'name': itemNameController.text,
          'price': double.parse(itemPriceController.text),
          'quantity': int.parse(itemQTYController.text),
        });
        Globals.updateTotalPrice();
        itemNameController.clear();
        itemPriceController.clear();
        itemQTYController.clear();

        gst = Globals.totalPrice * 0.18;
        totalWithGst = Globals.totalPrice + gst!;
      });
    }
  }

  void saveData() {
    if (formKey_ForData.currentState!.validate()) {
      formKey_ForData.currentState!.save();

      Globals.cmpName = cmpNameController.text;
      Globals.cstName = clientNameController.text;
      Globals.cstEmail = clientEmailController.text;

      Globals.userInvoiceData.add({
        "cmpName": Globals.cmpName,
        "cstName": Globals.cstName,
        "cstEmail": Globals.cstEmail,
        "invoiceNumber": Globals.invoiceNumber,
        "productList": List.from(Globals.productList),
        "totalPrice": Globals.totalPrice,
        "totalWithGst": totalWithGst,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Form Saved Successfully...!!"),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );

      print(Globals.userInvoiceData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Invoice Page".ts(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey_ForData,
                    child: Column(
                      children: [
                        "Company Data".ts(style: titleStyle),
                        15.h,
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                foregroundImage: Globals.cmpLogo != null
                                    ? FileImage(Globals.cmpLogo!)
                                    : null,
                                radius: 60,
                                child: Globals.cmpLogo == null
                                    ? const Icon(
                                        Icons.business,
                                        size: 50,
                                      )
                                    : null,
                              ),
                              FloatingActionButton(
                                onPressed: () async {
                                  ImagePicker imgPicker = ImagePicker();
                                  XFile? file = await imgPicker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (file != null) {
                                    setState(() {
                                      Globals.cmpLogo = File(file.path);
                                    });
                                  }
                                },
                                child: const Icon(Icons.camera),
                              )
                            ],
                          ),
                        ),
                        15.h,
                        TextFormField(
                          controller: cmpNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Company Name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Company Name",
                            hintText: "Enter Company Name",
                          ),
                        ),
                        16.h,
                        3.div,
                        16.h,
                        "Client Data".ts(style: titleStyle),
                        15.h,
                        TextFormField(
                          controller: clientNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Client Name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Client Name",
                            hintText: "Enter Client Name",
                          ),
                        ),
                        15.h,
                        TextFormField(
                          controller: clientEmailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Client Email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "Client Email",
                            hintText: "Enter Client Email",
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.h,
                  3.div,
                  16.h,
                  Form(
                    key: formKey_ForItem,
                    child: Column(
                      children: [
                        "Item Data".ts(style: titleStyle),
                        15.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: itemNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Item Name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Item Name",
                                  hintText: "Enter Item Name",
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            10.w,
                            Expanded(
                              child: TextFormField(
                                controller: itemQTYController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Item QTY";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Item QTY",
                                  hintText: "Enter Item QTY",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            10.w,
                            Expanded(
                              child: TextFormField(
                                controller: itemPriceController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Item Price";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Item Price",
                                  hintText: "Enter Item Price",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        15.h,
                        ElevatedButton(
                          onPressed: saveItem,
                          child: "Save Item".ts(),
                        ),
                        20.h,
                        "Saved Items".ts(style: titleStyle),
                      ],
                    ),
                  ),
                  10.h,
                  Globals.productList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: Globals.productList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Globals.productList[index]['name']
                                    .toString()
                                    .ts(),
                                subtitle:
                                    "Qty: ${Globals.productList[index]['quantity']}, Price: ${Globals.productList[index]['price']}"
                                        .ts(),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      Globals.productList.removeAt(index);
                                      Globals.updateTotalPrice();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : "No items saved".ts(),
                  20.h,
                  3.div,
                  16.h,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Total Price: ₹${Globals.totalPrice.toStringAsFixed(2)}"
                          .ts(),
                      "GST (18%): ₹${gst!.toStringAsFixed(2)}".ts(),
                      "Total with GST: ₹${totalWithGst!.toStringAsFixed(2)}"
                          .ts(),
                    ],
                  ),
                  16.h,
                  3.div,
                  16.h,
                  ElevatedButton(
                      onPressed: saveData, child: const Text("Save Data"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
