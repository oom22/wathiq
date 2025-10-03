import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int touchedIndex = -1;

  String _format(num n) {
    final s = n.toStringAsFixed(0);
    return s.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  final _slices = <_Slice>[
    _Slice('متاح', 50, AppColors.primary),
    _Slice('مباع', 15, AppColors.secondary1),
    _Slice('مؤجر', 35, AppColors.secondary2),
  ];

  @override
  Widget build(BuildContext context) {
    final total = _slices.fold<double>(0, (s, e) => s + e.value);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          "لوحة التحكم",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.background,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),

          // 🟢 Top Section (تصفية + مربع البحث)
          Row(
            children: [
              // زر التصفية
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff939CA4),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      "تصفية",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // مربع البحث
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    hintText: "شقق مفروشة",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              // 🟢 كرت العقارات
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: AppColors.background,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // الايقونة
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.secondary1.withOpacity(
                              0.2,
                            ),
                            child: const Icon(
                              Icons.north_west,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // العنوان
                        const Text(
                          "العقارات",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // المخطط + الليجند
                        Row(
                          children: [
                            // PieChart صغير
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 14,
                                  sections: [
                                    PieChartSectionData(
                                      color: AppColors.primary,
                                      // value: 40,
                                      radius: 22,
                                    ),
                                    PieChartSectionData(
                                      color: AppColors.secondary1,
                                      // value: 30,
                                      radius: 22,
                                    ),
                                    PieChartSectionData(
                                      color: AppColors.secondary2,
                                      // value: 30,
                                      radius: 22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // الليجند يمين
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  LegendItem(
                                    label: "عمارة سكنية",
                                    color: AppColors.secondary2,
                                  ),
                                  LegendItem(
                                    label: "فيلا",
                                    color: AppColors.secondary1,
                                  ),
                                  LegendItem(
                                    label: "أرض",
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // 🔵 كرت نسبة الوحدات المؤجرة
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: AppColors.background,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.secondary1.withOpacity(
                              0.2,
                            ),
                            child: const Icon(
                              Icons.north_west,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          "نسبة الوحدات المؤجرة",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            // BarChart صغير
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.center,
                                  gridData: const FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  titlesData: const FlTitlesData(show: false),
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 0,
                                      barRods: [
                                        BarChartRodData(
                                          toY: 3,
                                          width: 20,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 1,
                                      barRods: [
                                        BarChartRodData(
                                          toY: 2.5,
                                          width: 20,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          color: AppColors.secondary1,
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 2,
                                      barRods: [
                                        BarChartRodData(
                                          toY: 3,
                                          width: 20,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          color: AppColors.secondary2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  LegendItem(
                                    label: "عمارة سكنية",
                                    color: AppColors.secondary2,
                                  ),
                                  LegendItem(
                                    label: "فيلا",
                                    color: AppColors.secondary1,
                                  ),
                                  LegendItem(
                                    label: "أرض",
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // --- CARD 1: إجمالي عقود البيع ---
          _buildCard(
            title: "إجمالي عقود البيع",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 🔵 الصف العلوي: الزيادة الأسبوعية + العنوان + القيمة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "+ ﷼ 1450.22",
                          style: TextStyle(
                            color: AppColors.secondary1,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "هذا الأسبوع",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        SizedBox(height: 4),
                        Text(
                          "﷼16,896.22",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(thickness: 1, color: Colors.black12),

                // 🟢 البار شارت مع القيم فوق الأعمدة
                SizedBox(
                  height: 220,
                  child: Stack(
                    children: [
                      // 🔵 البار شارت
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: BarChart(
                          BarChartData(
                            minY: 0,
                            maxY: 10,
                            alignment: BarChartAlignment.spaceAround,
                            groupsSpace: 8,
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 22,
                                  getTitlesWidget: (v, m) {
                                    const labels = [
                                      'Jan',
                                      'Feb',
                                      'Mar',
                                      'Apr',
                                      'May',
                                      'Jun',
                                      'Jul',
                                      'Aug',
                                    ];
                                    final i = v.toInt();
                                    if (i >= 0 && i < labels.length) {
                                      return Text(
                                        labels[i],
                                        style: const TextStyle(fontSize: 12),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                            barGroups: List.generate(8, (i) {
                              final heights = [
                                9.0,
                                7.5,
                                6.0,
                                5.8,
                                5.2,
                                4.5,
                                4.3,
                                8.5,
                              ];
                              final isAccent = i == 3;
                              return BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: heights[i],
                                    width: 35,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color:
                                        isAccent
                                            ? const Color(0xFF0A6A72)
                                            : const Color(0xFF0C3F45),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),

                      // 🟢 الأرقام فوق الأعمدة
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final barCount = 8;
                            final barWidth = constraints.maxWidth / barCount;
                            final heights = [
                              9.0,
                              7.5,
                              6.0,
                              5.8,
                              5.2,
                              4.5,
                              4.3,
                              8.5,
                            ];
                            return Row(
                              children: List.generate(barCount, (i) {
                                return SizedBox(
                                  width: barWidth,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            constraints.maxHeight *
                                                (1 - (heights[i] / 20)) -
                                            20,
                                      ),
                                      child: Transform.rotate(
                                        angle: -1.5700,
                                        child: Text(
                                          heights[i].toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- CARD 2: العقارات حسب الحالة (PieChart + Legend) ---
          _buildCard(
            title: "العقارات حسب الحالة",
            child: SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟢 يسار: PieChart صغير
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          sections: List.generate(_slices.length, (i) {
                            final s = _slices[i];
                            final pct = (s.value / total * 100).toStringAsFixed(
                              0,
                            );
                            return PieChartSectionData(
                              color: s.color,
                              value: s.value,
                              title: '$pct%',
                              radius: 46,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                  // 🔵 يمين: الليجند
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                              _slices.map((s) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        s.label,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 6),
                                      CircleAvatar(
                                        radius: 6,
                                        backgroundColor: s.color,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // --- CARD 3: العقارات حسب النوع ---
          _buildCard(
            title: "العقارات حسب النوع",
            subtitle: "200 وحدة",
            child: SizedBox(
              height: 200,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    minY: 0,
                    groupsSpace: 0,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (v, m) {
                            switch (v.toInt()) {
                              case 0:
                                return const Text(
                                  'بيع',
                                  style: TextStyle(fontSize: 14),
                                );
                              case 1:
                                return const Text(
                                  'إيجار',
                                  style: TextStyle(fontSize: 14),
                                );
                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: 1,
                            width: 100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: const Color(0xFF123E44),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 2,
                            width: 100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: const Color(0xFF0A6A72),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 Widget Helper لبناء كل Card
  Widget _buildCard({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.background,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 12),
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              )
            else
              const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _Slice {
  final String label;
  final double value;
  final Color color;
  const _Slice(this.label, this.value, this.color);
}

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const LegendItem({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          CircleAvatar(radius: 4, backgroundColor: color),
        ],
      ),
    );
  }
}
