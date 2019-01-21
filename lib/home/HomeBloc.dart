import 'package:programacaoreativa/home/GithubService.dart';
import 'package:programacaoreativa/models/SearchResult.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final GithubService _githubApi = new GithubService();

  final _searchController = new BehaviorSubject<String>();
  Observable<String> get searchFlux => _searchController.stream;
  Sink<String> get searchEvent => _searchController.sink;

  Observable<SearchResult> listItems;

  HomeBloc() {
    listItems = searchFlux
        .distinct()
        .debounce(Duration(milliseconds: 300))
        .asyncMap(_githubApi.search)
        .switchMap((dados) => Observable.just(dados));
  }

  void dispose(){
    _searchController?.close();
  }
}
