// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthBackgroundRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthBackgroundScreen(),
      );
    },
    SigninRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SigninScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignupScreen(),
      );
    },
    BookAppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<BookAppointmentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookAppointmentScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    BookAppointmentSuccessRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookAppointmentSuccessScreen(),
      );
    },
    DoctorsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorsScreen(),
      );
    },
    DoctorInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DoctorInfoRouteArgs>(
          orElse: () => DoctorInfoRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoctorInfoScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FavoriteDoctorsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteDoctorsScreen(),
      );
    },
    NestedHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NestedHomeScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () =>
              SearchRouteArgs(searchText: pathParams.getString('search')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchScreen(
          key: args.key,
          searchText: args.searchText,
        ),
      );
    },
    SpecialitiesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SpecialitiesScreen(),
      );
    },
    SpecialtyRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SpecialtyRouteArgs>(
          orElse: () =>
              SpecialtyRouteArgs(specialtyName: pathParams.getString('name')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SpecialtyScreen(
          key: args.key,
          specialtyName: args.specialtyName,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    AppointmentsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppointmentsScreen(),
      );
    },
    MainHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainHomeScreen(),
      );
    },
    MessagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagesScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    CallingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CallingScreen(),
      );
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () => ChatRouteArgs(chatId: pathParams.optString('chat_id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatScreen(
          chatId: args.chatId,
          key: args.key,
        ),
      );
    },
    ReceivedCallRoute.name: (routeData) {
      final args = routeData.argsAs<ReceivedCallRouteArgs>(
          orElse: () => const ReceivedCallRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReceivedCallScreen(
          key: args.key,
          isVideo: args.isVideo,
        ),
      );
    },
    NestedMessagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NestedMessagesScreen(),
      );
    },
    OngoingCallRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OngoingCallScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AuthBackgroundScreen]
class AuthBackgroundRoute extends PageRouteInfo<void> {
  const AuthBackgroundRoute({List<PageRouteInfo>? children})
      : super(
          AuthBackgroundRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthBackgroundRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SigninScreen]
class SigninRoute extends PageRouteInfo<void> {
  const SigninRoute({List<PageRouteInfo>? children})
      : super(
          SigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookAppointmentScreen]
class BookAppointmentRoute extends PageRouteInfo<BookAppointmentRouteArgs> {
  BookAppointmentRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          BookAppointmentRoute.name,
          args: BookAppointmentRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'BookAppointmentRoute';

  static const PageInfo<BookAppointmentRouteArgs> page =
      PageInfo<BookAppointmentRouteArgs>(name);
}

class BookAppointmentRouteArgs {
  const BookAppointmentRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'BookAppointmentRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [BookAppointmentSuccessScreen]
class BookAppointmentSuccessRoute extends PageRouteInfo<void> {
  const BookAppointmentSuccessRoute({List<PageRouteInfo>? children})
      : super(
          BookAppointmentSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookAppointmentSuccessRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorsScreen]
class DoctorsRoute extends PageRouteInfo<void> {
  const DoctorsRoute({List<PageRouteInfo>? children})
      : super(
          DoctorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorInfoScreen]
class DoctorInfoRoute extends PageRouteInfo<DoctorInfoRouteArgs> {
  DoctorInfoRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          DoctorInfoRoute.name,
          args: DoctorInfoRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'DoctorInfoRoute';

  static const PageInfo<DoctorInfoRouteArgs> page =
      PageInfo<DoctorInfoRouteArgs>(name);
}

class DoctorInfoRouteArgs {
  const DoctorInfoRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'DoctorInfoRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [FavoriteDoctorsScreen]
class FavoriteDoctorsRoute extends PageRouteInfo<void> {
  const FavoriteDoctorsRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteDoctorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteDoctorsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NestedHomeScreen]
class NestedHomeRoute extends PageRouteInfo<void> {
  const NestedHomeRoute({List<PageRouteInfo>? children})
      : super(
          NestedHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NestedHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    required String searchText,
    List<PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            searchText: searchText,
          ),
          rawPathParams: {'search': searchText},
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<SearchRouteArgs> page = PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.searchText,
  });

