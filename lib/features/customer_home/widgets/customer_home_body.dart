import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/rounded_image.dart';
import 'package:nanny_app/core/model/city.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:animations/animations.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/url_launcher.dart';
import 'package:nanny_app/core/widgets/ads_container.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/cards/user_card.dart';
import 'package:nanny_app/core/widgets/placeholder/user_card_placeholder.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/core/widgets/text_fields/search_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_city_cubit.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/cubit/search_nannies_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/dashboard/presentation/pages/filter_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CustomerHomeBody extends StatefulWidget {
  final NannyFilterParam param;
  const CustomerHomeBody({super.key, required this.param});

  @override
  State<CustomerHomeBody> createState() => _CustomerHomeBodyState();
}

class _CustomerHomeBodyState extends State<CustomerHomeBody> {
  late UserRepository userRepo;
  TextEditingController searchController = TextEditingController();
  User? user;
  late NannyFilterParam currentFilter;

  @override
  void initState() {
    super.initState();
    currentFilter = widget.param;
    initialize();
    context.read<FetchCityCubit>().fetchCity();
  }

  initialize() async {
    userRepo = context.read<UserRepository>();
    user = userRepo.user.value;

    userRepo.user.addListener(updateUser);
  }

  updateUser() {
    if (mounted) {
      setState(() {
        user = userRepo.user.value;
      });
    }
  }

  searchByName(String name) {
    currentFilter = currentFilter.copyWith(query: name);
    context.read<SearchNanniesCubit>().search(currentFilter);
  }

  @override
  void dispose() {
    userRepo.user.removeListener(updateUser);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: CustomAppBar(
        title: "Hi, ${user?.fullName ?? "Guest"}",
        leadingIcon: InkWell(
          onTap: () {},
          child: CustomRoundedImage(
            url: user?.avatar ?? "",
            height: 38.wp,
            width: 38.wp,
          ),
        ),
        actions: [
          CustomIconButton(
            icon: NannyIcon.notification,
            iconColor: CustomTheme.grey.shade400,
            borderColor: CustomTheme.grey.shade300,
            padding: 9,
            iconSize: 23,
            onPressed: () {
              NavigationService.pushNamed(routeName: Routes.notification);
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                listTileTheme: ListTileTheme.of(context).copyWith(
                  dense: true,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.horizontalPadding,
                  vertical: 12.hp,
                ),
                color: CustomTheme.secondaryColor,
                child: Row(
                  children: [
                    Text(
                      "Looking from",
                      style: appTextTheme.bodyMedium.copyWith(
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilderWrapper<FetchCityCubit>(
                      builder: (context, state) {
                        if (state is CommonSuccessState<List<City>>) {
                          return PopupMenuButton(
                            itemBuilder: (context) {
                              return state.data
                                  .map((e) => PopupMenuItem(
                                        value: e.shortName,
                                        child: Text(e.name),
                                      ))
                                  .toList();
                            },
                            initialValue: currentFilter.city,
                            onSelected: (value) {
                              currentFilter =
                                  currentFilter.copyWith(city: value);
                              setState(() {});
                              context
                                  .read<SearchNanniesCubit>()
                                  .search(currentFilter);
                            },
                            child: Row(
                              children: [
                                Text(
                                  state.data
                                          .findCityWith(currentFilter.city)
                                          ?.name ??
                                      "Select City",
                                  style: appTextTheme.bodySmallMedium,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF292D32),
                                  size: 24,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Text("No Available");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverSizedBox(height: 16.hp),
          const SliverToBoxAdapter(child: AdsWidget()),
          SliverSizedBox(height: 16.hp),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: CustomTheme.cardPadding),
            sliver: MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SearchtextField(
                          controller: searchController,
                          hintText: "Search with name ...",
                          onSearchPressed: () {
                            if (currentFilter.query != searchController.text) {
                              searchByName(searchController.text);
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      OpenContainer(
                        openBuilder: (_, action) {
                          return FilterView(
                            initialFilter: currentFilter,
                            onSearched: (value) {
                              searchController.clear();
                              currentFilter = value;
                              context.read<SearchNanniesCubit>().search(value);
                            },
                          );
                        },
                        openElevation: 0,
                        closedElevation: 0,
                        closedBuilder: (context, action) {
                          return CustomIconButton(
                            icon: NannyIcon.sliders,
                            borderRadius: 8,
                            padding: 11.5,
                            onPressed: action,
                            iconColor: Colors.white,
                            backgroundColor: CustomTheme.primaryColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverSizedBox(height: 16.hp),
                BlocSelector<SearchNanniesCubit, CommonState, int?>(
                  selector: (state) {
                    if (state is CommonSuccessState<List<Nanny>>) {
                      return state.data.length;
                    } else {
                      return null;
                    }
                  },
                  builder: (context, state) {
                    if (state != null) {
                      return SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 16.hp),
                          child: Text(
                            "$state results found",
                            style: appTextTheme.bodyMedium,
                          ),
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter();
                    }
                  },
                ),
                BlocListenerWrapper<AddToFavouriteCubit>(
                  listener: (context, state) {
                    if (state is CommonSuccessState) {
                      SnackBarUtils.showSuccessMessage(
                        context: context,
                        message: "Nanny Favorite Successfully",
                      );
                    }
                  },
                  child: BlocListenerWrapper<RemoveFromFavouriteCubit>(
                    listener: (context, state) {
                      if (state is CommonSuccessState) {
                        SnackBarUtils.showSuccessMessage(
                          context: context,
                          message: "Nanny Unfavorite Successfully",
                        );
                      }
                    },
                    child: BlocBuilderWrapper<SearchNanniesCubit>(
                      useSliver: true,
                      loadingWidget: const SliverUserCardPlaceHolderList(horizontalPadding: 0),
                      builder: (context, state) {
                        if (state is CommonSuccessState<List<Nanny>>) {
                          return SliverList.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return UserCard(
                                chipItems: state.data[index].commitmentType
                                    .map((e) => e.name)
                                    .toList(),
                                noOfExperience:
                                    state.data[index].noOfExperience,
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
                                            phone:
                                                state.data[index].phoneNUmber,
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
                          );
                        } else {
                          return const SliverToBoxAdapter();
                        }
                      },
                    ),
                  ),
                ),
                SliverSizedBox(height: context.bottomViewPadding + 20.hp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
