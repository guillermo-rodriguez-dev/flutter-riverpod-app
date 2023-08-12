




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';


final simpleNameProvieer = Provider.autoDispose<String>((ref) => RandomGenerator.getRandomName());