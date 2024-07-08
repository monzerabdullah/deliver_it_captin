import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/imgs/ali.jpg'),
                radius: 60.0,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'أمجد صلاح سالم',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22.0,
                  color: kPrimaryText,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: Divider(
                    color: kPrimaryText,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'الملف الشخصي',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.grading,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'سجل الطلبيات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.star_border_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'التقييمات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.headset_mic_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'المساعدة والدعم',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: kPrimaryText,
                size: 35,
                textDirection: TextDirection.rtl,
              ),
              title: Text(
                'تسجيل خروج',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: kPrimaryText,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
