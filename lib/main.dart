import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitza_app/bloc/pizza_bloc.dart';
import 'package:pitza_app/model/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PizzaBloc()..add(LoadPizzaCounter())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random random = Random(500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pizza App", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(builder: (context, state) {
          ///Pizza Initial
          if (state is PizzaInitial) {
            return const CircularProgressIndicator(
              color: Colors.orange,
            );
          }

          /// pizza loaded
          if (state is PizzaLoaded) {
            return Column(
              children: [
                Text(
                  "${state.pizzas.length}",
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: state.pizzas.map((e) {
                        return Positioned(
                          left: random.nextInt(250).toDouble(),
                          top: random.nextInt(400).toDouble(),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: e.image,
                          ),
                        );
                      }).toList()


                      ),
                )
              ],
            );
          }

          ///
          else {
            return const Text("something is wrong!");
          }
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizza[0]));
            },
            child: const Icon(
              Icons.local_pizza_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizza[0]));
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[600],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizza[1]));
            },
            child: const Icon(
              Icons.local_pizza,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.orange[600],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizza[1]));
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
