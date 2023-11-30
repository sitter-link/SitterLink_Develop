import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/database/database_service.dart';
import 'package:nanny_app/core/injector/injection.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_favorite/repository/customer_favourite_repository.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';
import 'package:nanny_app/features/notification/repository/notification_repository.dart';
import 'package:nanny_app/features/rating/resources/rating_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  const MultiRepositoryWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(
            databaseService: DI.instance<DatabaseService>(),
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => NannyRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SkillsRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FavoriteRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookNannyRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => RatingRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => NotificationRepository(
            apiProvider: DI.instance<ApiProvider>(),
            env: DI.instance<Env>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
