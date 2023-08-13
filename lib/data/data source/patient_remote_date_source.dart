import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink3/domain/entities/chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/router/app_router.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/utilities/agora_rtc_engine.dart';
import '../../domain/entities/call_state.dart';
import '../../domain/entities/patient.dart';

/*
* holds the state of the current user
* return a null state if the user is not signed in and return the
* user info in the form of a patient class by using the id of the firebase auth user
* and get the related info of this id from firestore
* */

class PatientRemoteDataSource extends AsyncNotifier<Patient?> {
  bool isInCall = false;

  @override
  Future<Patient?> build() async {
    final user = ref.watch(authenticationProvider);
    if (user != null) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final patientRef =
          FirebaseFirestore.instance.collection('patients').doc(user.uid);
      await patientRef.update({'fcmToken': fcmToken});
      final patientSnapshot = await patientRef.get();
      final patient = Patient.fromJson(patientSnapshot.data()!);
      listenToCallStateChanges();
      return patient;
    } else {
      return null;
    }
  }

  /*
  * handles adding or removing a favorite doctor from the user list
  * */

  Future<void> handleFavorite(String doctorId) async {
    final patient = state.value!;
    final List<String> favoriteDoctors = List.from(patient.favoriteDoctors);
    final firestoreRef = FirebaseFirestore.instance.collection('patients').doc(
          patient.id,
        );
    if (favoriteDoctors.contains(doctorId)) {
      favoriteDoctors.remove(doctorId);
    } else {
      favoriteDoctors.add(doctorId);
    }
    await firestoreRef.update(
      {'favoriteDoctors': favoriteDoctors},
    );
    state = AsyncData(
      patient.copyWith(
        favoriteDoctors: favoriteDoctors,
      ),
    );
  }

  void copyWith(Patient patient) {
    state = AsyncValue.data(patient);
  }

  ChatInfo getChatInfoFromId(String id) {
    return state.value!.chatList.where((element) => element.chatId == id).first;
  }

  Future<void> startCall(
      String channelName, String patientId, String doctorId) async {
    final callState = CallState(
      patientId: patientId,
      doctorId: doctorId,
      channelName: channelName,
      callStates: CallStates.calling,
    );
    final patient = state.value!.copyWith(
      callState: callState,
    );
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(state.value!.id)
        .update(
          patient.toJson(),
        );
    state = AsyncData(patient);
  }

  Future<void> answerCall() async {
    final patient = state.value!.copyWith(
      callState: state.value!.callState!.copyWith(
        callStates: CallStates.ongoingCall,
      ),
    );
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(state.value!.id)
        .update(
          patient.toJson(),
        );
    state = AsyncData(patient);
  }

  Future<void> endCall() async {
    final patient = state.value!.copyWith(
      callState: CallState.nullState(),
    );
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(state.value!.id)
        .update(
          patient.toJson(),
        );
    state = AsyncData(patient);
  }

  StreamSubscription listenToCallStateChanges() {
    final id = ref.read(authenticationProvider)!.uid;
    return FirebaseFirestore.instance
        .collection('patients')
        .doc(id)
        .snapshots()
        .map((event) => Patient.fromJson(event.data()!))
        .listen(
      (event) async {
        final callState = event.callState;
        if (callState == null) return;
        while (GetIt.I.get<AppRouter>().currentSegments.last.name ==
            SplashRoute.name) {
          await Future.delayed(
            const Duration(seconds: 1),
          );
        }
        switch (callState.callStates) {
          case (CallStates.incomingCall):
            {
              isInCall = true;
              state = AsyncData(event);
              if (GetIt.I.get<AppRouter>().currentPath.contains('incoming')) {
                return;
              }
              GetIt.I.get<AppRouter>().push(
                    ReceivedCallRoute(),
                  );
              break;
            }
          case CallStates.ongoingCall:
            {
              isInCall = true;
              if (!ref.read(agoraEngineProvider.notifier).isJoined) {
                if (GetIt.I.get<AppRouter>().currentPath.contains('ongoing')) {
                  return;
                }
                GetIt.I.get<AppRouter>().replace(const OngoingCallRoute());
                await ref.read(agoraEngineProvider.notifier).initializeEngine();
                await ref.read(agoraEngineProvider.notifier).join(
                      callState.token,
                      callState.channelName,
                      callState.patientId.hashCode,
                    );
              }
              state = AsyncData(event);
              break;
            }
          case CallStates.calling:
            {
              isInCall = true;
              state = AsyncData(event);
              if (GetIt.I.get<AppRouter>().currentPath.contains('calling')) {
                return;
              }
              GetIt.I.get<AppRouter>().push(const CallingRoute());
              break;
            }
          case CallStates.nothing:
            {
              if (isInCall) {
                if (GetIt.I.get<AppRouter>().currentPath.contains('call')) {
                  GetIt.I.get<AppRouter>().pop();
                }
                await ref.read(agoraEngineProvider.notifier).leave();
                isInCall = false;
                state = AsyncData(event);
                break;
              }
            }
        }
      },
    );
  }
}

final patientRemoteDataSourceProvider =
    AsyncNotifierProvider<PatientRemoteDataSource, Patient?>(
        () => PatientRemoteDataSource());
