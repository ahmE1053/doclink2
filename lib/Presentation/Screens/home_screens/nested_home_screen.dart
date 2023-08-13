import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:doclink3/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/utilities/search_functions.dart';
import '../../../core/utilities/specialties_map.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../Widgets/home_screen_related/home_doctor_card.dart';
import '../../Widgets/home_screen_related/specialty_card.dart';
import '../../widgets/search_text_field.dart';

@RoutePage()
class NestedHomeScreen extends HookConsumerWidget {
  const NestedHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final searchTextController = useTextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    final formKey = useMemoized(() => GlobalKey<FormState>());
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // FittedBox(
                    //   child: Lottie.asset(
                    //     'assets/lottie/heart.json',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    Align(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          'DocLink',
                          style: AppTypography.semiHeadlineSize(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FittedBox(
                            child: IconButton(
                              onPressed: () async {},
                              icon: const Icon(Icons.notifications),
                            ),
                          ),
                          FittedBox(
                            child: IconButton(
                              onPressed: () {
                                context.pushRoute(
                                  const FavoriteDoctorsRoute(),
                                );
                              },
                              icon: const Icon(Icons.favorite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      height: mq.height * 0.075,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return SearchTextField(
                            closeSuffixButton: false,
                            enabled: ref.watch(doctorsNotifierProvider).value !=
                                null,
                            controller: searchTextController,
                            colorScheme: colorScheme,
                            formKey: formKey,
                            searchFunction: () {
                              searchForDoctors(ref, searchTextController);
                              context.router.push(
                                SearchRoute(
                                  searchText: searchTextController.value.text,
                                ),
                              );
                              searchTextController.text = '';
                            },
                            ref: ref,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Doctor Speciality',
                          style: AppTypography.semiHeadlineSize(context),
                        ),
                        TextButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                            context.pushRoute(
                              const SpecialitiesRoute(),
                            );
                          },
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: mq.height * 0.3,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          mainAxisExtent: mq.width * 0.3,
                        ),
                        itemBuilder: (context, index) {
                          final specialty = specialties[index];
                          return SpecialityCard(
                            specialty: specialty,
                            colorIndex: index,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Doctors',
                          style: AppTypography.semiHeadlineSize(context),
                        ),
                        TextButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                            context.pushRoute(
                              const DoctorsRoute(),
                            );
                          },
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: mq.height * 0.4,
                      child: HomeDoctorCard(mq: mq),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
