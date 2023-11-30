import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';
import 'package:nanny_app/features/auth/cubit/fetch_city_cubit.dart';
import 'package:nanny_app/features/auth/cubit/fetch_commitment_type_cubit.dart';
import 'package:nanny_app/features/auth/cubit/fetch_days_timeslot_cubit.dart';
import 'package:nanny_app/features/auth/cubit/fetch_experience_cubit.dart';
import 'package:nanny_app/features/auth/cubit/fetch_skills_cubit.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_payment_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_review_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/repository/customer_favourite_repository.dart';
import 'package:nanny_app/features/profile/cubit/update_availability_cubit.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchCityCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchCommitmentTypeCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchSkillsCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchDaysCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchExperiencesCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchAllProfileSetupInfoCubit(
            repository: context.read<SkillsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddToFavouriteCubit(
            repository: context.read<FavoriteRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => RemoveFromFavouriteCubit(
            repository: context.read<FavoriteRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateBookingStatusCubit(
            repository: context.read<BookNannyRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreatePaymentCubit(
            repository: context.read<BookNannyRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateReviewCubit(
            repository: context.read<BookNannyRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateAvailabilityCubit(
            repository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
