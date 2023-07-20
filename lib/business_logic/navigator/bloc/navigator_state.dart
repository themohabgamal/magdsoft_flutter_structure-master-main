part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorHomeState {
  final int tabIndex;

  const NavigatorHomeState(this.tabIndex);
}

class NavigatorInitial extends NavigatorHomeState {
  const NavigatorInitial(int tabIndex) : super(tabIndex);
}
