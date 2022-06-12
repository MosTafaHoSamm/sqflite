class NoteModel {
  String? note;
  int? id;

  NoteModel(this.note, this.id);

  NoteModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    id = json['id'];
  }
  Map<String,dynamic>toMap(){
    return{
      'id':id,

    };
  }
}
