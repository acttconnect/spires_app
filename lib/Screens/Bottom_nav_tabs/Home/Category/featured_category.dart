import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/category_model.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Home/Category/category_wise.dart';

class FeaturedCategory extends StatelessWidget {
  const FeaturedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Category",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8.0),
          FutureBuilder<JobCategoryModel>(
            future: HomeUtils.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Return a loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Handle error state
              } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                return Text('No data available'); // Handle no data state
              } else {
                return CarouselSlider.builder(
                  itemCount: snapshot.data!.data!.length,
                  options: CarouselOptions(
                    height: 132,
                    viewportFraction: 0.35, // Adjust as needed
                    autoPlay: true, // Enable autoplay
                    autoPlayInterval: Duration(seconds: 3), // Set the interval for autoplay
                    autoPlayAnimationDuration: Duration(milliseconds: 800), // Set the duration of the sliding animation
                    autoPlayCurve: Curves.fastOutSlowIn, // Set the animation curve
                  ),
                  itemBuilder: (context, index, _) {
                    return categoryCard(snapshot, index, size);
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  categoryCard(AsyncSnapshot<JobCategoryModel> snapshot, int index, Size size) {
    final item = snapshot.data!.data![index];
    return InkWell(
      onTap: () => Get.to(
          () => CategoryWise(catId: item.id!.toInt(), catName: item.name!)),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 0.5),
        margin: const EdgeInsets.only(right: defaultPadding * 0.75),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.black12)),
        width: size.width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: '$imgPath/${item.image}',
              height: 60,
              fit: BoxFit.cover,
            ),
            const Divider(),
            SizedBox(
              child: Text(
                item.name!,
                style: smallText,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryShimmer() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(right: defaultPadding * 0.75),
      width: 120,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: borderRadius,
          border: Border.all(color: Colors.black12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: whiteColor,
            child: Container(
              color: Colors.black12,
              height: 50,
              width: 100,
            ),
          ),
          const Divider(),
          Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: whiteColor,
            child: Container(
              color: Colors.black12,
              height: 20,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
