/// Store responsável pelo gerenciamento e validação dos formulários, usado em adicionar/atualizar Projetos, Notícias, Quadros e Professores.
///
/// {@category Store}
// ignore: library_names
library SupportStore;
import 'package:file_picker/file_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/errorHander_support.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:html/parser.dart';
import 'package:site_historia/Support/DiffPackage/dmp_class.dart';
import 'package:site_historia/Support/DiffPackage/diff_class.dart';

part 'support_store.g.dart';

class SupportStore = _SupportStoreBase with _$SupportStore;

abstract class _SupportStoreBase with Store {
  /// Usado em projetos, notícias e quadros e usado como nome em professor.
  @observable
  String _title = "";

  /// Usado em notícias e quadros.
  @observable
  String _subtitle = "";

  /// Usado em notícias para definir o tipo de notícia.
  @observable
  String _type = "Podcast";

  /// Usado em notícias para definir a tag da notícia.
  @observable
  String _tag = "Podcast";

  /// Usado em notícias para definir se a notícia aparece ou não na página principal.
  @observable
  bool _isTopHeader = false;

  /// Usado em professores para gerenciar o link digitado.
  @observable
  String _link = "";

  /// Usado em notícias e quadros para gerenciar o arquivo de áudio.
  @observable
  PlatformFile _audioFile = PlatformFile(name:"",size:0);

  /// Usado em notícias e quadros para gerenciar o arquivo de vídeo.
  @observable
  PlatformFile _videoFile = PlatformFile(name:"",size:0);

  /// Usado em projeto, notícias, quadros e professores para gerenciar a imagem.
  @observable
  PickedFile? _pathImage = PickedFile("");

  /// Usado em quadros para gerenciar a subtítulo da imagem.
  @observable
  String? _subtitleImage = "";

  /// Usado em projetos, notícias e quadros para gerenciar o conteúdo de texto.
  @observable
  String? _htmlContent = "";

  /// Usado em quadros para gerenciar o texto de vídeo selecionado.
  @observable
  String? _urlPopUp = "";

  /// Utilizada para fazer o controle quando um conteúdo é excluído.
  @observable
  bool? _isLoading = false;

  /// Armazena os professores para ser utilizados nas checkboxes em projetos.
  @observable
  ObservableList<Teacher> teacherLocal = ObservableList<Teacher>();

  /// Armazena os projetos para ser utilizados nas checkboxes em professores.
  @observable
  ObservableList<Project> projectLocal = ObservableList<Project>();

  /// Armazena os participantes para ser utilizados nas checkboxes em projetos.
  @observable
  ObservableList<String> participantsLocal = ObservableList<String>();

  ///getter title
  @computed
  String get title => this._title;

  ///getter subtitle
  @computed
  String get subtitle => this._subtitle;

  ///getter type
  @computed
  String get type => this._type;

  ///getter tag
  @computed
  String get tag => this._tag;

  ///getter isTopHeader
  @computed
  bool get isTopHeader => this._isTopHeader;

  ///getter link
  @computed
  String get link => this._link;

  ///getter pathImage
  @computed
  PickedFile? get pathImage => this._pathImage;

  ///getter subtitleImage
  @computed
  String? get subtitleImage => this._subtitleImage;

  ///getter audioFile
  @computed
  PlatformFile? get audioFile => this._audioFile;

  ///getter videoFile
  @computed
  PlatformFile? get videoFile => this._videoFile;

  ///getter htmlContent
  @computed
  String? get htmlContent => this._htmlContent;

  ///getter urlPopUp
  @computed
  String? get urlPopUp => this._urlPopUp;

  ///getter isLoading
  @computed
  bool? get isLoading => this._isLoading;

  ///mensagem de erro de título
  @observable
  String _msgErrorTitle = "";

  ///mensagem de erro de subtítulo
  @observable
  String _msgErrorSubtitle = "";

  ///mensagem de erro de imagem
  @observable
  String _msgErrorImage = "";

  ///mensagem de erro de áudio
  @observable
  String _msgErrorAudio = "";

  ///mensagem de erro de conteúdo
  @observable
  String _msgErrorContent = "";

