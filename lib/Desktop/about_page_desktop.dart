import 'package:flutter/material.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Desktop/widget/listTeachers_desktop.dart';

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
          child: Text(
            "Coordenação de História",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          height: 400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet ornare purus. Fusce accumsan diam ac mi blandit, auctor consequat quam cursus. Sed vestibulum ante sit amet ligula consequat, at pellentesque nisl eleifend. Suspendisse tempor hendrerit enim ut ultricies. Nunc ante velit, vehicula tempus neque eget, porttitor dignissim odio. Ut molestie dolor at ligula tempus fringilla. Etiam posuere risus enim, at tincidunt leo mollis nec. Praesent ullamcorper quam enim, tincidunt gravida augue feugiat nec. Mauris vulputate feugiat metus, non eleifend sem fringilla sed. Phasellus scelerisque rutrum tellus. Fusce sed urna vel tortor aliquet scelerisque. Curabitur finibus consequat libero vitae accumsan. Sed nibh felis, vehicula ut iaculis ut, aliquet non magna. Nam cursus blandit neque eu mollis. Nulla facilisi. Sed lacinia laoreet dapibus. Suspendisse volutpat, purus sed egestas tincidunt, turpis justo aliquet mi, vel molestie lacus lorem sed erat. Proin nisl tellus, finibus vel dui id, vulputate euismod arcu. Quisque at ex aliquet, volutpat lectus at, condimentum lacus. Mauris vel finibus risus. Pellentesque rutrum nibh imperdiet felis sagittis suscipit. Nunc vel euismod dui.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/test.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
        ListTeachers(),
        FooterDesktop()
      ],
    );
  }
}
