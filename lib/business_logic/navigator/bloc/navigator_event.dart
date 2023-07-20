// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorEvent {}

class TabChangeEvent extends NavigatorEvent {
  int tabIndex;
  TabChangeEvent({
    required this.tabIndex,
  });
}
