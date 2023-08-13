import 'package:auto_route/auto_route.dart';
import 'package:doclink3/core/providers/shared_preferences_provider.dart';
import 'package:doclink3/data/data%20source/patient_remote_date_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/consts/app_typography.dart';
import '../../core/router/app_router.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientDataSource = ref.watch(patientRemoteDataSourceProvider).value;
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            if (patientDataSource == null) {
              return;
            }
            await Future.delayed(const Duration(seconds: 2));
            // final sharedPref = ref.read(sharedPreferencesProvider).value!;
            if (FirebaseAuth.instance.currentUser == null) {
              // final skippedAuth = sharedPref.getBool('skipAuth');
              // if ((skippedAuth ?? false)) {
              //   return;
              // }
              GetIt.I.get<AppRouter>().replaceNamed(
                    '/auth',
                  );
              return;
            }
            if (GetIt.I.get<AppRouter>().launchChatId == null) {
              GetIt.I.get<AppRouter>().replaceNamed(
                    '/home',
                  );
              return;
            }
            GetIt.I.get<AppRouter>().replace(
                  ChatRoute(
                    chatId: GetIt.I.get<AppRouter>().launchChatId!,
                  ),
                );
          },
        );
        return null;
      },
      [
        patientDataSource,
      ],
    );
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: mq.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Lottie.asset(
                  'assets/lottie/splash.json',
                ),
              ),
              FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * 0.0),
                  child: Text(
                    'DocLink',
                    style: AppTypography.bigHeadlineSize(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
