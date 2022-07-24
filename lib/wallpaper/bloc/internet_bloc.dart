import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'internet_event.dart';

part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetLoading());
  // final pen = AnsiPen()..yellow(bold: true);

  @override
  Stream<InternetState> mapEventToState(
    InternetEvent event,
  ) async* {
    if (event is GetInternetStatus) {
      yield InternetLoading();

      try {
        // print(pen(event.connectivityResult));
        switch (event.connectivityResult) {
          case ConnectivityResult.wifi:
            yield InternetConnected(event.connectivityResult);
            break;
          case ConnectivityResult.mobile:
            yield InternetConnected(event.connectivityResult);
            break;
          case ConnectivityResult.none:
            yield InternetDisconnected();
            break;
          default:
            break;
        }
      } catch (e) {
        print("Bloc Error");
      }
    }
  }
}
