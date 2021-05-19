import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
part 'support_store.g.dart';

class SupportStore = _SupportStoreBase with _$SupportStore;

abstract class _SupportStoreBase with Store {
  @observable
  String _title = "";

  @observable
  String _subtitle = "";

  @observable
  String _type = "Podcast";

  @observable
  String _tag = "Podcast";

  @observable
  bool _isTopHeader = false;

  @observable
  String _link = "";

  @observable
  PlatformFile _audioFile = PlatformFile();

  @observable
  PlatformFile _videoFile = PlatformFile();

  @observable
  PickedFile? _pathImage = PickedFile("");

  @observable
  String? _subtitleImage = "";

  @observable
  String? _htmlContent = "";

  @observable
  String? _urlPopUp = "";

  @observable
  bool? _isLoading = false;

  @observable
  ObservableList<Teacher> teacherLocal = ObservableList<Teacher>();

  @observable
  ObservableList<Project> projectLocal = ObservableList<Project>();

  @observable
  ObservableList<String> participantsLocal = ObservableList<String>();

  @computed
  String get title => this._title;

  @computed
  String get subtitle => this._subtitle;

  @computed
  String get type => this._type;

  @computed
  String get tag => this._tag;

  @computed
  bool get isTopHeader => this._isTopHeader;

  @computed
  String get link => this._link;

  @computed
  PickedFile? get pathImage => this._pathImage;

  @computed
  String? get subtitleImage => this._subtitleImage;

  @computed
  PlatformFile? get audioFile => this._audioFile;

  @computed
  PlatformFile? get videoFile => this._videoFile;

  @computed
  String? get htmlContent => this._htmlContent;

  @computed
  String? get urlPopUp => this._urlPopUp;

  @computed
  bool? get isLoading => this._isLoading;

  @observable
  String _msgErrorTitle = "";

  @observable
  String _msgErrorSubtitle = "";

  @observable
  String _msgErrorTopHeader = "";

  @observable
  String _msgErrorImage = "";

  @observable
  String _msgErrorAudio = "";

  @observable
  String _msgErrorContent = "";

  @observable
  String _msgErrorTeacher = "";

  @observable
  String _msgErrorProject = "";

  @observable
  String _msgErrorParticipants = "";

  @observable
  String _msgErrorParticipantsSize = "";

  @observable
  String _msgErrorPopUp = "";

  @computed
  String get msgErrorTitle => this._msgErrorTitle;

  @computed
  String get msgErrorSubTitle => this._msgErrorSubtitle;

  @computed
  String get msgErrorTopHeader => this._msgErrorTopHeader;

  @computed
  String get msgErrorImage => this._msgErrorImage;

  @computed
  String get msgErrorAudio => this._msgErrorAudio;

  @computed
  String get msgErrorContent => this._msgErrorContent;

  @computed
  String get msgErrorTeacher => this._msgErrorTeacher;

  @computed
  String get msgErrorProject => this._msgErrorProject;

  @computed
  String get msgErrorParticipants => this._msgErrorParticipants;

  @computed
  String get msgErrorParticipantsSize => this._msgErrorParticipantsSize;

  @computed
  String get msgErrorPopUp => this._msgErrorPopUp;

  @observable
  bool verticalIsMax = true;

  @action
  updateTitle(String newTitle) {
    if (newTitle != "") {
      clearError(ErrorForm.Title);
    }
    this._title = newTitle;
  }

  @action
  updateSubTitle(String newSubtitle) {
    if (newSubtitle != "") {
      clearError(ErrorForm.SubTitle);
    }
    this._subtitle = newSubtitle;
  }

  @action
  updateType(String newType) {
    this._type = newType;
  }

  @action
  updateTag(String newTag) {
    this._tag = newTag;
  }

  @action
  updateTopHeader(bool newTopHeader) {
    this._isTopHeader = newTopHeader;
  }

