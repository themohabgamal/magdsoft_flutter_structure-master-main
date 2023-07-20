part of 'custom_grid_bloc.dart';

@immutable
abstract class CustomGridState {}

abstract class CustomGridActionState extends CustomGridState {}

class CustomGridInitial extends CustomGridState {}

class NavigateToProductScreenState extends CustomGridActionState {}
