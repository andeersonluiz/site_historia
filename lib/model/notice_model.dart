
import 'package:intl/intl.dart';

class Notice{
  int id;
  String title;
  String subtitle;
  String tag;
  List<dynamic> imageContent;
  String imageHeader;
  String datePost;
  String content;
  int views;
  bool isTopHeader;
  Notice({required this.id,required this.title,required this.subtitle,required this.tag,required this.imageContent,required this.imageHeader,required this.datePost, 
  required this.content,required this.views,required this.isTopHeader});

  factory Notice.fromJson(Map<String, dynamic> json){
    final f =DateFormat("dd-MM-yyyy hh:mm");
  return Notice(
    id:json['id'],
    title:json['title'],
    subtitle:json['subtitle'],
    tag:json['tag'],
    imageContent:json['imageContent'],
    imageHeader:json['imageHeader'],
    datePost:f.format(DateTime.parse(json['datePost'].toDate().toString())),
    content:json['content'],
    views:json['views'],
    isTopHeader:json['isTopHeader']
  );
  
  }

  Map<String, dynamic> toJson()=>
  {
    'id':id,
    'title':title,
    'subtitle':subtitle,
    'tag':tag,
    'imageContent':imageContent,
    'imageHeader':imageHeader,
    'datePost':datePost,
    'content':content,
    'views':views,  
    'isTopHeader':isTopHeader
  };
}