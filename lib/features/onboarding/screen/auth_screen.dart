import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widget/landing_widget.dart';
import '../widget/login_widget.dart';
import '../widget/signup_widget.dart';

enum AuthState { landing, login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late VideoPlayerController _controller;
  AuthState _state = AuthState.landing;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/Video.mp4")
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _getCurrentWidget() {
    switch (_state) {
      case AuthState.landing:
        return LandingWidget(
          onLoginTap: () => setState(() => _state = AuthState.login),
          onSignupTap: () => setState(() => _state = AuthState.signup),
        );
      case AuthState.login:
        return LoginWidget(
          onBack: () => setState(() => _state = AuthState.landing),
        );
      case AuthState.signup:
        return SignupWidget(
          onBack: () => setState(() => _state = AuthState.landing),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _controller.value.isInitialized
              ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              )
              : Container(color: Colors.black),

          AnimatedAlign(
            duration: const Duration(milliseconds: 400),
            alignment:
                _state == AuthState.landing
                    ? Alignment.center
                    : Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: EdgeInsets.only(
                top: _state == AuthState.landing ? 0 : 60,
              ),
              height: _state == AuthState.landing ? 140 : 90,
              child: Image.asset("assets/images/Logo.png"),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _getCurrentWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
