import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NowPlayingSectionLoading extends StatelessWidget {
  const NowPlayingSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Skeletonizer for shimmer effects
    return Skeletonizer(
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            viewportFraction: 1.0,
          ),
          items: List.generate(2, (index) {
            const dummyBackdropUrl =
                'assets/images/nowPlayingtemp.jpg'; // Placeholder image URL
            const dummyTitle = 'Loading...'; // Placeholder text

            return Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0, 0.3, 0.5, 1],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    height: 560.0,
                    dummyBackdropUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.redAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Now Playing'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          dummyTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
