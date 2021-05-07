import 'package:flutter/material.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/listTeachers_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';

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
          child: Text(
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
        Center(child: CustomImage(height: 200, image: "assets/test.jpg")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "O Centro Federal de Educação Tecnológica Celso Suckow da Fonseca (Cefet/RJ) teve sua origem em 1917 como Escola Normal de Artes e Ofícios Wenceslau Braz. Atualmente, é uma instituição federal de ensino que se compreende como um espaço público de formação humana, científica e tecnológica. Oferece cursos técnicos integrados ao ensino médio, subsequentes (pós-médio), tecnológicos, de graduação e de pós-graduação lato sensu e stricto sensu (mestrado e doutorado), nas modalidades presencial e a distância. O Cefet/RJ atua na tríade ensino, pesquisa e extensão e visa contribuir para a formação de profissionais e cidadãos bem preparados para o desenvolvimento econômico, humano e social do país.\n\nA coordenação de História do campus Maracanã, que hoje tem como professores efetivos: Álvaro Senra, André Guimarães Couto, Mariana Renou, Mário Luiz de Souza, Renato Lana Fernandez, Renilda Barreto, Samuel Oliveira, Thiago Rodrigues e Vanessa Brunow, busca contribuir para uma formação completa e integral dos alunos, lançando mão de diversos meios e possibilidades. Este site foi criado como resposta à uma reflexão de longo prazo dos membros da coordenação e da reivindicação de alguns por um espaço de trabalho coletivo, de natureza não-acadêmica, voltado para o aluno do ensino médio integrado. Este site pretende-se, assim, ser um espaço de produção, troca e divulgação de conhecimento; de interlocução entre os membros da coordenação de História do Maracanã, discentes, estagiários, docentes de outras áreas e unidades, comunidade escolar e público em geral. Antenados com os interesses dos nossos alunos e as novas maneiras de se comunicar, produzir e divulgar conhecimento, esperamos ser este um canal para efetivar e potencializar os processos de ensino-aprendizagem e de auxílio na contínua formação discente e docente.\n\nA contribuição de todos é fundamental para a implementação, enraizamento entre os alunos e continuidade. Sejam bem vindos e aproveitem!",
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
