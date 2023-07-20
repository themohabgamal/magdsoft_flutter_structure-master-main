class HelpResponse {
  HelpResponse({
    this.status,
    this.message,
    this.help,
  });

  HelpResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['help'] != null) {
      help = [];
      json['help'].forEach((v) {
        help?.add(Help.fromJson(v));
      });
    }
  }

  num? status;
  String? message;
  List<Help>? help;
  HelpResponse copyWith({
    num? status,
    String? message,
    List<Help>? help,
  }) =>
      HelpResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        help: help ?? this.help,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (help != null) {
      map['help'] = help?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Help {
  Help({
    this.id,
    this.question,
    this.answer,
  });

  Help.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
  num? id;
  String? question;
  String? answer;
  Help copyWith({
    num? id,
    String? question,
    String? answer,
  }) =>
      Help(
        id: id ?? this.id,
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}
