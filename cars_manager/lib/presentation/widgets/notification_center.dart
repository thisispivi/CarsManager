import 'package:flutter/material.dart';

class NotificationData {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  bool isRead;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.isRead = false,
  });
}

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  // Mock data for in-app center
  final List<NotificationData> _notifications = [
    NotificationData(
      id: '1',
      title: 'Upcoming Due Date',
      body: 'Your Stilo\'s insurance expires in 7 days',
      date: DateTime.now().add(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return PopupMenuButton<String>(
      icon: Stack(
        children: [
          const Icon(Icons.notifications_none),
          if (unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onOpened: () {
        setState(() {
          for (var n in _notifications) {
            n.isRead = true;
          }
        });
      },
      itemBuilder: (context) {
        if (_notifications.isEmpty) {
          return [
            const PopupMenuItem(
              enabled: false,
              child: Text('No notifications'),
            ),
          ];
        }
        return _notifications.map((n) {
          return PopupMenuItem<String>(
            value: n.id,
            child: ListTile(
              title: Text(
                n.title,
                style: TextStyle(
                  fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Text(n.body),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}
