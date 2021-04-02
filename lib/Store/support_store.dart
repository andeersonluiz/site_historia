
import 'package:mobx/mobx.dart';
part 'support_store.g.dart';

class SupportStore = _SupportStoreBase with _$SupportStore;

abstract class _SupportStoreBase with Store {
  
  @observable
  bool _openProject=false;

  @observable
  bool _openQuads=false;

  @computed
  bool get openProject=>this._openProject;
  
  @computed
  bool get openQuads=>this._openQuads;

  @action
  updateOpen(String item){
    switch(item){
      case 'Projetos':
       _openProject=!_openProject;
       break;
      case 'Quadros':
        _openQuads=!_openQuads;
       break;
  }
  }
}
   
