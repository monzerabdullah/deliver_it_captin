import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/locator.dart';
import 'package:deliver_it_captin/services/firestore_service.dart';
import 'package:deliver_it_captin/views/order_details_view.dart';
import 'package:deliver_it_captin/widgets/day_data.dart';
import 'package:deliver_it_captin/widgets/work_timer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = locator<FirestoreService>();
  List<String> rejectedOrders = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: kWhite,
        //   onPressed: () {},
        //   child: const Icon(
        //     Icons.headset_mic_outlined,
        //     color: kPrimaryText,
        //   ),
        // ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: const Text('الرئيسية'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimary.withOpacity(.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            width: double.infinity,
                            height: 150,
                          ),
                          Positioned(
                            bottom: -30,
                            left: 0,
                            right: 0,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height,
                                maxWidth: MediaQuery.of(context).size.width,
                              ),
                              child: Card(
                                elevation: 4.0,
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  tileColor: Colors.white,
                                  trailing: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: kPrimary,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: kWhite,
                                    ),
                                  ),
                                  title: const Text(
                                    'منطقة التوصيل',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: kPrimaryText,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    'السادس من أكتوبر ، الحي السادس',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: kSecondaryText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'اليوم',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18.0,
                              color: kPrimaryText,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'السجل',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 18.0,
                                color: kPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        '22 يونيو ، 2024 ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22.0,
                          color: kPrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const DayData(),
                      const SizedBox(
                        height: 20,
                      ),
                      const WorkTimer(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: StreamBuilder(
                      stream: _firestore.activeOrders(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final orders = snapshot.data!.docs;
                        var visibleOrders = orders
                            .where(
                                (order) => !rejectedOrders.contains(order.id))
                            .toList();

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: visibleOrders.length,
                            itemBuilder: (context, index) {
                              final order = visibleOrders[index];
                              return NewOrderCard(
                                order: order,
                                rejectedOrders: rejectedOrders,
                              );
                            });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewOrderCard extends StatefulWidget {
  NewOrderCard({super.key, required this.order, required this.rejectedOrders});

  DocumentSnapshot order;
  List<String> rejectedOrders;

  @override
  State<NewOrderCard> createState() => _NewOrderCardState();
}

class _NewOrderCardState extends State<NewOrderCard> {
  final FirestoreService _firestore = locator<FirestoreService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // void _acceptOrder(String orderId) async {
  //   final user = _auth.currentUser;

  //   if (user != null) {
  //     await _firestore.collection('orders').doc(orderId).update({
  //       'rider_id': user.uid,
  //       'status': 'accepted',
  //       'visibility': 'accepted_only',
  //     });
  //   }
  // }

  // void _arrivedAtStore(String orderId) async {
  //   await _firestore.collection('orders').doc(orderId).update({
  //     'pickup_location': 'pickup location address',
  //     'delivery_location': 'delivery location address',
  //     'receipt_image': 'url_to_receipt_image',
  //   });
  // }

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

  void _rejectOrder(String orderId) {
    setState(() {
      widget.rejectedOrders.add(orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 330,
        height: 500,
        child: Card(
          color: kWhite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          widget.order['storeLogoUrl'],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.order['store_name'],
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: kPrimaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            ' 1 طلبات ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: kSecondaryText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kPrimary,
                      child: IconButton(
                        onPressed: () {
                          //  widget.order['storePhone']
                          //laucnh call here
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: kWhite,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CircleAvatar(
                      backgroundColor: kPrimary,
                      child: Icon(
                        Icons.location_pin,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '• رقم الرحلة : ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kSecondaryText,
                        ),
                      ),
                      TextSpan(
                        text: widget.order.id,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '• عنوان المطعم : ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kSecondaryText,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.order['location']}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '• تاريخ إنشاء الرحلة: ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kSecondaryText,
                        ),
                      ),
                      TextSpan(
                        text: widget.order['created_at'].toDate().toString(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '• الحالة : ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kSecondaryText,
                        ),
                      ),
                      TextSpan(
                        text: chaipLabel(widget.order['status']),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '• طريقة الدفع : ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kSecondaryText,
                        ),
                      ),
                      TextSpan(
                        text: 'كاش',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: kPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.order['status'] == 'accepted') ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          foregroundColor: kWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          // minimumSize:
                          //     const Size.fromHeight(32),
                        ),
                        onPressed: () {
                          _firestore.arrivedAtStore(widget.order.id);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RiderOrderDetailsScreen(
                                orderId: widget.order.id,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'لقد وصلت',
                        ),
                      )
                    ] else ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          foregroundColor: kWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          // minimumSize:
                          //     const Size.fromHeight(32),
                        ),
                        onPressed: () {
                          _firestore.acceptOrder(
                            orderId: widget.order.id,
                            riderId: _auth.currentUser!.uid,
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         RiderOrderDetailsScreen(
                          //             orderId: order.id),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'قبول',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kRed,
                          foregroundColor: kWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          // minimumSize: const Size.fromHeight(32),
                        ),
                        onPressed: () {
                          _rejectOrder(widget.order.id);
                        },
                        child: const Text(
                          'رفض',
                        ),
                      )
                    ],
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