  @action
  updateLink(String newLink) {
    this._link = newLink;
  }

  @action
  updateAudio(PlatformFile? newAudio) {
    if (newAudio!.name != null) {
      clearError(ErrorForm.Audio);
    }
    this._audioFile = newAudio;
  }

  @action
  updateVideo(PlatformFile? newVideo) {
    if (newVideo!.name != null) {
      this._msgErrorPopUp = "";
    }
    this._videoFile = newVideo;
  }

  @action
  updatePath(PickedFile? newPath) {
    if (newPath!.path != "") {
      clearError(ErrorForm.Image);
    }
    this._pathImage = newPath;
  }

  @action
  updateSubtitleImage(String? newSubtitle) {
    this._subtitleImage = newSubtitle;
  }

  @action
  updateContent(String? value) async {
    if (htmlContent != value) {
      this._htmlContent = value!.replaceAll("video", "iframe");
    }
    if (htmlContent != "" && msgErrorContent != "") {
      clearError(ErrorForm.Content);
    }
  }

  @action
  updateUrlPopUp(String newUrl) {
    if (newUrl != "") {
      this._msgErrorPopUp = "";
    }
    this._urlPopUp = newUrl;
  }

  @action
  setLoading(bool value) {
    this._isLoading = value;
  }

  @action
  changeVerticalBar() {
    this.verticalIsMax = !this.verticalIsMax;
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

  @action
  createTeacherLocal(List<Teacher> teachers, Project? project) {
    if (project != null && teacherLocal.isEmpty) {
      teachers.forEach((teacher) {
        bool contains = false;
        project.teachers.forEach((projTeacher) {
          if (teacher.id == projTeacher.id) {
            teacher.checked = true;
            this.teacherLocal.add(teacher);
            contains = true;
            return;
          }
        });
        if (!contains) {
          teacher.checked = false;
          this.teacherLocal.add(teacher);
        }
      });
    } else if (teacherLocal.isEmpty) {
      teachers.forEach((teachers)=>teachers.checked=false);

      this.teacherLocal = ObservableList.of(teachers);
    }
  }

  @action
  createProjectLocal(List<Project> projects, Teacher? teacher) {
    if (teacher != null && projectLocal.isEmpty) {
      projects.forEach((project) {
        bool contains = false;
        project.teachers.forEach((projTeacher) {
          if (teacher.id == projTeacher.id) {
            project.checked = true;
            this.projectLocal.add(project);
            contains = true;
            return;
          }
        });
        if (!contains) {
          project.checked = false;
          this.projectLocal.add(project);
        }
      });
    } else if (projectLocal.isEmpty) {
      projects.forEach((project)=>project.checked=false);
      this.projectLocal = ObservableList.of(projects);
    }
  }


  @action
  updateTeacherLocal(Teacher teacher, int index) {
    if (msgErrorTeacher != "") {
      clearError(ErrorForm.Teacher);
    }
    teacherLocal[index] = Teacher(
        name: teacher.name,
        id: teacher.id,
        checked: !teacher.checked,
        image: teacher.image,
        link: teacher.link,
        projects: teacher.projects);
  }

  @action
  updateProjectLocal(Project project, int index) {
    if (msgErrorProject != "") {
      clearError(ErrorForm.Project);
    }
    projectLocal[index] = Project(id: project.id,
        datePost:  project.datePost, imageHeader: project.imageHeader,
        teachers:  project.teachers, name:  project.name, author:  project.author,
        content:  project.content, participants:  project.participants,
    checked: !project.checked);
  }

  List<Project> getProjects() {
    List<Project> projects = [];
    for (int i = 0; i < projectLocal.length; i++) {
      if (projectLocal[i].checked) {
        projects.add(projectLocal[i]);
      }
    }
    return projects;
  }

  @action
  addParticipants(int size) {
    int lengthParticipants = participantsLocal.length;
    if (size < lengthParticipants) {
      int dif = lengthParticipants - size;
      while (dif != 0) {
        this.participantsLocal.removeLast();
        dif--;
      }
    } else if (size > lengthParticipants) {
      int dif = size - lengthParticipants;
      while (dif != 0) {
        this.participantsLocal.add("");
        dif--;
      }
    }
  }

  List<String> getParticipantsLocalFilled() {
    List<String> participants = [];
    for (int i = 0; i < participantsLocal.length; i++) {
      if (participantsLocal[i] != "") {
        participants.add(participantsLocal[i]);
      }
    }
    return participants;
  }

  @action
  updateParticipants(String text, int index) {
    participantsLocal[index] = text;
    if (text != "" && msgErrorParticipants != "") {
      clearError(ErrorForm.ParticipantSize);
      clearError(ErrorForm.Participant);
    }
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
      case ErrorForm.SubTitle:
        this._msgErrorSubtitle = msg;
        break;
      case ErrorForm.Audio:
        this._msgErrorAudio = msg;
        break;
      case ErrorForm.Project:
        this._msgErrorProject = msg;
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
      case ErrorForm.SubTitle:
        this._msgErrorSubtitle = "";
        break;
      case ErrorForm.Audio:
        this._msgErrorAudio = "";
        break;
      case ErrorForm.Project:
        this._msgErrorProject="";
        break;
    }
  }

