import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Components/widget/listTeachers_component.dart';

class AboutPageDesktop extends StatefulWidget {
  @override
  _AboutPageDesktopState createState() => _AboutPageDesktopState();
}

class _AboutPageDesktopState extends State<AboutPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomText("Coordenação de História",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!),
        ),
        Divider(
          height: 1,
        ),
        Container(
          margin: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(
                      width: MediaQuery.of(context).size.width,
                      image:
                          "https://blog.unp.br/wp-content/uploads/2020/10/curso-de-historia.jpg",
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "O Centro Federal de Educação Tecnológica Celso Suckow da Fonseca (Cefet/RJ) teve sua origem em 1917 como Escola Normal de Artes e Ofícios Wenceslau Braz. Atualmente, é uma instituição federal de ensino que se compreende como um espaço público de formação humana, científica e tecnológica. Oferece cursos técnicos integrados ao ensino médio, subsequentes (pós-médio), tecnológicos, de graduação e de pós-graduação lato sensu e stricto sensu (mestrado e doutorado), nas modalidades presencial e a distância. O Cefet/RJ atua na tríade ensino, pesquisa e extensão e visa contribuir para a formação de profissionais e cidadãos bem preparados para o desenvolvimento econômico, humano e social do país.\n\nA coordenação de História do campus Maracanã, que hoje tem como professores efetivos: Álvaro Senra, André Guimarães Couto, Mariana Renou, Mário Luiz de Souza, Renato Lana Fernandez, Renilda Barreto, Samuel Oliveira, Thiago Rodrigues e Vanessa Brunow, busca contribuir para uma formação completa e integral dos alunos, lançando mão de diversos meios e possibilidades. Este site foi criado como resposta à uma reflexão de longo prazo dos membros da coordenação e da reivindicação de alguns por um espaço de trabalho coletivo, de natureza não-acadêmica, voltado para o aluno do ensino médio integrado. Este site pretende-se, assim, ser um espaço de produção, troca e divulgação de conhecimento; de interlocução entre os membros da coordenação de História do Maracanã, discentes, estagiários, docentes de outras áreas e unidades, comunidade escolar e público em geral. Antenados com os interesses dos nossos alunos e as novas maneiras de se comunicar, produzir e divulgar conhecimento, esperamos ser este um canal para efetivar e potencializar os processos de ensino-aprendizagem e de auxílio na contínua formação discente e docente.\n\nA contribuição de todos é fundamental para a implementação, enraizamento entre os alunos e continuidade. Sejam bem vindos e aproveitem!",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Container(margin: EdgeInsets.all(16.0), child: ListTeachers()),
        FooterDesktop()
      ],
    );
  }
}
