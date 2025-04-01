import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_list_page.dart';
import 'package:flutter_train_app/seat_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomePage({super.key, required this.onThemeToggle});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  Future<void> _selectStation(BuildContext context, bool isDeparture) async {
    final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(isDeparture: isDeparture),
      ),
    );

    if (selectedStation != null) {
      setState(() {
        if (isDeparture) {
          if (selectedStation == arrivalStation) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('출발역과 도착역은 같을 수 없습니다!')),
            );
          } else {
            departureStation = selectedStation;
          }
        } else {
          if (selectedStation == departureStation) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('출발역과 도착역은 같을 수 없습니다!')),
            );
          } else {
            arrivalStation = selectedStation;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: widget.onThemeToggle,
            tooltip: '테마 전환',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // 테마에 맞는 카드 색상 사용
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectStation(context, true),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '출발역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            departureStation ?? '선택',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Theme.of(context).dividerColor, // 테마에 맞는 구분선 색상
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectStation(context, false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '도착역', // '출발역' 오타 수정
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            arrivalStation ?? '선택',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (departureStation == null || arrivalStation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('출발역과 도착역을 선택해주세요!')),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatPage(
                          departureStation: departureStation!,
                          arrivalStation: arrivalStation!,
                          onThemeToggle: widget.onThemeToggle,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}