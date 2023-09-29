import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:flutter/material.dart';

class FourActions extends StatelessWidget {
  const FourActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اعمال الاربعاء',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 1,
                  color: AppColors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => TxtBtn(
                onTap: () {},
                title: 'دعا کمیل بن الزیاد',
                icon: AppIcons.rightArrow,
              ),
            ),
          )
        ],
      ),
    );
  }
}
