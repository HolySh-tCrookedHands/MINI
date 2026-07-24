class ContactItemModel {
  final int id;
  final String name;
  final String urlAvatar;
  final bool isOnline;

  const ContactItemModel({
    required this.id,
    required this.name,
    required this.isOnline,
    this.urlAvatar = "none"
  });
}