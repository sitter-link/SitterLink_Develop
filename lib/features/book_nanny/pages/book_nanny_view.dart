import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/book_nanny_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/book_nanny/widgets/book_nanny_body.dart';

class BookNannyView extends StatelessWidget {
  final int nannyId;
  const BookNannyView({super.key, required this.nannyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookNannyCubit(
        repository: context.read<BookNannyRepository>(),
      ),
      child: BookNannyBody(nannyId: nannyId),
    );
  }
}
