import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التقييمات'),
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  '4.0',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 48.0,
                    color: kPrimaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 48,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 48,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 48,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 48,
                    ),
                    Icon(
                      Icons.star_outline,
                      color: Colors.yellow,
                      size: 48,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ClientReview(
                        reviewDate: 'قبل يوم واحد',
                        score: 4.0,
                      ),
                      ClientReview(
                        reviewDate: 'قبل ثلاثة أيام',
                        score: 5.0,
                      ),
                      ClientReview(
                        reviewDate: 'قبل إسبوع',
                        score: 3.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CutsomDivider extends StatelessWidget {
  const CutsomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Divider(
        color: kPrimaryText,
      ),
    );
  }
}

class ClientReview extends StatelessWidget {
  const ClientReview({
    super.key,
    required this.reviewDate,
    required this.score,
  });

  final String reviewDate;
  final double score;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20.0,
                  color: kPrimaryText,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              starScore(score.toInt()),
              const Spacer(),
              Text(
                reviewDate,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.0,
                  color: kSecondaryText,
                ),
              )
            ],
          ),
          const Text(
            'كابتن محترم،  سريع في الإستلام والتوصيل ، مهتم بمظهرو كويس ، حتعامل معاه تاني إن شاء الله',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.0,
              color: kSecondaryText,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CutsomDivider(),
        ],
      ),
    );
  }
}

List<Widget> startIcons = [
  const Icon(
    Icons.star,
    size: 35,
    color: Colors.yellow,
  ),
  const Icon(
    Icons.star,
    size: 35,
    color: Colors.yellow,
  ),
  const Icon(
    Icons.star,
    size: 35,
    color: Colors.yellow,
  ),
  const Icon(
    Icons.star,
    size: 35,
    color: Colors.yellow,
  ),
  const Icon(
    Icons.star,
    size: 35,
    color: Colors.yellow,
  ),
];

Row starScore(int score) {
  if (score == 1) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
      ],
    );
  } else if (score == 2) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
      ],
    );
  } else if (score == 3) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
      ],
    );
  } else if (score == 4) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
      ],
    );
  } else if (score == 5) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.yellow,
        ),
      ],
    );
  } else {
    return const Row(
      children: [],
    );
  }
}
