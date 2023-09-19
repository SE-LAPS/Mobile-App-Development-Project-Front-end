// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/common/widgets/loader.dart';
import '../../../core/palette.dart';
import '../../../model/product.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/screens/cart_screen.dart';
import '../controller/search_controller.dart';
import '../widgets/searched_product.dart';
import 'package:badges/badges.dart' as Badges;

class SearchScreen extends ConsumerStatefulWidget {
  static const routeName = '/search-screen';
  final TextEditingController searchController;
  const SearchScreen({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenConsumerState();
}

class _SearchScreenConsumerState extends ConsumerState<SearchScreen> {
  String name = "";

  //for voicerecognition
  bool _isVoiceSupport = false;
  bool _isListening = false;
  String _text = "Hold the button and speak..";

  //instants
  SpeechToText _speechToText = SpeechToText();

  //check phone is voice supported or not
  void voiceSupportCheck() async {
    try {
      var available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isVoiceSupport = true;
        });
      }
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    voiceSupportCheck();
  }

  void navigateToBackScreen() {
    widget.searchController.text = "";
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          navigateToBackScreen();
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 70,
              leadingWidth: 25,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: blackColorShade1,
                    size: 35,
                  ),
                  onPressed: () {
                    navigateToBackScreen();
                  }),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          TextFormField(
                            cursorHeight: 30,
                            style: const TextStyle(fontSize: 25),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            autofocus: true,
                            controller: widget.searchController,
                            cursorColor: blackColor,
                            onFieldSubmitted: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 7, right: 8),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: blackColorShade1,
                                    size: 30,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: blackColorShade2,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(top: 10),
                              hintText: 'Search here...',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          _isVoiceSupport
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: AvatarGlow(
                                    glowColor: primaryColor,
                                    repeat: true,
                                    repeatPauseDuration:
                                        const Duration(milliseconds: 100),
                                    showTwoGlows: true,
                                    endRadius: 20.0,
                                    animate: _isListening,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    child: GestureDetector(
                                      onTapDown: (details) async {
                                        if (!_isListening) {
                                          setState(() {
                                            _text =
                                                "Hold the button and speak..";
                                            _isListening = true;
                                          });
                                          var available =
                                              await _speechToText.initialize();
                                          if (available) {
                                            setState(() {
                                              _speechToText.listen(
                                                onResult: (result) {
                                                  setState(() {
                                                    _text =
                                                        result.recognizedWords;
                                                    widget.searchController
                                                            .text =
                                                        result.recognizedWords;
                                                  });
                                                },
                                              );
                                            });
                                          }
                                        }
                                      },
                                      onTapUp: (details) async {
                                        _speechToText.stop();

                                        setState(() {
                                          _isListening = false;
                                        });

                                        if (_text !=
                                            "Hold the button and speak..") {
                                          setState(() {
                                            name = _text;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        _isListening
                                            ? Icons.mic
                                            : Icons.mic_none,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, CartScreen.routeName)},
                    radius: 10,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final userCartLength = ref.watch(cartProvider).length;

                        return userCartLength != 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Badges.Badge(
                                  badgeContent: Text(userCartLength.toString()),
                                  badgeStyle: const Badges.BadgeStyle(
                                      badgeColor: whiteColor),
                                  child: const SizedBox(
                                    height: 42,
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 42,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: blackColorShade1,
                                  size: 30,
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: ref.watch(searchProviderStream).when(
                data: (snapshot) => whenData(snapshot),
                error: (error, stackTrace) => whenError(error),
                loading: () => whenLoading())));
  }

  //when error
  Widget whenError(dynamic error) {
    return Center(
      child: Text('Something went wrong! ${error}'),
    );
  }

  //when data
  Widget whenData(dynamic snapshot) {
    List<ProductModel> suggestionList = snapshot;

    final data = snapshot.runtimeType;

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                final product = suggestionList[index];
                return widget.searchController.text.isEmpty
                    ? const SizedBox()
                    : product.name.toLowerCase().startsWith(
                            widget.searchController.text.toLowerCase())
                        ? GestureDetector(
                            onTap: () {},
                            child: SearchedProduct(
                              product: product,
                              searchingTextLength:
                                  widget.searchController.text.length,
                            ),
                          )
                        : const SizedBox();
              }),
        ),
      ],
    );
  }

  //when loading
  Widget whenLoading() {
    return const Loader();
  }
}
