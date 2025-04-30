import 'package:flutter/material.dart';

void main() => runApp(ZusApp());

class ZusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200], 
        fontFamily: 'Roboto', // Optional: set consistent font
      ),
      debugShowCheckedModeBanner: false,
      home: RewardsPage(),
    );
  }
}

class RewardsPage extends StatelessWidget {
  final int points = 731;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(    
            'Missions and Rewards',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
                ),
            ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              color: Colors.white, // Set background color here
              child: TabBar(
                labelColor: Color(0xFF003366), // Selected tab color
                unselectedLabelColor: Colors.grey, // Unselected tab color
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 12,
                ),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Color(0xFF003366)), // Deep blue underline
                  insets: EdgeInsets.symmetric(horizontal: 0), // Full-width underline
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Missions'),
                  Tab(text: 'Redeem Rewards'),
                  Tab(text: 'My Rewards'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MissionsTab(points: points),
            RedeemTab(points: points),
            Center(child: Text('My Rewards (Coming Soon)')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Gift Card'),
            BottomNavigationBarItem(icon: Icon(Icons.redeem), label: 'Rewards'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ),
      ),
    );
  }
}

class MissionsTab extends StatelessWidget {
  final int points;

  MissionsTab({required this.points});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.local_cafe, size: 40, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text('$points points', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text('Daily Check-in'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return Column(
                children: [
                  Icon(Icons.check_circle, color: index < 4 ? Colors.blue : Colors.grey),
                  Text('+${index == 3 ? 3 : 1}pt'),
                ],
              );
            }),
          ),
          SizedBox(height: 20),
          Text('Complete missions & get exclusive rewards', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            children: [
              MissionCard(title: '3x Orders for nge-teh sessions', points: 80, daysLeft: 4),
              MissionCard(title: '3x Orders to puff up your day', points: 30, daysLeft: 7),
              MissionCard(title: '2x ZUSday Orders to #GetZUSsed', points: 130, daysLeft: 7),
              MissionCard(title: '5x Orders to stay ahead of the crowd', points: 150, daysLeft: 7),
            ],
          )
        ],
      ),
    );
  }
}

class MissionCard extends StatelessWidget {
  final String title;
  final int points;
  final int daysLeft;

  MissionCard({required this.title, required this.points, required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('$points pts | $daysLeft days left'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Start Now'),
            )
          ],
        ),
      ),
    );
  }
}

class RedeemTab extends StatelessWidget {
  final int points;

  RedeemTab({required this.points});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Easy Goer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('ZUS Points: $points pts'),
          SizedBox(height: 20),
          Text('ZUS Rewards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          RewardCard(title: 'Free 0 Cal Sugar', cost: 50),
          RewardCard(title: 'RM 1', cost: 100),
          SizedBox(height: 20),
          Text('ZUS Elite Exclusive', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          RewardCard(title: 'RM 12', cost: 1000),
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String title;
  final int cost;

  RewardCard({required this.title, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Redeem with $cost pts'),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('Redeem'),
        ),
      ),
    );
  }
}
