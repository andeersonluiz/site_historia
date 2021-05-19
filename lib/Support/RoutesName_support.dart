enum Pages {
  Home,
  About,
  Projects,
  Notices,
  Frames,
  Exam,
  Recomendations,
  Collection,
}

enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class RouteNames {
  static const String HOME = "/inicio";
  static const String ABOUT = "/coordenacao";
  static const String PROJECTS = "/projetos";
  static const String NOTICES = "/noticias";
  static const String FRAMES = "/quadros";
  static const String EXAM = "/vestibular";
  static const String RECOMMENDATIONS = "/recomendacoes";
  static const String COLLECTION = "/acervo";
  static const String ADMIN = "/admin";
  static const String ADMIN_PROJECTS = "/admin/projetos";
  static const String ADD_PROJECT = "/admin/projetos/adicionarProjeto";
  static const String UPDATE_PROJECT = "/admin/projetos/editarProjeto";
  static const String ADMIN_NOTICES = "/admin/noticias";
  static const String ADD_NOTICE = "/admin/noticias/adicionarNoticia";
  static const String UPDATE_NOTICE = "/admin/noticias/editarNoticia";
  static const String ADMIN_FRAMES = "/admin/quadros";
  static const String ADD_FRAME = "/admin/quadros/adicionarQuadro";
  static const String UPDATE_FRAME = "/admin/quadros/editarQuadro";
  static const String ADMIN_TEACHERS = "/admin/professores";
  static const String ADD_TEACHER = "/admin/professores/adicionarProfessor";
  static const String UPDATE_TEACHER = "/admin/professores/editarProfessor";
}
