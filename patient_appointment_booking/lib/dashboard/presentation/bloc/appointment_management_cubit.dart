import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/appontments.dart';
import '../../domain/usecases/active_appointments.dart';
import '../../domain/usecases/cancel_appointment.dart';

class AppointmentState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentEntity> appoinments;

  AppointmentLoaded(this.appoinments);

  @override
  List<Object?> get props => [appoinments.length];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentFailed extends AppointmentState {}

class AppointmentManagementCubit extends Cubit<AppointmentState> {
  AppointmentManagementCubit(
      {required ActiveAppointmentUsecase activeAppointmentUsecase,
      required CancelAppointmentUsecase cancelAppointmentUsecase})
      : _activeAppointmentUsecase = activeAppointmentUsecase,
        _cancelAppointmentUsecase = cancelAppointmentUsecase,
        super(AppointmentInitial());

  final ActiveAppointmentUsecase _activeAppointmentUsecase;
  final CancelAppointmentUsecase _cancelAppointmentUsecase;

  Future<void> getAppointments(String id) async {
    try {
      emit(AppointmentLoading());
      final appointments = _activeAppointmentUsecase(id);
      appointments.listen((event) {
        event.sort((a, b) {
          int cmp = a.date.compareTo(b.date);
          if (cmp != 0) {
            return cmp;
          }
          return a.time.compareTo(b.time);
        });
        emit(AppointmentLoaded(event));
      });
    } catch (_) {
      emit(AppointmentFailed());
    }
  }

  Future<void> cancelAppointment(AppointmentEntity appointment) async {
    try {
      emit(AppointmentLoading());
      await _cancelAppointmentUsecase(appointment);
    } catch (_) {
      emit(AppointmentFailed());
    }
  }
}
