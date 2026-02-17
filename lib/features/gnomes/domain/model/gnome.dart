class Gnome {
  const Gnome({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.age,
    required this.weight,
    required this.height,
    required this.hairColor,
    required this.professions,
    required this.friends,
  });

  final int id;
  final String name;
  final String thumbnail;
  final int age;
  final double weight;
  final double height;
  final String hairColor;
  final List<String> professions;
  final List<String> friends;

  String get subtitle => 'Age $age • Hair $hairColor';
}
