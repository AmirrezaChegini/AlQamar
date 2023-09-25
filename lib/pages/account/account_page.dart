import 'package:al_qamar/cubit/auth_cubit.dart';
import 'package:al_qamar/pages/account/auth_page.dart';
import 'package:al_qamar/pages/account/bookmark_page.dart';
import 'package:al_qamar/utils/anim/slide_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        const BookmarkPage(),
        BlocBuilder<AuthCubit, bool>(
          builder: (context, state) => SlideUpAnim(
            state: !state,
            child: const AuthPage(),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
