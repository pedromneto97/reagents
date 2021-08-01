import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/reagent_not_found.dart';
import '../models/reagent.dart';

class OnuTableRepository {
  const OnuTableRepository._();

  static const OnuTableRepository _instance = OnuTableRepository._();

  factory OnuTableRepository() {
    return _instance;
  }

  Future<Reagent> find({
    required String riskNumber,
    required int onuNumber,
  }) async {
    final data = await FirebaseFirestore.instance
        .collection('onu_table')
        .where(
          'numberONU',
          isEqualTo: onuNumber,
        )
        .where(
          'riskNumber',
          isEqualTo: riskNumber,
        )
        .limit(1)
        .get();

    if (data.size == 0) {
      throw const ReagentNotFound();
    }
    final reagent = data.docs.first;
    return Reagent(
      nameAndDescription: reagent['nameAndDescription'],
      unNumber: reagent['numberONU'],
      riskClass: reagent['riskClass'],
      limit: reagent['limit'],
      riskNumber: reagent['riskNumber'],
    );
  }
}
