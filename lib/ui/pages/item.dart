part of 'pages.dart';

class Item extends StatefulWidget {
  final String idProject;
  final int type;

  Item(this.idProject, this.type);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<WorkModel> workModels;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProjectServies.getWork(widget.idProject),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            workModels = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: workModels.length,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: ListProjectCard(
                        workModels[index],
                        onTap: () {
                          // WorkModel workModel = WorkModel(
                          //     idProject:
                          //         categoryProjectModel[
                          //                 index]
                          //             .id);
                          // BlocProvider.of<PageBloc>(
                          //         context)
                          //     .add(
                          //         GoToListDataProjectPage(
                          //             workModel));
                        },
                      ),
                    ));
          } else {
            return SpinKitCircle(color: mainColor, size: 50);
          }
        });
  }
}
