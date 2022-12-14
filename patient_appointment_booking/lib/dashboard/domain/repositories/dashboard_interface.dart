import '../../../auth/domain/entitis/user_data.dart';
import '../entities/appontments.dart';

abstract class DashboardInterface {
  Future<String> bookAppointment(AppointmentEntity appointment);
  Stream<List<AppointmentEntity>> getActiveAppointment(String id);
  Future<void> cancelAppointment(AppointmentEntity appointment);
  Future<List<AppointmentEntity>> getAppointmentHistory(String id);
  Future<void> editProfile(UserData data);
  Future<List<String>> getBookedTimes(String date);
  Stream<UserData> fetchUser(String uid);
}
