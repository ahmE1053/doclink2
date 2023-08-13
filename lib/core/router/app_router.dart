import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../exports/screens_exports.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  final String? _launchFromNotificationChatId;
  AppRouter(String? chatId) : _launchFromNotificationChatId = chatId;
  String? get launchChatId => _launchFromNotificationChatId;
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: '/splash',
          page: SplashRoute.page,
        ),
        AutoRoute(
          path: '/home',
          page: MainRoute.page,
          children: [
            AutoRoute(
              path: '',
              children: [
                AutoRoute(
                  path: '',
                  page: NestedHomeRoute.page,
                ),
                AutoRoute(
                  path: 'speciality/:name',
                  page: SpecialtyRoute.page,
                ),
                AutoRoute(
                  path: 'doctors',
                  page: DoctorsRoute.page,
                ),
                AutoRoute(
                  path: 'search/:search',
                  page: SearchRoute.page,
                ),
                AutoRoute(
                  path: 'specialities',
                  page: SpecialitiesRoute.page,
                ),
                AutoRoute(
                  path: 'favorites',
                  page: FavoriteDoctorsRoute.page,
                ),
                AutoRoute(
                  path: 'doctors/:id',
                  page: DoctorInfoRoute.page,
                ),
                AutoRoute(
                  path: 'appointment/:id',
                  page: BookAppointmentRoute.page,
                ),
                AutoRoute(
                  path: 'appointmentSuccess',
                  page: BookAppointmentSuccessRoute.page,
                ),
              ],
              page: MainHomeRoute.page,
            ),
            AutoRoute(
              path: 'profile',
              page: ProfileRoute.page,
            ),
            AutoRoute(
              path: 'appointments',
              page: AppointmentsRoute.page,
            ),
            AutoRoute(
              path: 'messages',
              page: MessagesRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: NestedMessagesRoute.page,
                ),
                AutoRoute(
                  path: ':chat_id',
                  page: ChatRoute.page,
                ),
              ],
            ),
          ],
        ),
        AutoRoute(
          path: '/home/messages/incoming_call',
          page: ReceivedCallRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/ongoing_call',
          page: OngoingCallRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/calling',
          page: CallingRoute.page,
        ),
        AutoRoute(
          path: '/auth',
          page: AuthBackgroundRoute.page,
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'signin',
            ),
            AutoRoute(
              path: 'signin',
              page: SigninRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              path: 'signup',
              page: SignupRoute.page,
              maintainState: false,
            ),
          ],
        ),
      ];

  // @override
  // void onNavigation(NavigationResolver resolver, StackRouter router) {
  //   if (FirebaseAuth.instance.currentUser != null ||
  //       resolver.route.name == AuthBackgroundRoute.name) {
  //     resolver.next();
  //   } else {
  //     resolver.redirect(
  //       const AuthBackgroundRoute(),
  //     );
  //   }
  // }
}
