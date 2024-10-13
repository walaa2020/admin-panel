import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final List<NotificationItem> notifications; // استبدل NotificationItem بنوع بيانات إشعاراتك

  NotificationIcon({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Container(
                    width: 600,
                    height: 600,
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              title: Text(
                                "${notifications[index].title}",
                                style: const TextStyle(fontSize: 18, color: Colors.teal),
                              ),
                              subtitle: Text(
                                " ${notifications[index].data}",
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  // قم بإزالة الإشعار
                                  // مثال:
                                  // cubit.readNot("${notifications[index].id}");
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.notifications_active, size: 50),
        ),
        if (notifications.length > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                '${notifications.length}',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// نموذج بيانات الإشعار
class NotificationItem {
  final String title;
  final String data;
  final String id;

  NotificationItem({required this.title, required this.data, required this.id});
}
