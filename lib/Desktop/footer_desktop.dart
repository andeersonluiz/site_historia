import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Theme/ThemeConfig.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: ThemeConfig.brown,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        fillColor: Colors.white),
                    Column(
                      children: [Text('Endereço'), Text('Local')],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                        onPressed: null,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                        ),
                        fillColor: Colors.white),
                    Text('Telefone'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                        fillColor: Colors.white),
                    Text('email@gmail.com'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sobre nós',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  width: 500,
                  child: Text(
                    'dapskdoapkdopaskdopa kdopas kodaspk opasdkoapspk dopask dopaskdopaskdopak opapsk dpoasdkopa sk dsadk aospkd askdosapk daopskd opsak dopas kdopsak dopsak opsadk osapko',
                    maxLines: 5,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.facebookSquare,
                            size: 30,
                          )),
                    ),
                    IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          FontAwesomeIcons.instagramSquare,
                          size: 30,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
