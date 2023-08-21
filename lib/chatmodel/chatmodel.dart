class ChatModal {
  String? chat_id;
  List<String>? roomors;

  ChatModal({this.chat_id, this.roomors});

  ChatModal.this_Chat_Map(Map<String, dynamic> mapschat) {
    chat_id = mapschat["chatids"];
    roomors = mapschat["roomors"];
  }

  Map<String, dynamic> tooMaps() {
    return {
      "chatids": chat_id,
      "roomors": roomors,
    };
  }
}
