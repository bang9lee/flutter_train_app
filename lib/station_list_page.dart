import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final List<String> stations = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  final bool isDeparture;

  StationListPage({super.key, required this.isDeparture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역' : '도착역'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: ListTile(
              title: Text(
                stations[index],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: () {
                Navigator.pop(context, stations[index]);
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox.shrink(),
      ),
    );
  }
}