  ///mensagem de erro de professor
  @observable
  String _msgErrorTeacher = "";

  ///mensagem de erro de projeto
  @observable
  String _msgErrorProject = "";

  ///mensagem de erro de participantes
  @observable
  String _msgErrorParticipants = "";

  ///mensagem de erro de tamanho de participantes
  @observable
  String _msgErrorParticipantsSize = "";

  ///mensagem de erro quando abre o pop up de inserir vídeo.
  @observable
  String _msgErrorPopUp = "";

  ///getter msgErrorTitle
  @computed
  String get msgErrorTitle => this._msgErrorTitle;

  ///getter msgErrorSubTitle
  @computed
  String get msgErrorSubTitle => this._msgErrorSubtitle;

  ///getter msgErrorImage
  @computed
  String get msgErrorImage => this._msgErrorImage;

  ///getter msgErrorAudio
  @computed
  String get msgErrorAudio => this._msgErrorAudio;

  ///getter msgErrorContent
  @computed
  String get msgErrorContent => this._msgErrorContent;

  ///getter msgErrorTeacher
  @computed
  String get msgErrorTeacher => this._msgErrorTeacher;

  ///getter msgErrorProject
  @computed
  String get msgErrorProject => this._msgErrorProject;

  ///getter msgErrorParticipants
  @computed
  String get msgErrorParticipants => this._msgErrorParticipants;

  ///getter msgErrorParticipantsSize
  @computed
  String get msgErrorParticipantsSize => this._msgErrorParticipantsSize;

  ///getter msgErrorPopUp
  @computed
  String get msgErrorPopUp => this._msgErrorPopUp;

  /// Controle para verificar se o menu vertical na página do admin está expandido.
  @observable
  bool verticalIsMax = true;

  /// Controle para obter o conteúdo de texto antes de ser alterado.
  String afterContent = "";

  /// Controle para validar as imagens que são inseridas no banco de dados durante a criação.
  bool created = false;

  /// Controle para validar as imagens que são inseridas no banco de dados durante a atualização.
  bool updated = false;

  /// Atualiza a variável title.
  @action
  updateTitle(String newTitle) {
    if (newTitle != "") {
      clearError(ErrorForm.Title);
    }
    this._title = newTitle;
  }

  /// Atualiza a variável subtitle.
  @action
  updateSubTitle(String newSubtitle) {
    if (newSubtitle != "") {
      clearError(ErrorForm.SubTitle);
    }
    this._subtitle = newSubtitle;
  }

  /// Atualiza a variável type.
  @action
  updateType(String newType) {
    this._type = newType;
  }

  /// Atualiza a variável tag.
  @action
  updateTag(String newTag) {
    this._tag = newTag;
  }

  /// Atualiza a variável isTopHeader.
  @action
  updateTopHeader(bool newTopHeader) {
    this._isTopHeader = newTopHeader;
  }

  /// Atualiza a variável link.
  @action
  updateLink(String newLink) {
    this._link = newLink;
  }

  /// Atualiza a variável audioFile.
  @action
  updateAudio(PlatformFile? newAudio) {
    if (newAudio!.name != "") {
      clearError(ErrorForm.Audio);
    }
    this._audioFile = newAudio;
  }

  /// Atualiza a variável videoFile.
  @action
  updateVideo(PlatformFile? newVideo) {
    if (newVideo!.name != "") {
      this._msgErrorPopUp = "";
    }
    this._videoFile = newVideo;
  }

  /// Atualiza a variável pathImage.
  @action
  updatePath(PickedFile? newPath) {
    if (newPath!.path != "") {
      clearError(ErrorForm.Image);
    }
    this._pathImage = newPath;
  }

  /// Atualiza a variável subtitleImage.
  @action
  updateSubtitleImage(String? newSubtitle) {
    this._subtitleImage = newSubtitle;
  }

