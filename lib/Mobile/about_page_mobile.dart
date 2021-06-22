/// Widget responsável por exibir a página de Coordenação de história (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library AboutPageMobile;
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/listTeachers_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Support/globals_variables.dart';

/// Widget exibe um texto sobre a coordenação de história e a lista de professores através do
/// widget `ListTeachers()`.
class AboutPageMobile extends StatefulWidget {
  @override
  _AboutPageMobileState createState() => _AboutPageMobileState();
}

class _AboutPageMobileState extends State<AboutPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomText(
            "Coordenação de História",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Center(
            child: CustomImage(
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.contain,
                image:
                GlobalsVariables.scrDefaultImageAboutPage,)),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: CustomText(
            "O Centro Federal de Educação Tecnológica Celso Suckow da Fonseca (Cefet/RJ) teve sua origem em 1917 como Escola Normal de Artes e Ofícios Wenceslau Braz. Atualmente, é uma instituição federal de ensino que se compreende como um espaço público de formação humana, científica e tecnológica. Oferece cursos técnicos integrados ao ensino médio, subsequentes (pós-médio), tecnológicos, de graduação e de pós-graduação lato sensu e stricto sensu (mestrado e doutorado), nas modalidades presencial e a distância. O Cefet/RJ atua na tríade ensino, pesquisa e extensão e visa contribuir para a formação de profissionais e cidadãos bem preparados para o desenvolvimento econômico, humano e social do país.\n\nCoordenação de História é possível conhecer os professores que a integram, os projetos que a coordenação desenvolve e atua, ter acesso a questões de vestibular, indicações de blogs, sites, canais, filmes e documentários relacionados a disciplina, materiais desenvolvidos por professores, alunos, estagiários e monitores, notícias, entre outros. A ideia é que seja ferramenta capaz de despertar o interesse pela disciplina, suscitar debates fundamentais, auxiliar nos estudos e contribuir de maneiras diversas para os processos de ensino-aprendizagem.\n\nSejam bem vindos e aproveitem!",
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        ListTeachers(),
        FooterMobile()
      ],
    );
  }
}
