import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/language_provider.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/messages_screen_related/call_related/incoming_call_response_row.dart';
import '../../widgets/messages_screen_related/call_related/incoming_caller_info.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class ReceivedCallScreen extends HookConsumerWidget {
  const ReceivedCallScreen({super.key, this.isVideo});
  final bool? isVideo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final incomingCallTextOpacity = useState(1.0);
    return Scaffold(body: Builder(
      builder: (context) {
        final callState =
            ref.read(patientRemoteDataSourceProvider).value!.callState;
        if (callState == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final doctor = ref
            .read(doctorsNotifierProvider.notifier)
            .getDoctorById(callState.doctorId);
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: doctor.imageUrl,
                fit: BoxFit.fill,
                errorWidget: (_, __, ___) => Image.asset(
                  'assets/images/profile-pic.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 10,
                  sigmaX: 10,
                ),
                child: Container(
                  color: Colors.black38,
                ),
              ),
            ),
            CallerInfoWidget(
              isCalling: false,
              doctor: doctor,
              opacity: incomingCallTextOpacity.value,
            ),
            const IncomingCallResponseRowWidget(),
          ],
        );
      },
    )).getDoctorAndPatientInfo(ref);
  }
}

// TODO: check this effect later
// class DoubleCircleEffect extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.3)
//       ..style = PaintingStyle.fill;
//     canvas.drawCircle(
//       Offset(
//         size.height / 2,
//         size.width / 2,
//       ),
//       120,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
