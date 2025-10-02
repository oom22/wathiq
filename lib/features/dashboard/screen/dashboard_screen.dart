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
    // quick thousand separator for simple demo (use intl for real formatting)
    return s.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  final _slices = <_Slice>[
    _Slice('A', 35, AppColors.secondary2),
    _Slice('B', 15, AppColors.primary),
    _Slice('C', 50, AppColors.secondary1),
  ];

  @override
  Widget build(BuildContext context) {
    final total = _slices.fold<double>(0, (s, e) => s + e.value);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: 200),
        // --- FIRST BAR CHART (like the screenshot) ---
        SizedBox(
          height: 240,
          child: Directionality(
            // RTL labels if needed
            textDirection: TextDirection.rtl,
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: 10, // keep a stable scale
                alignment: BarChartAlignment.spaceAround,
                groupsSpace: 8, // small gaps
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine:
                      (v) => FlLine(
                        color: Colors.black12.withOpacity(0.08),
                        strokeWidth: 1,
                        dashArray: [4, 6],
                      ),
                ),
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
                        // simple 1..9 labels (swap with days/months as you like)
                        const labels = ['١', '٢', '٣', '٤', '٥', '٦', '٧', '٨'];
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
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 4,
                    getTooltipItem:
                        (group, gi, rod, ri) => BarTooltipItem(
                          '﷼ ${_format(6323)}', // replace with your value per bar
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  ),
                ),
                barGroups: List.generate(8, (i) {
                  // sample heights to mimic the shape in your image
                  final heights = [9.0, 7.5, 6.0, 5.8, 5.2, 4.5, 4.3, 4.0, 8.5];
                  final isAccent = i == 3; // the darker middle bar in your shot
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: heights[i],
                        width:
                            24, // narrow, “high width” look without being chunky
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // rounded all sides
                        color:
                            isAccent
                                ? const Color(0xFF0C3F45) // darker accent
                                : const Color(0xFF0A6A72), // teal
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 36,
              pieTouchData: PieTouchData(
                touchCallback: (event, resp) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        resp == null ||
                        resp.touchedSection == null) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = resp.touchedSection!.touchedSectionIndex;
                    }
                  });
                },
              ),
              sections: List.generate(_slices.length, (i) {
                final s = _slices[i];
                final isTouched = i == touchedIndex;
                final pct = (s.value / total * 100).toStringAsFixed(0);
                return PieChartSectionData(
                  color: s.color,
                  value: s.value,
                  title: '$pct%',
                  radius: isTouched ? 60 : 52,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ),
          ),
        ),

        SizedBox(
          height: 280,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // make each bar half of the chart width (tiny fudge to avoid overlap)
              final barWidth = constraints.maxWidth / 2 - 0.5;

              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  minY: 0,
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
                        reservedSize: 24,
                        getTitlesWidget: (v, m) {
                          switch (v.toInt()) {
                            case 0:
                              return const Text('بيع'); // left bar label
                            case 1:
                              return const Text('إيجار'); // right bar label
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
                          toY: 6,
                          width: barWidth,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: const Color(0xFF123E44),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 9,
                          width: barWidth,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: const Color(0xFF0A6A72),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Slice {
  final String label;
  final double value;
  final Color color;
  const _Slice(this.label, this.value, this.color);
}