  final Key? key;

  final String searchText;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, searchText: $searchText}';
  }
}

/// generated route for
/// [SpecialitiesScreen]
class SpecialitiesRoute extends PageRouteInfo<void> {
  const SpecialitiesRoute({List<PageRouteInfo>? children})
      : super(
          SpecialitiesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SpecialitiesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SpecialtyScreen]
class SpecialtyRoute extends PageRouteInfo<SpecialtyRouteArgs> {
  SpecialtyRoute({
    Key? key,
    required String specialtyName,
    List<PageRouteInfo>? children,
  }) : super(
          SpecialtyRoute.name,
          args: SpecialtyRouteArgs(
            key: key,
            specialtyName: specialtyName,
          ),
          rawPathParams: {'name': specialtyName},
          initialChildren: children,
        );

  static const String name = 'SpecialtyRoute';

  static const PageInfo<SpecialtyRouteArgs> page =
      PageInfo<SpecialtyRouteArgs>(name);
}

class SpecialtyRouteArgs {
  const SpecialtyRouteArgs({
    this.key,
    required this.specialtyName,
  });

  final Key? key;

  final String specialtyName;

  @override
  String toString() {
    return 'SpecialtyRouteArgs{key: $key, specialtyName: $specialtyName}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppointmentsScreen]
class AppointmentsRoute extends PageRouteInfo<void> {
  const AppointmentsRoute({List<PageRouteInfo>? children})
      : super(
          AppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainHomeScreen]
class MainHomeRoute extends PageRouteInfo<void> {
  const MainHomeRoute({List<PageRouteInfo>? children})
      : super(
          MainHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagesScreen]
class MessagesRoute extends PageRouteInfo<void> {
  const MessagesRoute({List<PageRouteInfo>? children})
      : super(
          MessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CallingScreen]
class CallingRoute extends PageRouteInfo<void> {
  const CallingRoute({List<PageRouteInfo>? children})
      : super(
          CallingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    String? chatId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            chatId: chatId,
            key: key,
          ),
          rawPathParams: {'chat_id': chatId},
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<ChatRouteArgs> page = PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.chatId,
    this.key,
  });

  final String? chatId;

  final Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{chatId: $chatId, key: $key}';
  }
}

/// generated route for
/// [ReceivedCallScreen]
class ReceivedCallRoute extends PageRouteInfo<ReceivedCallRouteArgs> {
  ReceivedCallRoute({
    Key? key,
    bool? isVideo,
    List<PageRouteInfo>? children,
  }) : super(
          ReceivedCallRoute.name,
          args: ReceivedCallRouteArgs(
            key: key,
            isVideo: isVideo,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceivedCallRoute';

  static const PageInfo<ReceivedCallRouteArgs> page =
      PageInfo<ReceivedCallRouteArgs>(name);
}

class ReceivedCallRouteArgs {
  const ReceivedCallRouteArgs({
    this.key,
    this.isVideo,
  });

  final Key? key;

  final bool? isVideo;

  @override
  String toString() {
    return 'ReceivedCallRouteArgs{key: $key, isVideo: $isVideo}';
  }
}

/// generated route for
/// [NestedMessagesScreen]
class NestedMessagesRoute extends PageRouteInfo<void> {
  const NestedMessagesRoute({List<PageRouteInfo>? children})
      : super(
          NestedMessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'NestedMessagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OngoingCallScreen]
class OngoingCallRoute extends PageRouteInfo<void> {
  const OngoingCallRoute({List<PageRouteInfo>? children})
      : super(
          OngoingCallRoute.name,
          initialChildren: children,
        );

  static const String name = 'OngoingCallRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
