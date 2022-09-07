import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Pizza extends Equatable {
  final String name;
  final String id;
  final Image image;

  const Pizza({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Pizza> pizza = [
    Pizza(id: "0", name: "pizza", image: Image.asset("images/pizza.png")),
    Pizza(id: "1", name: "pizza pepperoni", image: Image.asset("images/pizza_pepperoni.png")),
  ];
}
