import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/article/calender_page.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FourActions extends StatelessWidget {
  const FourActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'wednesdayBusiness'.localize(context),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: Fontsize.large),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1.25,
                    color: AppColors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<CalenderBloc, CalenderState>(
                listener: (context, state) {
                  if (state is FailCalenderState) {
                    showMessage(
                      context: context,
                      content: state.errorMessage.localize(context),
                      horizontalMargin: 10,
                      verticalMargin: 0,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CompleteCalenderState) {
                    return GridView.builder(
                      itemCount: state.calenderList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => TxtBtn(
                        onTap: () => Navigator.push(
                          context,
                          pageRoute(
                            child: CalenderDataPage(
                              calender: state.calenderList[index],
                            ),
                          ),
                        ),
                        title: state.calenderList[index].title,
                        icon: AppIcons.rightArrow,
                        fontSize: Fontsize.large,
                        iconSize: 20,
                        textDecoration: CheckDirect.isRTL(context)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                      ),
                    );
                  }

                  if (state is LoadingCalenderState) {
                    return const LoadingState();
                  }

                  if (state is FailCalenderState) {
                    return Center(
                      child: Text(
                        state.errorMessage.localize(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.big),
                      ),
                    );
                  }

                  if (state is EmptyCalenderState) {
                    return Center(
                      child: Text(
                        state.message.localize(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.big),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
