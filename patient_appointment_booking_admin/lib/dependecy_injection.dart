import 'package:get_it/get_it.dart';

import 'auth/auth_di.dart' as auth;
import 'dashboard/dashboard_di.dart' as dashboard;

final sl = GetIt.instance;

void init() {
  auth.init();
  dashboard.init();
}
