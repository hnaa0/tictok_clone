class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumnailUrl;
  final String creatorUid;
  final String creator;
  final int liked;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumnailUrl,
    required this.creatorUid,
    required this.creator,
    required this.liked,
    required this.comments,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumnailUrl": thumnailUrl,
      "creatorUid": creatorUid,
      "creator": creator,
      "liked": liked,
      "comments": comments,
      "createdAt": createdAt,
    };
  }
}
