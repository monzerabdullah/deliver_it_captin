import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';
import '../models/rider_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _riders =
      FirebaseFirestore.instance.collection('riders');

  Stream<QuerySnapshot<Map<String, dynamic>>> readyToStartOrders(
      String riderId) {
    return _firestore
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .where('status', isEqualTo: 'ready_to_start')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allOrders(String riderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .snapshots();
  }

  Stream<QuerySnapshot> activeOrders() {
    return FirebaseFirestore.instance.collection('orders').where(
      'status',
      whereIn: [
        'pending',
        'accepted',
      ],
    ).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> acceptedOrders(String riderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> canceldOrders(String riderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .where('status', isEqualTo: 'canceled')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> deliveredOrders(String riderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .where('status', isEqualTo: 'delivered')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> deliveringOrders(String riderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('rider_id', isEqualTo: riderId)
        .where('status', isEqualTo: 'delivering')
        .snapshots();
  }

  Future<void> confirmTrip(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'delivering',
    });
  }

  Future<void> cancelOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'canceled',
    });
  }

  Future<void> deliverdOrder(String ordeId) async {
    _firestore.collection('orders').doc(ordeId).update({
      'status': 'delivered',
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderWithId(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots();
  }

  void acceptOrder({required String orderId, required String riderId}) async {
    var riderDoc = await _riders.doc(riderId).get();
    var riderData = riderDoc.data() as Map;

    await _firestore.collection('orders').doc(orderId).update({
      'rider_id': riderId,
      'status': 'accepted',
      'visibility': 'accepted_only',
      'rider_name': riderData['name'],
      'rider_avatar': riderData['avatarImgUrl'],
      'rider_phone': riderData['phoneNumber']
    });

    // if (!riderDoc.exists) {
    //   print('Store document does not exist');
    //   return;
    // }
  }

  void arrivedAtStore(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'pickup_location': 'pickup location address',
      'delivery_location': 'delivery location address',
      'receipt_image': 'url_to_receipt_image',
    });
  }

  void readyToStart(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'ready_to_start',
    });
  }

  Future createRider(Rider rider) async {
    try {
      await _riders.doc(rider.id).set(rider.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getRider(String riderId) async {
    try {
      var rider = await _riders.doc(riderId).get();
      return Rider.fromFirestore(rider);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<OrderModel>> getOrders(String storeId) {
    return _firestore
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Stream<List<Rider>> getRiders() {
    return _firestore.collection('riders').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Rider.fromFirestore(doc)).toList());
  }

  Future<void> createOrder(User? user) async {
    if (user != null) {
      await _firestore.collection('orders').add({
        'store_id': user.uid,
        'rider_id': null,
        'status': 'pending',
        'order_details': '',
        'created_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }

  Future<void> updateRiderStatus(String riderId, String status) async {
    await _firestore
        .collection('riders')
        .doc(riderId)
        .update({'status': status});
  }

  Future<void> updateRiderShift(
      String riderId, DateTime shiftStart, DateTime? shiftEnd) async {
    await _firestore.collection('riders').doc(riderId).update({
      'shift_start': Timestamp.fromDate(shiftStart),
      'shift_end': shiftEnd != null ? Timestamp.fromDate(shiftEnd) : null,
    });
  }
}
