import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/doctor.dart';
import '../utilities/specialties_map.dart';

/*
* these are some state providers that holds the state of the some text fields, search results, etc.
* their function is to hold the state when the user navigates between the main sections of the app
* */

final specialtiesSearchResults = StateProvider((ref) => specialties);

final doctorSearchResults = StateProvider((ref) => <Doctor>[]);
