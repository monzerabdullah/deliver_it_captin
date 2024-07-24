import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/locator.dart';
import 'package:deliver_it_captin/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, this.toggleView});
  final Function()? toggleView;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController avatarController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idCardNumController = TextEditingController();
  final AuthenticationService _auth = locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 35,
            ),
            child: ListView(
              children: [
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'أنشيء حسابك',
                      style: TextStyle(
                        color: kPrimaryText,
                        fontSize: 32.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Text(
                        'قم بإنشاء حساب ، وقم بإيصال الطلبات!!',
                        style: TextStyle(
                          color: kSecondaryText,
                          fontSize: 16.0,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 34,
                ),
                Stack(
                  children: [
                    SvgPicture.asset(
                      'images/svgs/avatar.svg',
                      width: 140,
                    ),
                    Positioned(
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: kPrimary,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: avatarController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رابط لصورة شخصية',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الإسم الرباعي',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم الهاتف',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'البريد',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'كلمة السر',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  obscureText: true,
                  controller: idCardNumController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم البطاقة الشخصية',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  obscureText: true,
                  controller: plateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم اللوحة',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signUpWithEmail(
                      avatarImgUrl: avatarController.text,
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phoneNumber: phoneNumberController.text,
                      idCardNumber: idCardNumController.text,
                      plateNumber: plateController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
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
                  child: const Text(
                    'التالي',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Text(
                      'إذا كان لديك حساب قم',
                      style: TextStyle(
                        color: kSecondaryText,
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.toggleView,
                      child: const Text(
                        'بتسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimary,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
