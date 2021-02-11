part of 'widgets.dart';

class ListProjectCard extends StatelessWidget {
  final WorkModel workModel;
  final Function onTap;

  ListProjectCard(this.workModel, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 80,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workModel.workName,
                      style: whiteTextFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      workModel.workLocation,
                      style: whiteTextFont.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.transparent
                  ]).createShader(Rect.fromLTRB(0, 0, 77.5, 80));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 80,
              width: 77.5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset("assets/reflection2.png"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.transparent
                    ]).createShader(Rect.fromLTRB(0, 0, 96, 45));
              },
              blendMode: BlendMode.dstIn,
              child: SizedBox(
                height: 45,
                width: 96,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset("assets/reflection1.png"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.transparent
                    ]).createShader(Rect.fromLTRB(0, 0, 53, 25));
              },
              blendMode: BlendMode.dstIn,
              child: SizedBox(
                height: 25,
                width: 53,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset("assets/reflection1.png"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
