import 'package:bloctest/bloc/pokemonbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    //The BlocProvider widget takes an argument called create which creates the bloc when the build runs for the first time.
    // Inside create we are creating PokemonBloc object and using double dot ‘..’ notation to call add() function on the created instance.
    return BlocProvider(
      create: (context) => PokemanBloc()..add(FetchPokemonEvent()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Test BLoC"),
            actions: [
              BlocBuilder<PokemanBloc, PokemonState>(builder: (context, _) {
                return IconButton(
                    onPressed: () {
                      final bloc = BlocProvider.of<PokemanBloc>(context);
                      bloc.add(FetchPokemonEvent());
                    },
                    icon: const Icon(Icons.refresh));
              })
            ],
          ),
          body: BlocBuilder<PokemanBloc, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PokemonErrorState) {
                return Center(
                  child: Text(state.errorMeassage),
                );
              }
              if (state is PokemonSuccessState) {
                return ListView.builder(
                    itemCount: state.pokemonList.length,
                    itemExtent: 66,
                    itemBuilder: (context, index) {
                      final pokemon = state.pokemonList[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            pokemon.img,
                          ),
                        ),
                        title: Text(pokemon.name),
                        subtitle: Text(pokemon.type),
                      );
                    });
              }
              return Container();
            },
          )),
    );
  }
}
