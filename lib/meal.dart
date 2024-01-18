class Meal {
  final String name; // 식사 이름
  final List<String> ingredients; // 재료 목록
  final String instructions; // 조리 방법
  final String imageUrl; // 이미지 URL

  Meal({required this.name, required this.ingredients, required this.instructions, required this.imageUrl});
}