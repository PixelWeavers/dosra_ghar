class Rating {
  final String userId;
  final double rating;
  final String timestamp;
  final String feedback; // New property

  Rating({
    required this.userId,
    required this.rating,
    required this.timestamp,
    required this.feedback, // Update constructor parameter
  });

  // Convert the Rating object to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'timestamp': timestamp,
      'feedback': feedback, // Include feedback in the map
    };
  }
}
