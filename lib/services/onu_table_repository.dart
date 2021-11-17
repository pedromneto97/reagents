import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/reagent_not_found.dart';
import '../models/reagent.dart';

class OnuTableRepository {
  const OnuTableRepository._();

  static const OnuTableRepository _instance = OnuTableRepository._();

  factory OnuTableRepository() {
    return _instance;
  }

  CollectionReference<Reagent> get collection =>
      FirebaseFirestore.instance.collection('onu_table').withConverter<Reagent>(
            fromFirestore: (snapshot, _) => Reagent.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson(),
          );

  GetOptions get fromCacheOptions => const GetOptions(source: Source.cache);
  GetOptions get fromServerOptions => const GetOptions(source: Source.server);

  Future<Reagent> find({
    required String riskNumber,
    required int onuNumber,
  }) async {
    final query = collection.where(
      'numberONU',
      isEqualTo: onuNumber,
    );

    if (riskNumber.isNotEmpty) {
      query.where(
        'riskNumber',
        isEqualTo: riskNumber,
      );
    }

    final data = await query.get(fromCacheOptions);

    if (data.size == 0) {
      throw const ReagentNotFound();
    }

    return data.docs.first.data();
  }

  Future<List<Reagent>> get({
    bool fromCache = true,
  }) async {
    final data = await collection.get(
      fromCache ? fromCacheOptions : fromServerOptions,
    );
    return data.docs.map((e) => e.data()).toList(growable: false);
  }
}
