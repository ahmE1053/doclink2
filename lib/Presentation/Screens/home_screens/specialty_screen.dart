import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../domain/entities/specialties.dart';
import '../../widgets/home_screen_related/normal_doctor_card.dart';
import '../../widgets/home_screen_related/not_found.dart';

@RoutePage()
class SpecialtyScreen extends ConsumerWidget {
  const SpecialtyScreen({
    Key? key,
    @PathParam('name') required this.specialtyName,
  }) : super(key: key);
  final String specialtyName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialty = MedicalSpecialties.fromName(specialtyName);
    return Scaffold(
      appBar: AppBar(
        title: Text(specialty.simpleName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ref.watch(doctorsNotifierProvider).when(
              data: (data) {
                final doctorsList = data
                    .where(
                        (doctor) => doctor.speciality == specialty.complexName)
                    .toList();
                return doctorsList.isEmpty
                    ? const NotFound(
                        text: 'No doctors in here yet',
                      )
                    : ListView.builder(
                        itemCount: doctorsList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final doctor = doctorsList[index];
                          return NormalDoctorCard(
                            doctor: doctor,
                            isFav: ref
                                .watch(patientRemoteDataSourceProvider)
                                .value!
                                .favoriteDoctors
                                .contains(
                                  doctor.id,
                                ),
                            colorScheme: Theme.of(context).colorScheme,
                          );
                        },
                      );
              },
              error: (error, stackTrace) => const Center(
                child: Text('An error occurred, please try again later'),
              ),
              loading: () => Center(
                child: SpinKitFadingGrid(),
              ),
            ),
      ),
    );
  }
}
