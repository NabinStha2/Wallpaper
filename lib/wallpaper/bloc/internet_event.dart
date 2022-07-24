part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class GetInternetStatus extends InternetEvent {
  final ConnectivityResult connectivityResult;
  GetInternetStatus({
    @required this.connectivityResult,
  });

  @override
  List<Object> get props => [connectivityResult];
}
