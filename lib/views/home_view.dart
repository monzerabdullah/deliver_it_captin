import 'package:deliver_it_captin/constants.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> rejectedOrders = [];
  void _acceptOrder(String orderId) async {
    final user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection('orders').doc(orderId).update({
        'rider_id': user.uid,
        'status': 'accepted',
        'visibility': 'accepted_only',
      });
    }
  }

  void _arrivedAtStore(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'pickup_location': 'pickup location address',
      'delivery_location': 'delivery location address',
      'receipt_image': 'url_to_receipt_image',
    });
  }

  void _rejectOrder(String orderId) {
    setState(() {
      rejectedOrders.add(orderId);
    });
  }

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
                      stream: _firestore
                          .collection('orders')
                          // .where('visibility', isEqualTo: 'public')
                          .where(
                        'status',
                        whereIn: ['pending', 'accepted'],
                      ).snapshots(),
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
                              return Center(
                                child: SizedBox(
                                  width: 330,
                                  // height: 40,
                                  child: Card(
                                    color: kWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 42,
                                                backgroundImage: AssetImage(
                                                  'images/imgs/ali.jpg',
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Order ID: ${order.id}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color: kPrimaryText,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                          const Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: kPrimary,
                                                child: Icon(
                                                  Icons.phone,
                                                  color: kWhite,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: kPrimary,
                                                child: Icon(
                                                  Icons.location_pin,
                                                  color: kWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          const Text(
                                            '• رقم الرحلة : ',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              color: kSecondaryText,
                                            ),
                                          ),
                                          const Text(
                                            '• عنوان المطعم : ',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              color: kSecondaryText,
                                            ),
                                          ),
                                          const Text(
                                            '• تاريخ إنشاء الرحلة: ',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              color: kSecondaryText,
                                            ),
                                          ),
                                          const Text(
                                            '• الحالة : ',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              color: kSecondaryText,
                                            ),
                                          ),
                                          const Text(
                                            '• طريقة الدفع : ',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                              color: kSecondaryText,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (order['status'] ==
                                                  'accepted') ...[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: kPrimary,
                                                    foregroundColor: kWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 22,
                                                      vertical: 16,
                                                    ),
                                                    // minimumSize:
                                                    //     const Size.fromHeight(32),
                                                  ),
                                                  onPressed: () {
                                                    _arrivedAtStore(order.id);
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RiderOrderDetailsScreen(
                                                          orderId: order.id,
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: kPrimary,
                                                    foregroundColor: kWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 22,
                                                      vertical: 16,
                                                    ),
                                                    // minimumSize:
                                                    //     const Size.fromHeight(32),
                                                  ),
                                                  onPressed: () {
                                                    _acceptOrder(order.id);
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: kRed,
                                                    foregroundColor: kWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 22,
                                                      vertical: 16,
                                                    ),
                                                    // minimumSize: const Size.fromHeight(32),
                                                  ),
                                                  onPressed: () {
                                                    _rejectOrder(order.id);
                                                    // Navigator.of(context).push(
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         RiderOrderDetailsScreen(
                                                    //             orderId: order.id),
                                                    //   ),
                                                    // );
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

// class NewOrder extends StatefulWidget {
//   const NewOrder({super.key});

//   @override
//   _NewOrderState createState() => _NewOrderState();
// }

// class _NewOrderState extends State<NewOrder> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void _acceptOrder(String orderId) async {
//     final user = _auth.currentUser;

//     if (user != null) {
//       await _firestore.collection('orders').doc(orderId).update({
//         'rider_id': user.uid,
//         'status': 'accepted',
//         'visibility': 'accepted_only',
//       });
//     }
//   }

//   void _arrivedAtStore(String orderId) async {
//     await _firestore.collection('orders').doc(orderId).update({
//       'status': 'ready_to_start',
//       'pickup_location': 'pickup location address',
//       'delivery_location': 'delivery location address',
//       'receipt_image': 'url_to_receipt_image',
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: StreamBuilder(
//           stream: _firestore
//               .collection('orders')
//               .where('status', isEqualTo: 'pending')
//               .where('visibility', isEqualTo: 'public')
//               .snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final orders = snapshot.data!.docs;

//             return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//                   final order = orders[index];
//                   return Center(
//                     child: SizedBox(
//                       width: 330,
//                       // height: 40,
//                       child: Card(
//                         color: kWhite,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     radius: 42,
//                                     backgroundImage: AssetImage(
//                                       'images/imgs/ali.jpg',
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 20,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Store ID: ${order['store_id']}',
//                                           style: const TextStyle(
//                                             fontFamily: 'Cairo',
//                                             color: kPrimaryText,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         const Text(
//                                           ' 1 طلبات ',
//                                           style: TextStyle(
//                                             fontFamily: 'Cairo',
//                                             color: kSecondaryText,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               const Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: kPrimary,
//                                     child: Icon(
//                                       Icons.phone,
//                                       color: kWhite,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   CircleAvatar(
//                                     backgroundColor: kPrimary,
//                                     child: Icon(
//                                       Icons.location_pin,
//                                       color: kWhite,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Divider(),
//                               const Text(
//                                 '• رقم الرحلة : ',
//                                 style: TextStyle(
//                                   fontFamily: 'Cairo',
//                                   fontSize: 14,
//                                   color: kSecondaryText,
//                                 ),
//                               ),
//                               const Text(
//                                 '• عنوان المطعم : ',
//                                 style: TextStyle(
//                                   fontFamily: 'Cairo',
//                                   fontSize: 14,
//                                   color: kSecondaryText,
//                                 ),
//                               ),
//                               const Text(
//                                 '• تاريخ إنشاء الرحلة: ',
//                                 style: TextStyle(
//                                   fontFamily: 'Cairo',
//                                   fontSize: 14,
//                                   color: kSecondaryText,
//                                 ),
//                               ),
//                               const Text(
//                                 '• الحالة : ',
//                                 style: TextStyle(
//                                   fontFamily: 'Cairo',
//                                   fontSize: 14,
//                                   color: kSecondaryText,
//                                 ),
//                               ),
//                               const Text(
//                                 '• طريقة الدفع : ',
//                                 style: TextStyle(
//                                   fontFamily: 'Cairo',
//                                   fontSize: 14,
//                                   color: kSecondaryText,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   (order['status'] == 'accepted')
//                                       ? ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: kPrimary,
//                                             foregroundColor: kWhite,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4),
//                                             ),
//                                             textStyle: const TextStyle(
//                                               fontSize: 16.0,
//                                               fontFamily: 'Cairo',
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 22,
//                                               vertical: 16,
//                                             ),
//                                             // minimumSize:
//                                             //     const Size.fromHeight(32),
//                                           ),
//                                           onPressed: () {
//                                             _arrivedAtStore(order['id']);
//                                             Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     RiderOrderDetailsScreen(
//                                                         orderId: order.id),
//                                               ),
//                                             );
//                                           },
//                                           child: const Text(
//                                             'لقد وصلت',
//                                           ),
//                                         )
//                                       : ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: kPrimary,
//                                             foregroundColor: kWhite,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4),
//                                             ),
//                                             textStyle: const TextStyle(
//                                               fontSize: 16.0,
//                                               fontFamily: 'Cairo',
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 22,
//                                               vertical: 16,
//                                             ),
//                                             // minimumSize:
//                                             //     const Size.fromHeight(32),
//                                           ),
//                                           onPressed: () {
//                                             _acceptOrder(order.id);
//                                             Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     RiderOrderDetailsScreen(
//                                                         orderId: order.id),
//                                               ),
//                                             );
//                                           },
//                                           child: const Text(
//                                             'قبول',
//                                           ),
//                                         ),
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: kRed,
//                                       foregroundColor: kWhite,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                       textStyle: const TextStyle(
//                                         fontSize: 16.0,
//                                         fontFamily: 'Cairo',
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 22,
//                                         vertical: 16,
//                                       ),
//                                       // minimumSize: const Size.fromHeight(32),
//                                     ),
//                                     onPressed: () {
//                                       _acceptOrder(order.id);
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               RiderOrderDetailsScreen(
//                                                   orderId: order.id),
//                                         ),
//                                       );
//                                     },
//                                     child: const Text(
//                                       'رفض',
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }

// // class StoreOrderCard extends StatelessWidget {
// //   const StoreOrderCard({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(4),
// //                 child: Image.asset('images/imgs/ali.jpg'),
// //               ),
// //               const SizedBox(
// //                 width: 20,
// //               ),
// //               const Column(
// //                 children: [
// //                   Text(
// //                     'Store ID: ${order['store_id']}',
// //                     style: TextStyle(
// //                       fontFamily: 'Cairo',
// //                       color: kPrimaryText,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   Text(
// //                     ' 1 طلبات ',
// //                     style: TextStyle(
// //                       fontFamily: 'Cairo',
// //                       color: kSecondaryText,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ],
// //           ),
// //           const Row(
// //             children: [
// //               CircleAvatar(
// //                 backgroundColor: kPrimary,
// //                 child: Icon(
// //                   Icons.phone,
// //                   color: kWhite,
// //                 ),
// //               ),
// //               CircleAvatar(
// //                 backgroundColor: kPrimary,
// //                 child: Icon(
// //                   Icons.location_pin,
// //                   color: kWhite,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const Divider(),
// //           const Text(
// //             '• رقم الرحلة : ',
// //             style: TextStyle(
// //               fontFamily: 'Cairo',
// //               fontSize: 14,
// //             ),
// //           ),
// //           const Text(
// //             '• تاريخ إنشاء الرحلة: ',
// //             style: TextStyle(
// //               fontFamily: 'Cairo',
// //               fontSize: 14,
// //             ),
// //           ),
// //           const Text(
// //             '• الحالة : ',
// //             style: TextStyle(
// //               fontFamily: 'Cairo',
// //               fontSize: 14,
// //             ),
// //           ),
// //           const Text(
// //             '• طريقة الدفع : ',
// //             style: TextStyle(
// //               fontFamily: 'Cairo',
// //               fontSize: 14,
// //             ),
// //           ),
// //           ElevatedButton(
// //               child: const Text('dddddd'),
// //               onPressed: () {
// //                 _acceptOrder(order.id);
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                     builder: (context) =>
// //                         RiderOrderDetailsScreen(orderId: order.id)));
// //               })
// //         ],
// //       ),
// //     );
// //   }
// // }

