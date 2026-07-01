import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawyer_bro/features/authentication/bloc/authentication_bloc.dart';
import 'package:lawyer_bro/features/authentication/respository/authentication_repo.dart';

class InitialProvider extends StatelessWidget {
  final Widget child;
  const InitialProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(AuthenticationRepo()),
          ),
        ],
        child: child,
      ),
    );
  }
}
