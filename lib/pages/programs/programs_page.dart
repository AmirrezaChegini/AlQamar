import 'package:al_qamar/bloc/program/program_bloc.dart';
import 'package:al_qamar/bloc/program/program_event.dart';
import 'package:al_qamar/bloc/program/program_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:al_qamar/widgets/programs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProgramBloc>(context).add(GetAllProgramsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'programList'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: BlocBuilder<ProgramBloc, ProgramState>(
        builder: (context, state) {
          if (state is CompleteProgramState) {
            return ListView.builder(
              itemCount: state.allProgramList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.allProgramList[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 18),
                    ),
                    ...List.generate(
                      state.allProgramList[index].programList.length,
                      (innerIndex) => Programs(
                        program:
                            state.allProgramList[index].programList[innerIndex],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is LoadingProgramState) {
            return const LoadingState();
          }

          if (state is FailProgramState) {
            return Center(
              child: ErrorState(
                errorMessage: state.errorMessage,
                onTap: () => BlocProvider.of<ProgramBloc>(context)
                    .add(GetAllProgramsEvent()),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
