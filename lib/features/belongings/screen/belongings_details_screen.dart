import 'package:flutter/material.dart';
import 'package:wathiq/features/belongings/screen/belongings_screen.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class BelongingsDetailsScreen extends StatefulWidget {
  final String type;

  const BelongingsDetailsScreen({super.key, required this.type});

  @override
  State<BelongingsDetailsScreen> createState() =>
      _BelongingsDetailsScreenState();
}

class _BelongingsDetailsScreenState extends State<BelongingsDetailsScreen> {
  bool showMap = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> details = {
      "الشقق": [
        {
          "status": "للإيجار",
          "image": "assets/images/a1.png",
          "location": "حي الياسمين - الرياض",
          "street": "شارع أنس بن مالك",
          "price": "60,000 رس / سنوياً",
        },
        {
          "status": "للبيع",
          "image": "assets/images/a2.png",
          "location": "حي الملقا - الرياض",
          "street": "شارع عبدالله بن سعود",
          "price": "950,000 رس",
        },
      ],
      "الفلل": [
        {
          "status": "للبيع",
          "image": "assets/images/v1.png",
          "location": "حي حطين - الرياض",
          "street": "طريق الملك خالد",
          "price": "2,300,000 رس",
        },
        {
          "status": "للإيجار",
          "image": "assets/images/v2.png",
          "location": "حي العارض - الرياض",
          "street": "شارع القوات الخاصة",
          "price": "180,000 رس / سنوياً",
        },
      ],
      "التجاري": [
        {
          "status": "للإيجار",
          "image": "assets/images/t2.png",
          "location": "حي الصحافة - الرياض",
          "street": "طريق الملك فهد",
          "price": "150,000 رس / سنوياً",
        },
        {
          "status": "للبيع",
          "image": "assets/images/t1.png",
          "location": "حي الياسمين - الرياض",
          "street": "شارع العليا",
          "price": "4,200,000 رس",
        },
      ],
      "الأراضي": [
        {
          "status": "للبيع",
          "image": "assets/images/l1.png",
          "location": "حي العقيق - الرياض",
          "street": "شارع التخصصي",
          "price": "1,100,000 رس",
        },
        {
          "status": "للبيع",
          "image": "assets/images/l2.png",
          "location": "حي النخيل - الرياض",
          "street": "طريق الأمير تركي الأول",
          "price": "1,350,000 رس",
        },
      ],
    };

    final list = details[widget.type] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0C3F45),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3F45),
        title: Text(
          widget.type,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                BelongingsScreen(),
                      ),
                    );
              },
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C3F45),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.grid_view,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      hintText: "شقق مفروشة",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.filter_list, color: Colors.grey),
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "عرض الخريطة",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 10),
              Switch(
                value: showMap,
                onChanged: (val) => setState(() => showMap = val),
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.white,
                // activeThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 10),
          if (showMap)
            Container(
              height: 250,
              margin: const EdgeInsets.only(bottom: 19),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/map.png",
                  width: 250,
                  // height: 150,
                ),
              ),
            ),

          ...list.map((item) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            item["image"]!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
                              item["status"]!,
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
                            item["location"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item["street"]!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item["price"]!,
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
            );
          }).toList(),
        ],
      ),
    );
  }
}
