import 'package:easy_stepper/easy_stepper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:wathiq/features/add/widgets/form_card.dart';
import 'package:wathiq/features/navigation/screen/navigation_screen.dart';
import 'package:wathiq/features/onboarding/widget/custom_button.dart';
import 'package:wathiq/features/onboarding/widget/reusable_textfield.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Upload state
  String? _pickedName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      dialogTitle: 'اختر ملف الصك',
      lockParentWindow: true,
    );
    if (!mounted) return;
    if (result == null || result.files.isEmpty) return;
    setState(() => _pickedName = result.files.single.name);
  }

  // Step 0
  final nameCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final ibanCtrl = TextEditingController();

  // Step 1
  final deedCtrl = TextEditingController();
  final meterCtrl = TextEditingController();
  final nationalAddrCtrl = TextEditingController();

  // (unused extras, keep if you need later)
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();

  int active = 0;
  final Color teal = const Color(0xFF0A6A72);

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 100),
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'تم اضافة الصك بنجاح',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  'عالبركة! تم اضافة الصك لقاعدة البيانت',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const NavigationScreen(),
                    ),
                  );
                },
                child: const Text(
                  'العودة للوحة التحكم',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _next() {
    if (active < 2) {
      setState(() => active++);
    } else {
      _submit();
    }
  }

  Future<void> _submit() async {
    if (!mounted) return;
    await _showMyDialog();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    idCtrl.dispose();
    phoneCtrl.dispose();
    ibanCtrl.dispose();
    deedCtrl.dispose();
    meterCtrl.dispose();
    nationalAddrCtrl.dispose();
    addressCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المعلومات الشخصية"), centerTitle: true),
      body: Column(
        children: [
          // Stepper
          EasyStepper(
            textDirection: TextDirection.rtl,
            activeStep: active,
            showTitle: false,
            stepShape: StepShape.circle,
            stepRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            lineStyle: const LineStyle(
              lineType: LineType.normal,
              lineThickness: 2,
              lineSpace: 0,
              defaultLineColor: Colors.white,
              finishedLineColor: Colors.white,
            ),
            unreachedStepBackgroundColor: Colors.white,
            unreachedStepBorderColor: Colors.white,
            finishedStepBackgroundColor: teal,
            finishedStepBorderColor: Colors.white,
            activeStepBackgroundColor: teal,
            activeStepBorderColor: Colors.white,
            steps: const [
              EasyStep(
                icon: Icon(FontAwesomeIcons.one, color: Colors.white),
                activeIcon: Icon(FontAwesomeIcons.one, color: Colors.white),
                finishIcon: Icon(Icons.check, size: 16, color: Colors.white),
              ),
              EasyStep(
                icon: Icon(FontAwesomeIcons.two, color: Colors.white),
                activeIcon: Icon(FontAwesomeIcons.two, color: Colors.white),
                finishIcon: Icon(Icons.check, size: 16, color: Colors.white),
              ),
              EasyStep(
                icon: Icon(FontAwesomeIcons.three, color: Colors.white),
                activeIcon: Icon(FontAwesomeIcons.three, color: Colors.white),
                finishIcon: Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ],
            onStepReached: (i) => setState(() => active = i),
          ),

          // White rounded area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.secondary1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _buildStepContent(active),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.secondary1,
    );
  }

  // ---------- Step-specific content ----------
  Widget _buildStepContent(int step) {
    switch (step) {
      // Step 0 (button INSIDE the card)
      case 0:
        return SingleChildScrollView(
          key: const ValueKey('step0'),
          child: FormCard(
            accent: teal,
            children: [
              ReusableTextField(
                controller: nameCtrl,
                hintText: "محمد علي",
                title: "الاسم الكامل",
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: idCtrl,
                hintText: "000-000-000",
                title: "الهوية / الإقامة",
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: phoneCtrl,
                hintText: "(966) 500-0000",
                title: "رقم الجوال",
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: ibanCtrl,
                hintText: "SA-0000000000000000000",
                title: "رقم الآيبان",
                suffixIcon: const Icon(FontAwesomeIcons.moneyCheck),
              ),
              const SizedBox(height: 16),
              CustomButton(text: "التالي", onPressed: _next),
            ],
          ),
        );

      // Step 1 (button INSIDE the card)
      case 1:
        return SingleChildScrollView(
          key: const ValueKey('step1'),
          child: FormCard(
            accent: teal,
            children: [
              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F3F4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: teal, width: 1.25),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        CupertinoIcons.arrow_down_doc,
                        color: teal,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _pickedName == null
                              ? 'رفع الصك كمستند او صورة'
                              : _pickedName!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: deedCtrl,
                hintText: "0000000000",
                title: "صك العقار",
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: meterCtrl,
                hintText: "0000000000000",
                title: "رقم عداد الكهرباء الأساسية",
              ),
              const SizedBox(height: 12),
              ReusableTextField(
                controller: nationalAddrCtrl,
                hintText: "AAAA-1234",
                title: "العنوان الوطني",
              ),
              const SizedBox(height: 16),
              CustomButton(text: "التالي", onPressed: _next),
            ],
          ),
        );

      // Step 2 (two cards + button INSIDE the white area)
      default:
        return SingleChildScrollView(
          key: const ValueKey('step2'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SummaryCard(
                title: 'المعلومات الشخصية',
                onEdit: () => setState(() => active = 0),
                rows: [
                  ('الاسم الكامل', nameCtrl.text),
                  ('رقم الهوية', idCtrl.text),
                  ('رقم الجوال', phoneCtrl.text),
                  ('رقم الآيبان', ibanCtrl.text),
                ],
                accent: teal,
              ),
              const SizedBox(height: 12),
              _SummaryCard(
                title: 'معلومات الصك',
                onEdit: () => setState(() => active = 1),
                rows: [
                  ('صك العقار', deedCtrl.text),
                  ('رقم عداد الكهرباء الأساسية', meterCtrl.text),
                  ('العنوان الوطني', nationalAddrCtrl.text),
                ],
                accent: teal,
              ),
              const SizedBox(height: 16),
              CustomButton(text: "اضافة الصك", onPressed: _next),
            ],
          ),
        );
    }
  }
}

// ---------- Helpers ----------
class _StepWrap extends StatelessWidget {
  final List<Widget> children;
  const _StepWrap({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final List<(String label, String value)> rows;
  final VoidCallback? onEdit;
  final Color accent;

  const _SummaryCard({
    required this.title,
    required this.rows,
    required this.accent,
    this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F2F3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16, color: accent),
                      const SizedBox(width: 4),
                      Text(
                        'تعديل',
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 10),
            ...rows.map((e) => _row(e.$1, e.$2, accent)),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, Color accent) {
    final v = value.isEmpty ? '—' : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              v,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: accent.withOpacity(.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$label :',
            style: TextStyle(
              color: accent.withOpacity(.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
