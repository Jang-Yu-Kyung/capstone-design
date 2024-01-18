class Todo{//원래 사용하던 데이터베이스 친구들
  String? title;
  String? content;
  int? active;
  int? id;

  Todo toggleActive() {
    return Todo(
      title: title,
      content: content,
      active: active == 1 ? 0 : 1,
      id: id,
    );
  }

  Todo({this.title, this.content, this.active , this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title ?? '', // null일 경우 빈 문자열로 변환
      'content': content ?? '', // null일 경우 빈 문자열로 변환
      'active': active,
      'id': id,
    };

  }
}