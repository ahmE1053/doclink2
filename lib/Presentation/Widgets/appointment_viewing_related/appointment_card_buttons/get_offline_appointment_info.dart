import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetOfflineAppointmentInfoButton extends ConsumerWidget {
  const GetOfflineAppointmentInfoButton({
    Key? key,
    required this.appointmentId,
  }) : super(key: key);
  final String appointmentId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
