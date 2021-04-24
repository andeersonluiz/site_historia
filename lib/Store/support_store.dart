import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/model/teacher_model.dart';
part 'support_store.g.dart';

class SupportStore = _SupportStoreBase with _$SupportStore;

abstract class _SupportStoreBase with Store {
  @observable
  PickedFile? _pathImage = PickedFile("");

  @observable
  String _titleProject = "";

  @computed
  PickedFile? get pathImage => this._pathImage;

  @computed
  String get titleProject => this._titleProject;

  @observable
  ObservableList<Teacher> teacherLocal = ObservableList<Teacher>();

  @observable
  ObservableList<String> participantsLocal = ObservableList<String>();

  @observable
  String _msgErrorParticipants = "";

  @observable
  String _msgErrorParticipantsSize = "";

  @observable
  String _msgErrorTitle = "";

  @observable
  String _msgErrorImage = "";

  @observable
  String _msgErrorContent = "";

  @observable
  String _msgErrorTeacher = "";

  @computed
  String get msgErrorParticipants => this._msgErrorParticipants;

  @computed
  String get msgErrorParticipantsSize => this._msgErrorParticipantsSize;

  @computed
  String get msgErrorTitle => this._msgErrorTitle;

  @computed
  String get msgErrorImage => this._msgErrorImage;

  @computed
  String get msgErrorContent => this._msgErrorContent;

  @computed
  String get msgErrorTeacher => this._msgErrorTeacher;

  @observable
  String? _htmlContent = "";

  @computed
  String? get htmlContent => this._htmlContent;

  @action
  updatePath(PickedFile? newPath) {
    this._pathImage = newPath;
  }

  @action
  updateTitle(String newTitle) {
    this._titleProject = newTitle;
  }

  @action
  createTeacherLocal(List<Teacher> teachers) {
    if (teacherLocal.isEmpty) {
      this.teacherLocal = ObservableList<Teacher>.of(teachers);
    }
  }

  @action
  updateCheckedTeacherLocal(Teacher teacher, int index) {
    if (!teacher.checked && msgErrorTeacher != "") {
      clearError(ErrorForm.Teacher);
    }
    teacherLocal[index] = Teacher(
        name: teacher.name,
        id: teacher.id,
        checked: !teacher.checked,
        image: teacher.image,
        links: teacher.links,
        projects: teacher.projects);
  }

  @action
  addParticipants(int size) {
    int lengthParticipants = participantsLocal.length;
    if (size < lengthParticipants) {
      int dif = lengthParticipants - size;
      while (dif != 0) {
        participantsLocal.removeLast();
        dif--;
      }
    } else if (size > lengthParticipants) {
      int dif = size - lengthParticipants;
      while (dif != 0) {
        participantsLocal.add("");
        dif--;
      }
    }
  }

  List<String> getParticipants() {
    List<String> participants = [];
    for (int i = 0; i < participantsLocal.length; i++) {
      if (participantsLocal[i] != "") {
        participants.add(participantsLocal[i]);
      }
    }
    return participants;
  }

  List<Teacher> getTeachers() {
    List<Teacher> teachers = [];
    for (int i = 0; i < teacherLocal.length; i++) {
      if (teacherLocal[i].checked) {
        teachers.add(teacherLocal[i]);
      }
    }
    return teachers;
  }

  generateMsgError(ErrorForm type, String msg) {
    switch (type) {
      case ErrorForm.Title:
        this._msgErrorTitle = msg;
        break;
      case ErrorForm.Image:
        this._msgErrorImage = msg;
        break;
      case ErrorForm.Content:
        this._msgErrorContent = msg;
        break;
      case ErrorForm.Teacher:
        this._msgErrorTeacher = msg;
        break;
      case ErrorForm.Participant:
        this._msgErrorParticipants = msg;
        break;
      case ErrorForm.ParticipantSize:
        this._msgErrorParticipantsSize = msg;
        break;
    }
  }

  clearError(ErrorForm type) {
    switch (type) {
      case ErrorForm.Title:
        this._msgErrorTitle = "";
        break;
      case ErrorForm.Image:
        this._msgErrorImage = "";
        break;
      case ErrorForm.Content:
        this._msgErrorContent = "";
        break;
      case ErrorForm.Teacher:
        this._msgErrorTeacher = "";
        break;
      case ErrorForm.Participant:
        this._msgErrorParticipants = "";
        break;
      case ErrorForm.ParticipantSize:
        this._msgErrorParticipantsSize = "";
        break;
    }
  }

  @action
  onChangedHtml(String? value) {
    this._htmlContent = value;
    if (htmlContent != "" && msgErrorContent != "") {
      clearError(ErrorForm.Content);
    }
  }

  @action
  changeValueParticipant(int index, String text) {
    participantsLocal[index] = text;
    if (text != "") {
      clearError(ErrorForm.ParticipantSize);
      clearError(ErrorForm.Participant);
    }
  }

  validateProject() {
    String err = "";
    if (titleProject == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (titleProject.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O titulo não ter mais de 40 caracteres.");
      err += "err2";
    } else {
      clearError(ErrorForm.Title);
    }
    if (pathImage!.path == "") {
      generateMsgError(ErrorForm.Image, "Selecione uma imagem titulo.");
      err += "err3";
    } else {
      clearError(ErrorForm.Image);
    }

    if (htmlContent == "") {
      generateMsgError(ErrorForm.Content, "O conteudo não pode estar vazio.");
      err += "err4";
    } else {
      clearError(ErrorForm.Content);
    }
    if (getTeachers().length == 0) {
      generateMsgError(
          ErrorForm.Teacher, "Você deve selecionar pelo menos um professor.");
      err += "err5";
    } else {
      clearError(ErrorForm.Teacher);
    }
    if (getParticipants().length == 0) {
      generateMsgError(
          ErrorForm.Participant, "Digite pelo menos um participante.");
      err += "err6";
    } else {
      clearError(ErrorForm.Participant);
    }
    if (err == "") {
      return true;
    } else {
      return false;
    }
  }

  validateParticipant(String? value) {
    if (int.tryParse(value!) != null) {
      int num = int.parse(value);
      if (num > 10) {
        generateMsgError(ErrorForm.ParticipantSize,
            "Só pode adicionar até 10 participantes.");
      } else {
        addParticipants(int.parse(value));
        clearError(ErrorForm.ParticipantSize);
        clearError(ErrorForm.Participant);
      }
    } else {
      generateMsgError(ErrorForm.ParticipantSize, "Digite um numero.");
    }
  }
}
