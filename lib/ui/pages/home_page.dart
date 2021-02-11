part of 'pages.dart';

class HomePage extends StatelessWidget {
  List<CategoryProjectModel> categoryProjectModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              if (imageFileToUpload != null) {
                uploadImage(imageFileToUpload).then((value) {
                  imageFileToUpload = null;
                  BlocProvider.of<UserBloc>(context)
                      .add(UpdateData(profileImage: value));
                });
              }
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Stack(
                      children: [
                        SpinKitCircle(
                          color: Colors.white,
                          size: 50,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: (userState.model.profilePicture == "")
                                  ? AssetImage("assets/ic_user_pic.png")
                                  : NetworkImage(
                                      userState.model.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        style: whiteTextFont.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            78,
                        child: Text(userState.model.name,
                            style: whiteTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.clip),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return SpinKitCircle(
                color: Colors.white,
                size: 50,
              );
            }
          }),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Proyek Anda",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                future: CategoryProjectServices.getTransaction(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    categoryProjectModel = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: categoryProjectModel.length,
                        itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.only(
                                  bottom: 16,
                                  left: defaultMargin,
                                  right: defaultMargin),
                              child: CategoryWorkCard(
                                categoryProjectModel[index],
                                onTap: () {
                                  WorkModel workModel = WorkModel(
                                      idProject:
                                          categoryProjectModel[index].id);
                                  dummyWorkModel = workModel;
                                  dummyIdProject =
                                      categoryProjectModel[index].id;
                                  dummyTitle =
                                      categoryProjectModel[index].projectName;
                                  BlocProvider.of<PageBloc>(context).add(
                                      GoToListDataProjectPage(
                                          workModel,
                                          categoryProjectModel[index].id,
                                          categoryProjectModel[index]
                                              .projectName));
                                },
                              ),
                            ));
                  } else {
                    return SpinKitCircle(color: mainColor, size: 50);
                  }
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
