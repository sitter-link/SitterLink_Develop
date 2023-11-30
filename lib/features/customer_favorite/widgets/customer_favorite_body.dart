import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/url_launcher.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/cards/user_card.dart';
import 'package:nanny_app/core/widgets/placeholder/user_card_placeholder.dart';
import 'package:nanny_app/core/widgets/text_fields/search_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/fetch_favorite_nannies_list_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';

class CustomerFavoriteBody extends StatefulWidget {
  const CustomerFavoriteBody({super.key});

  @override
  State<CustomerFavoriteBody> createState() => _CustomerFavoriteBodyState();
}

class _CustomerFavoriteBodyState extends State<CustomerFavoriteBody> {
  final TextEditingController searchController = TextEditingController();
  String lastParam = "";

  serachName() {
    if (lastParam != searchController.text) {
      lastParam = searchController.text;
      context
          .read<FetchFavoriteNanniesCubit>()
          .fetchFavoriteList(fullName: searchController.text);
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Favorites",
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding,
              vertical: 8.hp,
            ),
            child: SearchtextField(
              controller: searchController,
              hintText: "Search with name ...",
              isFilled: true,
              onSearchPressed: () {
                serachName();
              },
            ),
          ),
          BlocListenerWrapper<AddToFavouriteCubit>(
            listener: (context, state) {
              if (state is CommonSuccessState) {
                return SnackBarUtils.showSuccessMessage(
                  context: context,
                  message: "Nanny Favorite Successfully",
                );
              }
            },
            child: BlocListenerWrapper<RemoveFromFavouriteCubit>(
              listener: (context, state) {
                if (state is CommonSuccessState) {
                  return SnackBarUtils.showSuccessMessage(
                    context: context,
                    message: "Nanny Unfavorite Successfully",
                  );
                }
              },
              child: Expanded(
                child: BlocBuilderWrapper<FetchFavoriteNanniesCubit>(
                  loadingWidget: const SingleChildScrollView(
                    child: UserCardPlaceHolderList(),
                  ),
                  builder: (context, state) {
                    if (state is CommonSuccessState<List<Nanny>>) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomTheme.horizontalPadding),
                        itemBuilder: (context, index) {
                          return UserCard(
                            chipItems: state.data[index].commitmentType
                                .map((e) => e.name)
                                .toList(),
                            noOfExperience: state.data[index].noOfExperience,
                            country: state.data[index].country,
                            amountPerHrs:
                                state.data[index].pricePerHrs.toString(),
                            name: state.data[index].name,
                            age: state.data[index].age?.toInt(),
                            image: state.data[index].avatar,
                            city: state.data[index].address,
                            rating: state.data[index].rating,
                            isFavorite: state.data[index].isFavorite,
                            onPressed: () {
                              NavigationService.pushNamed(
                                routeName: Routes.nannyDetails,
                                args: state.data[index].id,
                              );
                            },
                            favouriteOnTap: () {
                              if (state.data[index].isFavorite) {
                                context
                                    .read<RemoveFromFavouriteCubit>()
                                    .unfavourite(state.data[index].id);
                              } else {
                                context
                                    .read<AddToFavouriteCubit>()
                                    .favorite(state.data[index].id);
                              }
                            },
                            bottomSection: Row(
                              children: [
                                Expanded(
                                  child: CustomRoundedButtom(
                                    title: "Send Message",
                                    prefixIcon: NannyIcon.directRight,
                                    onPressed: () {
                                      UrlLauncher.launchSMS(
                                        context: context,
                                        phone: state.data[index].phoneNUmber,
                                      );
                                    },
                                    iconSize: 18,
                                    fontSize: 15,
                                    color: CustomTheme.backgroundColor,
                                    textColor: CustomTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                CustomIconButton(
                                  icon: NannyIcon.call,
                                  borderRadius: 8,
                                  padding: 13.5,
                                  iconSize: 22,
                                  iconColor: Colors.white,
                                  backgroundColor: CustomTheme.primaryColor,
                                  onPressed: () {
                                    UrlLauncher.launchPhone(
                                      context: context,
                                      phone: state.data[index].phoneNUmber,
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: state.data.length,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
