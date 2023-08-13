import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/state_providers.dart';
import '../../../core/utilities/search_functions.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/home_screen_related/normal_doctor_card.dart';
import '../../widgets/home_screen_related/not_found.dart';
import '../../widgets/search_text_field.dart';

@RoutePage()
class SearchScreen extends HookConsumerWidget {
  const SearchScreen({
    Key? key,
    @PathParam('search') required this.searchText,
  }) : super(key: key);

  final String searchText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController(text: searchText);
    final results = ref.watch(doctorSearchResults);
    final patient =
        ref.watch(patientRemoteDataSourceProvider).unwrapPrevious().value!;
    final colorScheme = Theme.of(context).colorScheme;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          ref.invalidate(doctorSearchResults);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search Results',
            ),
            leading: IconButton(
              onPressed: () {
                ref.invalidate(doctorSearchResults);
                context.popRoute();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchTextField(
                  closeSuffixButton: true,
                  controller: searchController,
                  colorScheme: colorScheme,
                  closeFunction: () {
                    ref.invalidate(doctorSearchResults);
                    context.popRoute();
                  },
                  searchFunction: () {
                    searchForDoctors(ref, searchController);
                  },
                  ref: ref,
                  formKey: formKey,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: results.isEmpty
                      ? NotFound(
                          text: LocaleKeys.noSearchResults.tr(),
                        )
                      : ListView.builder(
                          itemCount: results.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final doctor = results[index];
                            final isFav = patient.favoriteDoctors.contains(
                              doctor.id,
                            );
                            return NormalDoctorCard(
                              doctor: doctor,
                              isFav: isFav,
                              colorScheme: colorScheme,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