  /// Atualiza a variável htmlContent e remove a imagem do banco de dados caso ela seja removida do conteúdo.
  @action
  updateContent(dynamic store, String? value, HtmlEditorController? controller,
      String? id) async {
    if (htmlContent != value) {
      List<Diff> difference =
      DiffMatchPatch().diff_main(this.afterContent, value);
      difference.forEach((Diff e) async {
        if (e.operation == Operation.delete && e.text!.contains("img")) {
          if (e.text!.substring(e.text!.length - 1) == "<") {
            var sub = e.text!.substring(0, e.text!.length - 1);
            String result = "<" + sub;
            var document = parse(result);
            var element = document.getElementsByTagName("img")[0];
            await store.removeFilename(
                element.attributes['data-filename']!, id);
          } else {
            var document = parse(e.text!);
            var element = document.getElementsByTagName("img")[0];
            await store.removeFilename(
                element.attributes['data-filename']!, id);
          }
        }
      });
      this._htmlContent = value!.replaceAll("video", "iframe");
    }
    if (htmlContent != "" && msgErrorContent != "") {
      clearError(ErrorForm.Content);
    }
  }

  /// Atualiza a variável afterContent.
  updateAfterContent(String? content) {
    this.afterContent = content!;
  }

  /// Atualiza a variável urlPopUp.
  @action
  updateUrlPopUp(String newUrl) {
    if (newUrl != "") {
      this._msgErrorPopUp = "";
    }
    this._urlPopUp = newUrl;
  }

  /// Atualiza a variável isLoading.
  @action
  setLoading(bool value) {
    this._isLoading = value;
  }

  /// Atualiza a variável verticalIsMax.
  @action
  changeVerticalBar() {
    this.verticalIsMax = !this.verticalIsMax;
  }

  /// Obtém os professores localmente e verifica se eles estão com o checkbox selecionado através da variável booleana `checked`.
  List<Teacher> getTeachers() {
    List<Teacher> teachers = [];
    for (int i = 0; i < teacherLocal.length; i++) {
      if (teacherLocal[i].checked) {
        teachers.add(teacherLocal[i]);
      }
    }
    return teachers;
  }

  /// inicializa a variável teacherLocal, onde verifica se há algum professor selecionado para carregar os dados.
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
      teachers.forEach((teachers) => teachers.checked = false);

