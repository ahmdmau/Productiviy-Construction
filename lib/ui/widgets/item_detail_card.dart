part of 'widgets.dart';

class ItemDetailCard extends StatelessWidget {
  final List<WorkModel> workModel;

  ItemDetailCard(this.workModel);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: workModel.length,
        itemBuilder: (_, index) => Container(
              child: ItemDetailContainer(
                workModel[index],
              ),
            ));
  }
}

class ItemDetailContainer extends StatelessWidget {
  final WorkModel workModel;

  ItemDetailContainer(this.workModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.only(top: 24, left: defaultMargin, right: defaultMargin),
      elevation:
          1.0, // this field changes the shadow of the card 1.0 is default
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Nama Proyek",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  workModel.workName,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Lokasi",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    workModel.workLocation,
                    textAlign: TextAlign.end,
                    style: whiteNumberFont.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Jam Mulai",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  workModel.startTime,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Jam Selesai",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  workModel.endTime,
                  textAlign: TextAlign.end,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Durasi",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${(workModel.durationTime * 60).toStringAsFixed(0)} Menit",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Jumlah Pekerja",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.totalWorker}",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hasil",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.workResult}",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Cuaca",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  workModel.weather,
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Produktivitas",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.productivityResult.toStringAsFixed(2)} Kg/Orang",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Effective",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.effective}",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Contributory",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.contributory}",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),

          SizedBox(
            height: 9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Ineffective",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(
                  "${workModel.ineffective}",
                  style: whiteNumberFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          // Container(
          //   width: 250,
          //   height: 46,
          //   margin: EdgeInsets.only(top: 36, bottom: 50),
          //   child: RaisedButton(
          //       elevation: 0,
          //       color: user.balance >= total
          //           ? Color(0xFF3E9D9D)
          //           : mainColor,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8)),
          //       child: Text(
          //         user.balance >= total
          //             ? "Checkout Now"
          //             : "Top Up My Wallet",
          //         style: whiteTextFont.copyWith(fontSize: 16),
          //       ),
          //       onPressed: () {
          //         if (user.balance >= total) {
          //           FlutixTransaction transaction =
          //               FlutixTransaction(
          //                   userID: user.id,
          //                   title: widget
          //                       .ticket.movieDetail.title,
          //                   subtitle:
          //                       widget.ticket.theater.name,
          //                   time: DateTime.now(),
          //                   amount: -total,
          //                   picture: widget.ticket.movieDetail
          //                       .posterPath);

          //           context.bloc<PageBloc>().add(
          //               GoToSuccessPage(
          //                   widget.ticket
          //                       .copyWith(totalPrice: total),
          //                   transaction));
          //         } else {
          //           // # Uang tidak cukup
          //         }
          //       }),
          // )
        ],
      ),
    );
  }
}
