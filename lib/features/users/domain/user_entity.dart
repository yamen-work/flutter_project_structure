class UserEntity {
  final int id;
  final String name;
  final String username;
  final String email;
  final String city;
  int xp=0;
  final String phone;
  final String website;
  final String companyName;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.city,
    required this.phone,
    required this.website,
    required this.companyName,
  });


  void incrementXp(){
    xp+=100;
  }
}
