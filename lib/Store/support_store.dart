import 'package:mobx/mobx.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/model/teacher_model.dart';
part 'support_store.g.dart';

class SupportStore = _SupportStoreBase with _$SupportStore;

abstract class _SupportStoreBase with Store {
  @observable
  String _pathImage = "";

  @observable
  String _titleProject = "";

  @computed
  String get pathImage => this._pathImage;

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
  updatePath(String newPath) {
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
  }

  @action
  changeValueParticipant(int index, String text) {
    participantsLocal[index] = text;
  }
}
