import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/views/login_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

enum workStyle { shift, freelance }

class SignUpContinue extends StatelessWidget {
  const SignUpContinue({super.key});

  final workStyle _style = workStyle.shift;

  @override
  Widget build(BuildContext context) {
    final mqWidth = MediaQuery.of(context).size.width;
    final mqHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: mqHeight + 45,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 35,
                ),
                child: Column(
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
                      height: 24,
                    ),
                    const ImagePickerButton(
                      data: 'صورة البطاقة الشخصية',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const ImagePickerButton(
                      data: 'صورة رخصة المركبة',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const ImagePickerButton(
                      data: 'صورة لرقم اللوحة',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WorkStyleSelector(
                          style: workStyle.shift,
                          data: 'نظام الشيفت',
                        ),
                        WorkStyleSelector(
                          style: workStyle.freelance,
                          data: 'نظام الفريلانسر',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const TimerPickerRow(
                      label: 'بداية الشفت',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const TimerPickerRow(
                      label: 'نهاية الشفت',
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpContinue()));
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
                        'أنشيء حسابك',
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
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
                    const SizedBox(
                      height: 20,
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

class WorkStyleSelector extends StatelessWidget {
  const WorkStyleSelector({
    super.key,
    required this.style,
    required this.data,
  });

  final workStyle style;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<workStyle>(
          value: workStyle.shift,
          groupValue: style,
          onChanged: (value) {},
          activeColor: kPrimary,
        ),
        Text(
          data,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: kSecondaryText,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({
    super.key,
    required this.data,
  });
  final String data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: DottedBorder(
        color: kSecondaryText,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add_a_photo,
              color: kSecondaryText,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data,
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: kSecondaryText,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPickerRow extends StatefulWidget {
  const TimerPickerRow({super.key, required this.label});
  final String label;

  @override
  State<TimerPickerRow> createState() => _TimerPickerRowState();
}

class _TimerPickerRowState extends State<TimerPickerRow> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: _timeOfDay,
          initialEntryMode: TimePickerEntryMode.inputOnly,
        );
        if (timeOfDay != null) {
          setState(() {
            _timeOfDay = timeOfDay;
          });
        } else {
          _timeOfDay = TimeOfDay.now();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: kSecondaryText,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.access_time,
              size: 32,
              color: kPrimaryText,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    color: kSecondaryText,
                  ),
                ),
                Text(
                  '${_timeOfDay.hour}:${_timeOfDay.minute}',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20.0,
                    color: kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