      this.teacherLocal = ObservableList.of(teachers);
    }
  }

  /// Inicializa a variável projectLocal, onde verifica se há algum projeto selecionado para carregar os dados.
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
      projects.forEach((project) => project.checked = false);
      this.projectLocal = ObservableList.of(projects);
    }
  }

  /// Atualiza a variável msgErrorTeachers.
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

  /// Atualiza a variável msgErrorProject.
  @action
  updateProjectLocal(Project project, int index) {
    if (msgErrorProject != "") {
      clearError(ErrorForm.Project);
    }
    projectLocal[index] = Project(
        id: project.id,
        datePost: project.datePost,
        imageHeader: project.imageHeader,
        teachers: project.teachers,
        name: project.name,
        author: project.author,
        content: project.content,
        participants: project.participants,
        checked: !project.checked);
  }
  /// Obtém os projetos localmente e verifica se eles estão com o checkbox selecionado através da variável booleana `checked`.

  List<Project> getProjects() {
    List<Project> projects = [];
    for (int i = 0; i < projectLocal.length; i++) {
      if (projectLocal[i].checked) {
        projects.add(projectLocal[i]);
      }
    }
    return projects;
  }

  /// gerencia a adição/remoção em participantsLocal de acordo com o tamanho do vetor escolhido pelo usuário
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

  /// Obtém todos os participantes que não estão com o nome em branco.
  List<String> getParticipantsLocalFilled() {
    List<String> participants = [];
    for (int i = 0; i < participantsLocal.length; i++) {
      if (participantsLocal[i] != "") {
        participants.add(participantsLocal[i]);
      }
    }
    return participants;
  }

  /// Atualiza um item do vetor participantsLocal.
  @action
  updateParticipants(String text, int index) {
    participantsLocal[index] = text;
    if (text != "" && msgErrorParticipants != "") {
      clearError(ErrorForm.ParticipantSize);
      clearError(ErrorForm.Participant);
    }
  }

  /// Gera a mensagem de erro de acordo com o enum `ErrorForm`.
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

  /// Remove a mensagem de erro de acordo com o enum `ErrorForm`.
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
        this._msgErrorProject = "";
        break;
    }
  }

  /// Carrega os dados anteriores para a atualização de um projeto.
  loadInitialDataProject(Project project) {
    updatePath(PickedFile(project.imageHeader));
    updateTitle(project.name);
    updateContent(null, project.content, null, project.id.toString());
    participantsLocal = ObservableList.of(
        List.generate(project.participants.length, (index) => ""));
    for (int i = 0; i < project.participants.length; i++) {
      updateParticipants(project.participants[i].name, i);
    }
  }

  /// Carrega os dados anteriores para a atualização de uma notícia.
  loadInitialDataNotice(Notice notice) {
    updateTitle(notice.title);
    updateSubTitle(notice.subtitle);
    updateType(notice.type);
    updateTag(notice.tag);
    updateTopHeader(notice.isTopHeader);
    updateAudio(PlatformFile(name: notice.audio[0], size: 0));
    updatePath(PickedFile(notice.thumb));
    updateContent(null, notice.content, null, notice.id.toString());
  }

  /// Carrega os dados anteriores para a atualização de um quadro.
  loadInitialDataFrame(Frame frame) {
    updateTitle(frame.title);
    updateSubTitle(frame.subtitle);
    updatePath(PickedFile(frame.imageHeader));
    updateSubtitleImage(frame.subtitleImage);
    updateAudio(PlatformFile(name: frame.urlAudio[0], size: 0));
    updateVideo(PlatformFile(name: frame.urlVideo[0], size: 0));
    updateContent(null, frame.content, null, frame.id.toString());
  }

  /// Carrega os dados anteriores para a atualização de um professor.

  loadInitialDataTeacher(Teacher teacher) {
    updateTitle(teacher.name);
    updateLink(teacher.link);
    updatePath(PickedFile(teacher.image));
  }

  /// Valida a parte 1/2 da página de projeto versão celular.
  validateProjectMobileTab1() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O título não ter mais de 40 caracteres.");
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
      generateMsgError(ErrorForm.Content, "O conteúdo não pode estar vazio.");
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

  /// Valida a parte 2/2 da página de projeto versão celular.
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

  /// Valida o projeto para versão computador.
  validateProjectDesktop() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O título não ter mais de 40 caracteres.");
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

  /// Valida a notícia.
  validateNotice() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O título não ter mais de 40 caracteres.");
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
      if (audioFile!.name == "") {
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

  /// Valida o participante dentro da seção de adicionar/remover Projetos.
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
      generateMsgError(ErrorForm.ParticipantSize, "Digite um número.");
    }
  }

  /// Valida o quadro.
  validateFrame() {
    String err = "";
    if (title == "") {
      generateMsgError(ErrorForm.Title, "O titulo não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(
          ErrorForm.Title, "O título não ter mais de 40 caracteres.");
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

  /// Valida o popUp para a inserção de vídeo.
  validatePopUp() {
    if (urlPopUp == "" && videoFile!.name == "") {
      this._msgErrorPopUp = "Selecione um tipo.";
    } else if (urlPopUp != "" && videoFile!.name != "") {
      this._msgErrorPopUp = "Selecione apenas um tipo.";
    } else {
      return "";
    }
  }

  /// Valida um professor.
  validateTeacher() {
    String err = "";
    if (title == "") {
      generateMsgError(
          ErrorForm.Title, "O Nome do professor não pode ser vazio.");
      err += "err1";
    } else if (title.length > 40) {
      generateMsgError(ErrorForm.Title,
          "O nome do professor não ter mais de 40 caracteres.");
      err += "err2";
    } else {
      clearError(ErrorForm.Title);
    }

    if (pathImage!.path == "") {
      generateMsgError(
          ErrorForm.Image, "Selecione uma imagem para o professor.");
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

  /// Reseta os valores da classe para o valores padrão.
  clearData() {
    _pathImage = PickedFile("");
    _subtitleImage = "";
    _title = "";
    _subtitle = "";
    _tag = "Podcast";
    _type = "Podcast";
    _link = "";
    _audioFile = PlatformFile(name:"",size: 0);
    _videoFile = PlatformFile(name:"",size: 0);
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
    created = false;
  }
}


