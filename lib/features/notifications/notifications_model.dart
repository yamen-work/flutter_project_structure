class StoredNotification {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final DateTime timestamp;
  final Map<String, dynamic> data;
  final String? senderId;
  final String? from;
  final String? collapseKey;
  final String? category;
  final String? messageType;

  StoredNotification({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    required this.timestamp,
    this.data = const {},
    this.senderId,
    this.from,
    this.collapseKey,
    this.category,
    this.messageType,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'imageUrl': imageUrl,
    'timestamp': timestamp.toIso8601String(),
    'data': data,
    'senderId': senderId,
    'from': from,
    'collapseKey': collapseKey,
    'category': category,
    'messageType': messageType,
  };

  static StoredNotification fromJson(Map<String, dynamic> json) {
    return StoredNotification(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      senderId: json['senderId'],
      from: json['from'],
      collapseKey: json['collapseKey'],
      category: json['category'],
      messageType: json['messageType'],
    );
  }
}
