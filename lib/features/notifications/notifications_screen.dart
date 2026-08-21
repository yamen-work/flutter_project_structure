import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Localization/l10n/app_localization.dart';
import '../../core/resources/colors_and_styles.dart';
import '../../core/resources/colors_providers.dart';
import 'notifications_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  final List<StoredNotification> _notifications = [];


  @override
  void initState() {
    super.initState();


    _listenToNotifications();
  }

  // ------------------------------------------------------------
  // Listen for notifications
  // ------------------------------------------------------------

  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'Message received: ${message.notification?.title}',
      );

      final notification = StoredNotification(
        id: message.messageId ?? DateTime.now().toString(),
        title: message.notification?.title ?? 'Notification',
        body: message.notification?.body ?? '',
        timestamp: DateTime.now(),
        data: message.data,
      );

      setState(() {
        _notifications.insert(0, notification);
      });
    });
  }

  // ------------------------------------------------------------
  // Remove all notifications
  // ------------------------------------------------------------

  void _removeAllNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  // ------------------------------------------------------------
  // Remove one notification
  // ------------------------------------------------------------

  void _removeNotification(StoredNotification notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("notifications"),
      ),

      body: _notifications.isEmpty
          ? const Center(
        child: Text(
          'No notifications',
        ),
      )
          : ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];

          return notificationTile(notification);
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // Notification tile
  // ------------------------------------------------------------

  Widget notificationTile(
      StoredNotification notification,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: InkWell(
        onTap: () {

        },

        child:Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 15,
            ),

            child: Container(
              height: 0.16.sh,
              width: double.infinity,

              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1.0,
                  color: appGreyColor,
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ------------------------------------------------
                    // Icon
                    // ------------------------------------------------

                    Expanded(
                      flex: 1,
                      child: Center(
                        child: _notificationIcon(notification),
                      ),
                    ),

                    // ------------------------------------------------
                    // Title + body + date
                    // ------------------------------------------------

                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),

                            child: Text(
                              notification.title,
                              maxLines: 1,
                              overflow:
                              TextOverflow.ellipsis,

                              style: mediumTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.all(8.0),

                              child: Text(
                                notification.body,
                                maxLines: 3,
                                overflow:
                                TextOverflow.ellipsis,
                                style:
                                mediumBlackTextStyle,
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),

                            child: Text(
                              _formatDate(
                                notification.timestamp,
                              ),
                              maxLines: 1,
                              overflow:
                              TextOverflow.ellipsis,

                              style:
                              smallBlackTextStyle.copyWith(
                                fontSize: 12.sp,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }

  // ------------------------------------------------------------
  // Notification icon
  // ------------------------------------------------------------

  Widget _notificationIcon(
      StoredNotification notification,
      ) {
    final type = notification.data['type'];

    if (type == 'approved') {
      return CircleAvatar(
        radius: 33.h,
        backgroundImage: const AssetImage(
          "assets/images/in-app approved_icon.png",
        ),
      );
    }

    if (type == 'rejected') {
      return CircleAvatar(
        radius: 33.h,
        backgroundImage: const AssetImage(
          "assets/images/in-app rejected_icon.png",
        ),
      );
    }

    return CircleAvatar(
      radius: 33.h,
      backgroundColor: appPrimaryColor,
      child: Icon(
        Icons.notifications,
        color: Colors.white,
        size: 35.h,
      ),
    );
  }

  // ------------------------------------------------------------
  // Date formatting
  // ------------------------------------------------------------

  String _formatDate(DateTime date) {
    return DateFormat(
      'yyyy-MM-dd hh:mm a',
    ).format(date);
  }
}