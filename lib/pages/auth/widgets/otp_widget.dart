import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/cubit/btn_verify_cubit.dart';
import 'package:al_qamar/cubit/timer_cubit.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/otp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    super.key,
    required this.emailCtrl,
  });

  final TextEditingController emailCtrl;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  List<String> otpCode = [];

  void onChange(String v, int index) {
    if (v.isNotEmpty) {
      otpCode.insert(index, v);
      FocusScope.of(context).nextFocus();
    }
    if (v.isEmpty) {
      otpCode.removeAt(index);
      FocusScope.of(context).previousFocus();
    }

    if (otpCode.length == 6) {
      BlocProvider.of<BtnVerifyCubit>(context).clickable(true);
    } else {
      BlocProvider.of<BtnVerifyCubit>(context).clickable(false);
    }
  }

  void verify() {
    BlocProvider.of<AuthBloc>(context).add(VerifyAuthEvent(otpCode.join()));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BtnVerifyCubit>(context).clickable(false);
    BlocProvider.of<TimerCubit>(context).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'enterCode'.localize(context),
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: List.generate(
              6,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OtpTextField(
                    onChanged: (v) => onChange(v, index),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        BlocConsumer<TimerCubit, int>(
          listener: (context, state) {
            if (state == 0) {
              BlocProvider.of<AuthBloc>(context)
                  .add(ResendCodeEvent(widget.emailCtrl.text));
            }
          },
          builder: (context, state) => Text(
            '${'resendCode'.localize(context)} $state ${'second'.localize(context)}',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: () =>
              BlocProvider.of<AuthBloc>(context).add(ChangeInfoEvent()),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 14),
          ),
          child: Text(
            'changeInfo'.localize(context),
          ),
        ),
        const Spacer(),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BlocBuilder<BtnVerifyCubit, bool>(
            builder: (context, state) => BtnAuth(
              onTap: state ? verify : null,
              title: 'login'.localize(context),
            ),
          ),
        ),
      ],
    );
  }
}
