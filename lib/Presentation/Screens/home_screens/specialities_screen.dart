import 'package:auto_route/annotations.dart';
import 'package:doclink3/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/state_providers.dart';
import '../../../core/utilities/search_functions.dart';
import '../../Widgets/home_screen_related/specialty_card.dart';
import '../../widgets/home_screen_related/not_found.dart';
import '../../widgets/search_text_field.dart';

@RoutePage()
class SpecialitiesScreen extends HookConsumerWidget {
  const SpecialitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final colorScheme = Theme.of(context).colorScheme;
    final didSearch = useState(false);
    final mq = MediaQuery.of(context).size;
    final specialties = ref.watch(specialtiesSearchResults);
    final formKey = useState(GlobalKey<FormState>());
    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(specialtiesSearchResults);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Specialities',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.invalidate(specialtiesSearchResults);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.075,
                child: SearchTextField(
                  closeSuffixButton: didSearch.value,
                  controller: searchController,
                  colorScheme: colorScheme,
                  formKey: formKey.value,
                  closeFunction: () {
                    didSearch.value = false;
                    searchController.clear();
                    ref.invalidate(specialtiesSearchResults);
                  },
                  ref: ref,
                  searchFunction: () {
                    didSearch.value = true;
                    searchForSpecialties(
                      ref,
                      searchController,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: specialties.isEmpty
                    ? NotFound(
                        text: LocaleKeys.noSearchResults.tr(),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: specialties.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                          mainAxisExtent: mq.height * 0.15,
                        ),
                        itemBuilder: (context, index) {
                          return SpecialityCard(
                            specialty: specialties[index],
                            colorIndex: index,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
