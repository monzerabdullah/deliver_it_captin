import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/views/details_view.dart';
import 'package:deliver_it_captin/views/order_details_view.dart';
import 'package:deliver_it_captin/views/tabs/accepted_view.dart';
import 'package:deliver_it_captin/views/tabs/all_view.dart';
import 'package:deliver_it_captin/views/tabs/canceled_view.dart';
import 'package:deliver_it_captin/views/tabs/delivered_view.dart';
import 'package:deliver_it_captin/views/tabs/delivering_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text('سجل الرحلات'),
      ),
      body: const OrdersList(),
    );
  }
}

class OrdersList extends StatefulWidget {
  const OrdersList({
    super.key,
  });

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWhite,
          toolbarHeight: 10,
          bottom: const TabBar(
            indicatorColor: kPrimary,
            tabs: [
              Tab(
                child: Text('الكل'),
              ),
              Tab(
                child: Text('تم القبول'),
              ),
              Tab(
                child: Text('جاري'),
              ),
              Tab(
                child: Text('وصلت'),
              ),
              Tab(
                child: Text('ملغية'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllOrders(),
            AcceptedOrders(),
            DeliveringOrders(),
            DeliveredOrders(),
            CanceledOrders(),
          ],
        ),
      ),
    );
  }
}

class OrdersItem extends StatelessWidget {
  OrdersItem({super.key, required this.orderId});

  final String orderId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _readyToStart(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'ready_to_start',
    });
  }

  String chaipLabel(String orderStatus) {
    if (orderStatus == 'pending') {
      return 'في إنتظار القبول';
    } else if (orderStatus == 'accepted') {
      return 'تم القبول';
    } else if (orderStatus == 'ready_to_start') {
      return 'جاهز للتوصيل';
    } else if (orderStatus == 'delivering') {
      return 'جاري للتوصيل';
    } else if (orderStatus == 'canceled') {
      return 'ملغية';
    } else if (orderStatus == 'delivered') {
      return 'تم التوصيل';
    } else {
      return 'غير محدد';
    }
  }

  WidgetStatePropertyAll<Color?> chipColor(String orderStatus) {
    if (orderStatus == 'pending') {
      return const WidgetStatePropertyAll(kPrimary);
    } else if (orderStatus == 'accepted') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'ready_to_start') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'delivering') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'delivered') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'canceled') {
      return const WidgetStatePropertyAll(kRed);
    } else {
      return const WidgetStatePropertyAll(kPrimary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('orders').doc(orderId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final order = snapshot.data!;
          return Card(
            color: kWhite,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: chipColor(order.get('status')),
                        label: Text(
                          chaipLabel(order.get('status')),
                          style: const TextStyle(
                            color: kWhite,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      Text(
                        orderId,
                        style: const TextStyle(
                          color: kPrimaryText,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: LocationSide()),
                      Expanded(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 32,
                          color: kPrimaryText,
                        ),
                      ),
                      Expanded(child: LocationSide()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      order['status'] == 'accepted' ||
                              order['status'] == 'ready_to_start'
                          ? ElevatedButton(
                              onPressed: () {
                                _readyToStart(order.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'طلب تأكيد',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: kWhite,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                order.data()!.containsKey('recipient_image_url')
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailsView(
                                            orderId: order.id,
                                          ),
                                        ),
                                      )
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RiderOrderDetailsScreen(
                                            orderId: order.id,
                                          ),
                                        ),
                                      );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: const BorderSide(
                                    color: kPrimary,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'التفاصيل',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: kPrimary,
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class LocationSide extends StatelessWidget {
  const LocationSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أكتوبر الحي التاني',
          style: TextStyle(
            color: kPrimaryText,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          '22 يونيو ، 2024 ،  PM 8:04',
          style: TextStyle(
            color: kSecondaryText,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