  loadInitialDataProject(Project project) {
    updatePath(PickedFile(project.imageHeader));
    updateTitle(project.name);
    updateContent(project.content);
    participantsLocal = ObservableList.of(
        List.generate(project.participants.length, (index) => ""));
    for (int i = 0; i < project.participants.length; i++) {
      updateParticipants(project.participants[i].name, i);
    }
  }

  loadInitialDataNotice(Notice notice) {
    updateTitle(notice.title);
    updateSubTitle(notice.subtitle);
    updateType(notice.type);
    updateTag(notice.tag);
    updateAudio(PlatformFile(name: notice.audio[0]));
    updatePath(PickedFile(notice.thumb));
    updateContent(notice.content);
  }

  loadInitialDataFrame(Frame frame) {
    updateTitle(frame.title);
    updateSubTitle(frame.subtitle);
    updatePath(PickedFile(frame.imageHeader));
    updateSubtitleImage(frame.subtitleImage);
    updateAudio(PlatformFile(name: frame.urlAudio[0]));
    updateVideo(PlatformFile(name: frame.urlVideo[0]));
    updateContent(frame.content);
  }

  loadInitialDataTeacher(Teacher teacher) {
    updateTitle(teacher.name);
    updateLink(teacher.link);
    updatePath(PickedFile(teacher.image));
  }


  validateProjectMobileTab1() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
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

