import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/api.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/utils/url_launcher.dart';
import 'package:flutter/material.dart';

class RegisterWidgets2 extends StatelessWidget {
  const RegisterWidgets2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text.rich(
          TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: Fontsize.large),
            children: [
              const TextSpan(
                text:
                    'شكرًا لاختيارك القمر. للبدء، يرجى اتباع هذه الخطوات البسيطة لإنشاء حسابك:\n\n',
              ),
              TextSpan(
                text: 'زيارة موقعنا على الويب:\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: Fontsize.large),
              ),
              const TextSpan(
                text:
                    'افتح متصفح الويب الخاص بك وانتقل إلى\n ${Api.baseUrlSite}\n\n',
              ),
              TextSpan(
                text: 'انقر على "التسجيل" أو "التسجيل":\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: Fontsize.large),
              ),
              const TextSpan(
                text:
                    'بمجرد أن تكون على الصفحة الرئيسية لدينا، ابحث عن زر "التسجيل" أو "التسجيل". يتم تحديده عادة في الزاوية العلوية اليمنى من الصفحة.\n\n',
              ),
              TextSpan(
                text: 'املأ معلوماتك:\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: Fontsize.large),
              ),
              const TextSpan(
                text:
                    'انقر على زر التسجيل، وسيتم توجيهك إلى صفحة حيث يجب عليك تقديم بعض المعلومات الأساسية. قد تشمل ذلك اسمك، عنوان بريدك الإلكتروني، وكلمة مرور آمنة. تأكد من استخدام كلمة مرور قوية للحفاظ على أمان حسابك.\n\n',
              ),
              TextSpan(
                text: 'تحقق من بريدك الإلكتروني:\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: Fontsize.large),
              ),
              const TextSpan(
                text:
                    'بعد ملء المعلومات الخاصة بك، قد يُطلب منك التحقق من عنوان بريدك الإلكتروني. تحقق من صندوق البريد الوارد الخاص بك للعثور على رسالة التحقق وانقر على الرابط المقدم.\n',
              ),
              const TextSpan(
                text:
                    'تهانينا! أنت الآن جزء من القمر. انطلق في استكشاف ميزاتنا، تصفح المحتوى، واستفد إلى أقصى حد من منصتنا.\n',
              )
            ],
            text: 'مرحبًا بك في القمر!\n',
          ),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: Fontsize.large),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BtnAuth(
              title: 'openSite'.localize(context),
              onTap: () async => UrlLauncher.launch(
                '${Api.baseUrlSite}/register',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
