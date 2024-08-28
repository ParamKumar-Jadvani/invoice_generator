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
  String? itemName, itemPrice, itemQuantity;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              ImagePicker imgPicker = ImagePicker();
                              XFile? file = await imgPicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              (file != null)
                                  ? setState(() {
                                      Globals.cmpLogo = File(file.path);
                                    })
                                  : null;
                            },
                            child: const Icon(Icons.camera),
                          )
                        ],
                      ),
                    ),
                    15.h,
                    TextFormField(
                      initialValue: Globals.cmpName,
                      onSaved: (value) {
                        Globals.cmpName = value;
                      },
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
                    2.div,
                    16.h,
                    "Client Data".ts(style: titleStyle),
                    15.h,
                    TextFormField(
                      initialValue: Globals.cstName,
                      onSaved: (value) {
                        Globals.cstName = value;
                      },
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
                      initialValue: Globals.cstEmail,
                      onSaved: (value) {
                        Globals.cstEmail = value;
                      },
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
                    16.h,
                    2.div,
                    16.h,
                    "Item Data".ts(style: titleStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: itemName,
                            onSaved: (value) {
                              itemName = value;
                            },
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
                            initialValue: itemQuantity,
                            onSaved: (value) {
                              itemQuantity = value;
                            },
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
                            initialValue: itemPrice,
                            onSaved: (value) {
                              itemPrice = value;
                            },
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
