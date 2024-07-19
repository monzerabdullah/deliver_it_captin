import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/views/sign_continue_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class RiderOrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const RiderOrderDetailsScreen({super.key, required this.orderId});

  @override
  _RiderOrderDetailsScreenState createState() =>
      _RiderOrderDetailsScreenState();
}

class _RiderOrderDetailsScreenState extends State<RiderOrderDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _destinationLocation = '';
  String _recipientPhoneNumber = '';
  File? _recipientImage;
  final ImagePicker _picker = ImagePicker();

  void _saveOrderDetails() async {
    if (_auth.currentUser != null && widget.orderId.isNotEmpty) {
      String? imageUrl;

      if (_recipientImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('recipient_images')
            .child('${widget.orderId}.jpg');
        await storageRef.putFile(_recipientImage!);
        imageUrl = await storageRef.getDownloadURL();
      }

      await _firestore.collection('orders').doc(widget.orderId).update({
        'destination_location': _destinationLocation,
        'recipient_phone_number': _recipientPhoneNumber,
        'recipient_image_url': imageUrl,
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _recipientImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              _recipientImage == null
                  ? const Text(
                      'لا توجد صورة إيصال بعد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                      ),
                    )
                  : Image.file(_recipientImage!),
              const SizedBox(
                height: 15,
              ),
              _recipientImage == null
                  ? InkWell(
                      onTap: _pickImage,
                      child: DottedBorder(
                        color: kPrimary,
                        child: const SizedBox(
                          height: 112,
                          width: double.infinity,
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: kPrimaryText,
                                size: 55,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'إضغط لإستخدام الكاميرا لتسجيل الإيصال',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: kPrimaryText,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _destinationLocation = value,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.location_pin),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                initialCountryCode: 'EG',
                onChanged: (phone) =>
                    _recipientPhoneNumber = phone.completeNumber,
                decoration: const InputDecoration(
                  labelText: 'Recipient Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              const SizedBox(
                height: 8,
              ),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: kWhite,
              //     backgroundColor: kPrimary,
              //     textStyle: const TextStyle(
              //       fontSize: 20.0,
              //       fontFamily: 'Cairo',
              //       fontWeight: FontWeight.w600,
              //     ),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 22,
              //       vertical: 16,
              //     ),
              //     minimumSize: const Size.fromHeight(60),
              //   ),
              //   child: const Text('Pick Recipient Image'),
              // ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveOrderDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  foregroundColor: kWhite,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text('Save Order Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
