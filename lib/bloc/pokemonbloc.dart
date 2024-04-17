// PokemonBloc which will connect our UI code to the PokemonService class.

// first create an event called FetchPokemonEvent.
// An event is nothing but a simple class that when passed to our bloc will indicate that UI is requesting the pokemon data list 😊

import 'package:bloctest/models/pokemonmodel.dart';
import 'package:bloctest/services/pokemonservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchPokemonEvent {}

//state
abstract class PokemonState {}

// Bloc maps events to states
class PokemonInitialState extends PokemonState {
  //to pass in the super constructor of PokemonBloc
}

class PokemonLoadingState extends PokemonState {}

class PokemonSuccessState extends PokemonState {
  final List<Pokemon> pokemonList;
  PokemonSuccessState({required this.pokemonList});
}

class PokemonErrorState extends PokemonState {
  final String errorMeassage;
  PokemonErrorState({required this.errorMeassage});
}

class PokemanBloc extends Bloc<FetchPokemonEvent, PokemonState> { // two generics EVENT and STATE
  PokemanBloc() : super(PokemonInitialState()) {
    on<FetchPokemonEvent>((event, emit) async {//method is called to register a handler for the FetchPokemonEvent
      emit(PokemonLoadingState());
      try {
        final pokeList = await PokemonService.fetchPokemonList();
        emit(PokemonSuccessState(pokemonList: pokeList));
      } catch (e) {
        emit(PokemonErrorState(errorMeassage: e.toString()));
      }
    });
  }
}
