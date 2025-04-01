import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;
  final VoidCallback onThemeToggle;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
    required this.onThemeToggle,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<bool> selectedSeats = List.generate(80, (_) => false);

  List<String> getSelectedSeats() {
    List<String> selected = [];
    for (int i = 0; i < selectedSeats.length; i++) {
      if (selectedSeats[i]) {
        int row = (i ~/ 4) + 1;
        int col = i % 4;
        String seatLabel = switch (col) {
          0 => 'A',
          1 => 'B',
          2 => 'C',
          3 => 'D',
          _ => '',
        };
        selected.add('$row-$seatLabel');
      }
    }
    return selected;
  }

  void showBookingDialog() {
    final selected = getSelectedSeats();
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('좌석을 선택해주세요.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor.withOpacity(1.2), // 테마에 맞는 배경색
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          '예매하시겠습니까?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium?.color, // 테마 글씨 색상
          ),
        ),
        content: Text(
          '좌석: ${selected.join(' ')}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14, 
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('예약이 취소되었습니다.')),
              );
            },
            child: const Text(
              '취소',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('예약이 완료되었습니다.')),
              );
            },
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 10), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                  color: Theme.of(context).iconTheme.color,
                ),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '선택됨',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '선택안됨',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'A',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'B',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 54),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'C',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'D',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -15),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: row(index + 1),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: showBookingDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
              ),
              child: const Text(
                '예매 하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row row(int index) {
    int baseIndex = (index - 1) * 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        seat(baseIndex),
        const SizedBox(width: 4),
        seat(baseIndex + 1),
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
          ),
        ),
        seat(baseIndex + 2),
        const SizedBox(width: 4),
        seat(baseIndex + 3),
      ],
    );
  }

  Widget seat(int seatIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeats[seatIndex] = !selectedSeats[seatIndex];
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectedSeats[seatIndex] ? Colors.purple : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}