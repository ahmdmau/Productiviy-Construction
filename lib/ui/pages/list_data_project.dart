part of 'pages.dart';

class ListDataProject extends StatefulWidget {
  final WorkModel workModel;
  final String idProject;
  final bool isCasting;
  final String title;

  ListDataProject(this.workModel, this.idProject, this.isCasting, this.title);

  @override
  _ListDataProjectState createState() => _ListDataProjectState();
}

class _ListDataProjectState extends State<ListDataProject> {
  List<WorkModel> workModels;
  bool isCasting;
  ScrollController scrollController;
  bool dialVisible = true;
  final ProjectBloc _projectBloc = ProjectBloc();

  @override
  void initState() {
    super.initState();
    _projectBloc.add(GetWork(widget.idProject, 0));
    isCasting = widget.isCasting;
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BlocProvider(
              create: (_) => _projectBloc,
              child: BlocListener<ProjectBloc, ProjectState>(
                  listener: (context, state) {
                if (state is ProjectError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              }, child: BlocBuilder<ProjectBloc, ProjectState>(
                builder: (context, state) {
                  if (state is ProjectInitial) {
                    return _buildLoading();
                  } else if (state is ProjectLoading) {
                    return _buildLoading();
                  } else if (state is ProjectLoaded) {
                    workModels = isCasting
                        ? state.workModel
                            .where((ticket) => ticket.idTypeWork == 2)
                            .toList()
                        : state.workModel
                            .where((ticket) => ticket.idTypeWork == 1)
                            .toList();
                    if (workModels.length > 0) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: ItemViewer(workModels),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Belum ada data",
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                      );
                    }
                  } else if (state is ProjectError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              )),
            ),
            // BlocBuilder<ProjectBloc, ProjectState>(builder: (_, projectState) {
            //   List<WorkModel> workModels = const [];
            //   if (projectState is ProjectLoaded) {
            // workModels = isCasting
            //     ? projectState.workModel
            //         .where((ticket) => ticket.idTypeWork == 2)
            //         .toList()
            //     : projectState.workModel
            //         .where((ticket) => ticket.idTypeWork == 1)
            //         .toList();
            //     return Container(
            //       margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            //       child: ItemViewer(workModels),
            //     );
            //   } else {
            //     return Container(
            //       margin: EdgeInsets.only(top: 100),
            //       child: SpinKitCircle(color: mainColor, size: 50),
            //     );
            //   }
            // }),

            // note: HEADER
            Container(
              height: 113,
              color: accentColor1,
            ),
            SafeArea(
                child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 113,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 24, bottom: 32),
                      child: Text(
                        "Pekerjaan Saya",
                        style: whiteTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCasting = !isCasting;
                                  _projectBloc
                                      .add(GetWork(widget.idProject, 0));
                                });
                              },
                              child: Text(
                                "Pembesian",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color:
                                        !isCasting ? Colors.white : mainColor),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: !isCasting
                                  ? accentColor2
                                  : Colors.transparent,
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCasting = !isCasting;
                                  _projectBloc
                                      .add(GetWork(widget.idProject, 1));
                                });
                              },
                              child: Text(
                                "Pengecoran",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color:
                                        isCasting ? Colors.white : mainColor),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color:
                                  isCasting ? accentColor2 : Colors.transparent,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: buildSpeedDial()),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  Widget _buildLoading() =>
      Center(child: SpinKitCircle(color: mainColor, size: 50));

  Future<List<WorkModel>> getData() async {
    var result = await ProjectServies.getWork(widget.idProject);
    return isCasting
        ? result.where((ticket) => ticket.idTypeWork == 2).toList()
        : result.where((ticket) => ticket.idTypeWork == 1).toList();
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () {},
      onClose: () {},
      visible: dialVisible,
      curve: Curves.bounceIn,
      backgroundColor: accentColor2,
      children: [
        SpeedDialChild(
          child: Icon(Icons.visibility, color: Colors.white),
          backgroundColor: mainColor,
          onTap: () {
            BlocProvider.of<PageBloc>(context)
                .add(GoToDetailProjectPage(isCasting ? 2 : 1, widget.title));
            BlocProvider.of<ProjectBloc>(context)
                .add(GetWork(widget.idProject, isCasting ? 2 : 1));
          },
          label: 'Rekapitulasi Pekerjaan',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: mainColor,
        ),
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: mainColor,
          onTap: () {
            BlocProvider.of<PageBloc>(context)
                .add(GoToChooseTypeWorkPage(widget.workModel));
          },
          label: 'Tambah Pekerjaan',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: mainColor,
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ItemViewer extends StatelessWidget {
  final List<WorkModel> workModel;

  ItemViewer(this.workModel);

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: workModel.length,
    //     itemBuilder: (_, index) => Container(
    //           color: Color(0xFFF6F7F9),
    //           margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 133 : 0),
    //           child: ListProjectCard(
    //             workModel[index],
    //             onTap: () {
    // BlocProvider.of<PageBloc>(context)
    //     .add(GoToDetailProjectSinglePage(workModel[index]));
    //             },
    //           ),
    //         ));

    return ListView.builder(
      itemCount: workModel.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: slideRightBackground(index),
          secondaryBackground: slideLeftBackground(index),
          key: Key(workModel[index].id),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "Apakah anda yakin ingin menghapus pekerjaan ${workModel[index].workName}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            BlocProvider.of<ProjectBloc>(context).add(
                                DeleteWork(workModel[index].id,
                                    workModel[index].idProject));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }).then((value) {
                BlocProvider.of<ProjectBloc>(context)
                    .add(GetWork(dummyIdProject, 0));
              });
              return res;
            }
          },
          child: Card(
            color: appWhite,
            margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 133 : 0),
            elevation: 2,
            child: ListTile(
              onTap: () {
                BlocProvider.of<PageBloc>(context)
                    .add(GoToDetailProjectSinglePage(workModel[index]));
              },
              title: Text(
                workModel[index].workName,
                style: boldTextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                    workModel[index].workLocation +
                        ", " +
                        workModel[index].startTime +
                        " - " +
                        workModel[index].endTime,
                    style: secondaryTextStyle()),
              ),
              trailing: Container(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.chevron_right, color: iconColorPrimaryDark),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget slideRightBackground(int index) {
  return Container(
    margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 133 : 0),
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Ubah",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}
