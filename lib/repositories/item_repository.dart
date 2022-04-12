import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moja_apka/model/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('goal')
        .orderBy('end_date')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return ItemModel(
              id: doc.id,
              title: doc['title'],
              imageURL: doc['image_url'],
              aim: doc['aim'],
              endDate: (doc['end_date'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> remove({required String id}) {
    return FirebaseFirestore.instance.collection('goal').doc(id).delete();
  }

  Future<void> add(
    String title,
    String aim,
    String imageURL,
    DateTime endDate,
  ) async {
    await FirebaseFirestore.instance.collection('goal').add(
      {
        'title': title,
        'aim': aim,
        'image_url': imageURL,
        'end_date': endDate,
      },
    );
  }
}
