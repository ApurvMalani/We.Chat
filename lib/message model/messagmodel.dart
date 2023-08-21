class MessageModel {
  String? sendermessage;
  String? text;
  DateTime? rightdonblue;
  bool? seen;

  MessageModel({this.sendermessage, this.text, this.rightdonblue, this.seen});

  MessageModel.this_Message_Map(Map<String, dynamic> mapmessage) {
    sendermessage = mapmessage['sendermessage'];
    text = mapmessage['text'];
    rightdonblue = mapmessage['rightdonblue'].toDate();
    seen = mapmessage['seen'];
  }

  Map<String, dynamic> tooMaps() {
    return {
      'sendermessage': sendermessage,
      'text': text,
      'rightdonblue': rightdonblue,
      'seen': seen
    };
  }
}
