import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/review_model.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor.withOpacity(0.5),
      child: FutureBuilder<ReviewModel>(
        future: HomeUtils.getReviews(),
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: 8),
                    child: Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  snapshot.data!.data!.isEmpty
                      ? Center(
                          child: Text('No reviews found...',
                              style: smallLightText))
                      : CarouselSlider.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index, realIndex) =>
                              reviewCard(snapshot, index),
                          options: CarouselOptions(
                            autoPlay: false,
                            height: 270,
                            viewportFraction: 0.8,
                            autoPlayInterval:
                                const Duration(milliseconds: 2000),
                          ),
                        ),
                ],
              )
            : reviewShimmer(),
      ),
    );
  }

  reviewCard(AsyncSnapshot<ReviewModel> snapshot, int index) {
    final item = snapshot.data!.data![index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Card(
        color: whiteColor,
        elevation: 4,
        child: MyContainer(
          margin: const EdgeInsets.all(defaultMargin),
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 45,
                backgroundImage:
                    CachedNetworkImageProvider('$imgPath/${item.image!}'),
              ),
              Text(item.name!, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black,
              ),
              ),
              Text(item.date!, style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black,
              ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: HtmlWidget(
                  item.description!,
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  reviewShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        shimmerCard(),
        shimmerCard(),
      ],
    );
  }

  MyContainer shimmerCard() {
    return MyContainer(
      padding: const EdgeInsets.all(defaultPadding),
      height: 220,
      margin: const EdgeInsets.all(defaultMargin),
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.black26,
            child: const CircleAvatar(
              backgroundColor: Colors.black26,
              radius: 45,
            ),
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.black26,
            child: Container(
              height: 10,
              width: 60,
              color: Colors.black26,
            ),
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.black26,
            child: Container(
              height: 10,
              width: 60,
              color: Colors.black26,
            ),
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.black26,
            child: Container(
              height: 40,
              width: 120,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
