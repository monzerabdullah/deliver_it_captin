import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          title: const Text('الدعم'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: DropdownMenu(
                  textStyle: const TextStyle(
                    fontFamily: 'Cairo',
                    color: kPrimaryText,
                    fontSize: 16.0,
                  ),
                  label: const Text(
                    'ما هي المشكلة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kPrimaryText,
                      fontSize: 16.0,
                    ),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryText,
                        width: 2,
                      ),
                    ),
                    iconColor: kPrimaryText,
                  ),
                  menuStyle: const MenuStyle(),
                  width: MediaQuery.of(context).size.width - 30,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      value: 'مشكلة في قبول الطلبات',
                      label: 'مشكلة في قبول الطلبات',
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(
                            fontFamily: 'Cairo',
                            color: kPrimaryText,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuEntry(
                      value: 'مشكلة في تسجيل الطلبيات',
                      label: 'مشكلة في تسجيل الطلبيات',
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(
                            fontFamily: 'Cairo',
                            color: kPrimaryText,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuEntry(
                      value: 'مشكلة في الإتصال بالعميل',
                      label: 'مشكلة في الإتصال بالعميل',
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(
                            fontFamily: 'Cairo',
                            color: kPrimaryText,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  maxLines: 8,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryText,
                        width: 4,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryText,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    minimumSize: const Size.fromHeight(51),
                    backgroundColor: kPrimary,
                  ),
                  child: const Text(
                    'إرسال',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.headset_mic_outlined,
                      size: 35,
                      color: kPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'إتصل بالدعم',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: kPrimary,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
