import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'services/onu_table_repository.dart';
import 'theme/colors.dart';
import 'utils/my_bloc_observer.dart';

Future<void> initialize() {
  WidgetsFlutterBinding.ensureInitialized();

  final promise = Future.wait([
    _initializeFirebase(),
    _initializeHive(),
  ]);

  if (kDebugMode) Bloc.observer = MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: grey.withOpacity(0.5),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  return promise;
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    sslEnabled: true,
  );
  final repository = OnuTableRepository();
  final data = await repository.get();
  if (data.isEmpty) {
    await repository.get(fromCache: false);
  }
}

Future<void> _initializeHive() => Hive.initFlutter();
