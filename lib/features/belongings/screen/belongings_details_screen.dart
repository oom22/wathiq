import 'package:flutter/material.dart';

class BelongingsDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  const BelongingsDetailsScreen({super.key, required this.property});

  @override
  State<BelongingsDetailsScreen> createState() =>
      _BelongingsDetailsScreenState();
}

class _BelongingsDetailsScreenState extends State<BelongingsDetailsScreen> {
  bool showMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C3F45),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3F45),
        title: Text(
          widget.property["type"],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔵 السويتش (عرض الخريطة)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("عرض الخريطة", style: TextStyle(color: Colors.white)),
              Switch(
                value: showMap,
                onChanged: (val) {
                  setState(() => showMap = val);
                },
              ),
            ],
          ),

          // 🟢 الخريطة كصورة ثابتة
          if (showMap)
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 6,
                //     offset: Offset(0, 3),
                //   ),
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/map.png",
                  // fit: BoxFit.cover,
                  // width: 100,
                  // height: 100,
                ),
              ),
            ),

          // 🟢 الكرت الأبيض (تفاصيل العقار)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        widget.property["image"],
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C3F45),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.property["status"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.property["location"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.property["street"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.property["price"],
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
