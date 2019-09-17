import 'package:rxdart/rxdart.dart';

class LoadingBloc{
  int initCount=0;
  BehaviorSubject<int>_subject;

  LoadingBloc({this.initCount}){
    _subject=new BehaviorSubject<int>.seeded(this.initCount);
  }
  Observable<int> get counterObservable=> _subject.stream;

  void increment(){
    initCount++;
    _subject.sink.add(initCount);
  }
  void dispose(){
    _subject.close();
  }
}