      this._htmlContent = htmlContent!.replaceAll("font-family", "");
      clearError(ErrorForm.Content);
    }
    if (getTeachers().length == 0) {
      generateMsgError(
          ErrorForm.Teacher, "Você deve selecionar pelo menos um professor.");
      err += "err5";
    } else {
      clearError(ErrorForm.Teacher);
    }

    if (err == "") {
      return true;
    } else {
      return false;
    }
  }

  validateProjectMobileTab2() {
    String err = "";
    if (getParticipantsLocalFilled().length == 0) {
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

  validateProjectDesktop() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
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
      this._htmlContent = htmlContent!.replaceAll("font-family", "");
      clearError(ErrorForm.Content);
    }
    if (getTeachers().length == 0) {
      generateMsgError(
          ErrorForm.Teacher, "Você deve selecionar pelo menos um professor.");
      err += "err5";
    } else {
      clearError(ErrorForm.Teacher);
    }
    if (getParticipantsLocalFilled().length == 0) {
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

  validateNotice() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O titulo não ter mais de 40 caracteres.");
      err += "err2";
    } else {
      clearError(ErrorForm.Title);
    }

    if (subtitle == "") {
      generateMsgError(ErrorForm.SubTitle, "O subtítulo não pode ser vazio.");
      err += "err3";
    } else if (subtitle.length > 100) {
      generateMsgError(
          ErrorForm.SubTitle, "O subtítulo não ter mais de 50 caracteres.");
      err += "err4";
    } else {
      clearError(ErrorForm.SubTitle);
    }

    if (pathImage!.path == "") {
      generateMsgError(ErrorForm.Image, "Selecione uma imagem titulo.");
      err += "err5";
    } else {
      clearError(ErrorForm.Image);
    }

    if (htmlContent == "") {
      generateMsgError(ErrorForm.Content, "O conteudo não pode estar vazio.");
      err += "err6";
    } else {
      this._htmlContent = htmlContent!.replaceAll("font-family", "");

      clearError(ErrorForm.Content);
    }

    if (type == "Podcast") {
      if (audioFile!.name == null) {
        generateMsgError(ErrorForm.Audio, "Insira o audio do podcast.");
        err += "err7";
      } else {
        clearError(ErrorForm.Audio);
      }
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

  validateFrame() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O titulo não ter mais de 40 caracteres.");
      err += "err2";
    } else {
      clearError(ErrorForm.Title);
    }

    if (subtitle == "") {
      generateMsgError(ErrorForm.SubTitle, "O subtítulo não pode ser vazio.");
      err += "err3";
    } else if (subtitle.length > 100) {
      generateMsgError(
          ErrorForm.SubTitle, "O subtítulo não ter mais de 50 caracteres.");
      err += "err4";
    } else {
      clearError(ErrorForm.SubTitle);
    }

    if (pathImage!.path == "") {
      generateMsgError(ErrorForm.Image, "Selecione uma imagem titulo.");
      err += "err5";
    } else {
      clearError(ErrorForm.Image);
    }

    if (htmlContent == "") {
      generateMsgError(ErrorForm.Content, "O conteudo não pode estar vazio.");
      err += "err6";
    } else {
      this._htmlContent = htmlContent!.replaceAll("font-family", "");

      clearError(ErrorForm.Content);
    }

    if (err == "") {
      return true;
    } else {
      return false;
    }
  }

  validatePopUp() {
    if (urlPopUp == "" && videoFile!.name == null) {
      this._msgErrorPopUp = "Selecione um tipo.";
    } else if (urlPopUp != "" && videoFile!.name != null) {
      this._msgErrorPopUp = "Selecione apenas um tipo.";
    } else {
      return "";
    }

  }

  validateTeacher(){
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O Nome do professor não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O nome do professor não ter mais de 40 caracteres.");
      err += "err2";
    } else {
      clearError(ErrorForm.Title);
    }

    if (pathImage!.path == "") {
      generateMsgError(ErrorForm.Image, "Selecione uma imagem para o professor.");
      err += "err5";
    } else {
      clearError(ErrorForm.Image);
    }
    if (getProjects().length == 0) {
      generateMsgError(
          ErrorForm.Project, "Você deve selecionar pelo menos um projeto.");
      err += "err5";
    } else {
      clearError(ErrorForm.Project);
    }

    if (err == "") {
      return true;
    } else {
      return false;
    }
  }

  clearData() {
    _pathImage = PickedFile("");
    _subtitleImage = "";
    _title = "";
    _subtitle = "";
    _tag = "Podcast";
    _type = "Podcast";
    _link = "";
    _audioFile = PlatformFile();
    _videoFile = PlatformFile();
    _urlPopUp = "";
    teacherLocal = ObservableList<Teacher>();
    projectLocal = ObservableList<Project>();
    participantsLocal = ObservableList<String>();
    _msgErrorParticipants = "";
    _msgErrorParticipantsSize = "";
    _msgErrorTitle = "";
    _msgErrorImage = "";
    _msgErrorContent = "";
    _msgErrorTeacher = "";
    _htmlContent = "";
  }
}
