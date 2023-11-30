import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/utils/url_launcher.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/others/bottom_navigation_bar_with_button.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';
import 'package:nanny_app/features/nanny_details/widgets/nanny_personal_detail_section.dart';
import 'package:nanny_app/features/nanny_details/widgets/nanny_reviews_section.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NannyDetailBody extends StatefulWidget {
  final int nannyId;
  const NannyDetailBody({super.key, required this.nannyId});

  @override
  State<NannyDetailBody> createState() => _NannyDetailBodyState();
}

class _NannyDetailBodyState extends State<NannyDetailBody> {
  Nanny? nanny;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          BlocSelector<FetchNannyDetailsCubit, CommonState, Nanny?>(
        selector: (state) {
          if (state is CommonSuccessState<Nanny>) {
            return state.data;
          } else {
            return null;
          }
        },
        builder: (context, state) {
          if (state != null) {
            return BottomNavigationbarWithButton(
              buttonLabel: "Book Now".toUpperCase(),
              buttonPrefixIcon: NannyIcon.calendar,
              prefix: RichText(
                text: TextSpan(
                  text: "\$${state.perHrsRate}",
                  style: appTextTheme.bodySemiBold.copyWith(
                    fontSize: 32,
                  ),
                  children: [
                    TextSpan(
                      text: "/hrs",
                      style: appTextTheme.bodySemiBold,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                if (state.hasBeenBooked) {
                  SnackBarUtils.showErrorMessage(
                    context: context,
                    message:
                        "Your request to book this sitter is already pending",
                  );
                } else {
                  NavigationService.pushNamed(
                    routeName: Routes.bookANanny,
                    args: state.id,
                  );
                }
              },
            );
          } else {
            return Container(height: 1);
          }
        },
      ),
      appBar: nanny != null
          ? null
          : const CustomAppBar(
              title: "Nanny Details",
            ),
      body: BlocListenerWrapper<AddToFavouriteCubit>(
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
          child: DefaultTabController(
            length: 2,
            child: BlocBuilderWrapper<FetchNannyDetailsCubit>(
              listener: (context, state) {
                if (state is CommonSuccessState<Nanny>) {
                  setState(() {
                    nanny = state.data;
                  });
                } else {
                  nanny = null;
                }
              },
              builder: (context, state) {
                if (state is CommonSuccessState<Nanny>) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, isScrolled) {
                      return [
                        SliverAppBar(
                          pinned: true,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: InvisibleExpandedHeader(
                            child: Text(
                              "Details",
                              style: appTextTheme.appTitle,
                            ),
                          ),
                          toolbarHeight: kToolbarHeight,
                          leadingWidth: 80,
                          leading: Container(
                            padding: const EdgeInsets.only(
                              left: CustomTheme.horizontalPadding,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: CustomIconButton(
                                    icon: NannyIcon.arrowLeft,
                                    iconColor: CustomTheme.textColor,
                                    borderColor: Colors.white,
                                    padding: 12,
                                    iconSize: 24,
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      NavigationService.pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(top: 4),
                                child: CustomIconButton(
                                  onPressed: () {
                                    if (state.data.isFavorite) {
                                      context
                                          .read<RemoveFromFavouriteCubit>()
                                          .unfavourite(state.data.id);
                                    } else {
                                      context
                                          .read<AddToFavouriteCubit>()
                                          .favorite(state.data.id);
                                    }
                                  },
                                  icon: state.data.isFavorite
                                      ? NannyIcon.heartFill
                                      : NannyIcon.heart,
                                  iconColor: state.data.isFavorite
                                      ? CustomTheme.primaryColor
                                      : CustomTheme.textColor,
                                  borderColor: Colors.white,
                                  padding: 12,
                                  iconSize: 24,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: CustomTheme.horizontalPadding),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    state.data.avatar,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: CustomTheme.horizontalPadding,
                                vertical: 35.hp,
                              ),
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          expandedHeight: 450,
                        ),
                        SliverToBoxAdapter(
                          child: _ProfileInfo(
                            nanny: state.data,
                          ),
                        ),
                        const SliverPinnedHeader(
                          child: _ProfileTabBar(),
                        )
                      ];
                    },
                    body: const TabBarView(
                      children: [
                        NannyPersonalDetailsSection(),
                        NannyReviewSection(),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  final Nanny nanny;
  const _ProfileInfo({required this.nanny});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.hp,
        vertical: 17.hp,
      ),
      color: CustomTheme.lightBlue,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nanny.name.capitalize(),
                style: appTextTheme.bodyLargeSemiBold.copyWith(
                  fontSize: 20,
                  letterSpacing: 0.9,
                ),
              ),
              SizedBox(
                height: 8.hp,
              ),
              Row(
                children: [
                  const Icon(
                    NannyIcon.location,
                    size: 17,
                  ),
                  SizedBox(
                    width: 4.wp,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "${nanny.city.capitalize()} ,",
                      style: appTextTheme.bodySmallRegular,
                      children: [
                        TextSpan(
                            text: nanny.address.capitalize(),
                            style: appTextTheme.bodySmallRegular)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              CustomIconButton(
                icon: NannyIcon.directRight,
                iconColor: CustomTheme.textColor,
                borderColor: Colors.white,
                padding: 15,
                iconSize: 24,
                backgroundColor: Colors.white,
                onPressed: () {
                  UrlLauncher.launchSMS(
                    context: context,
                    phone: nanny.phoneNUmber,
                  );
                },
              ),
              SizedBox(
                width: 8.wp,
              ),
              CustomIconButton(
                icon: NannyIcon.call,
                iconColor: CustomTheme.textColor,
                borderColor: Colors.white,
                padding: 15,
                iconSize: 24,
                backgroundColor: Colors.white,
                onPressed: () {
                  UrlLauncher.launchPhone(
                    context: context,
                    phone: nanny.phoneNUmber,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ProfileTabBar extends StatelessWidget {
  const _ProfileTabBar();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.horizontalPadding,
        vertical: 12,
      ),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: CustomTheme.backgroundColor,
        ),
        child: TabBar(
          tabs: const [
            Tab(
              text: 'Personal',
            ),
            Tab(
              text: "Reviews",
            )
          ],
          labelPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          indicatorColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          }),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelStyle: appTextTheme.bodyMedium,
          labelColor: CustomTheme.textColor,
          splashBorderRadius: BorderRadius.circular(0),
          unselectedLabelColor: CustomTheme.grey,
        ),
      ),
    );
  }
}

class InvisibleExpandedHeader extends StatefulWidget {
  final Widget child;
  const InvisibleExpandedHeader({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  State<InvisibleExpandedHeader> createState() =>
      _InvisibleExpandedHeaderState();
}

class _InvisibleExpandedHeaderState extends State<InvisibleExpandedHeader> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context).position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible ?? false,
      child: widget.child,
    );
  }
}
