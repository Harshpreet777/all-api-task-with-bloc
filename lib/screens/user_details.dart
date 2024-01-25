import 'package:bloc_api_task/bloc/list_bloc.dart';
import 'package:bloc_api_task/bloc/list_state.dart';
import 'package:bloc_api_task/models/response_model.dart';
import 'package:bloc_api_task/screens/update_screen.dart';
import 'package:bloc_api_task/services/http_delete_service.dart';
import 'package:bloc_api_task/services/http_get_service.dart';
import 'package:bloc_api_task/util/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<List<ResponseModel>>? futureData;
  HttpGetApiService httpsss = HttpGetApiService();
  @override
  void initState() {
    super.initState();
    futureData = httpsss.getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ListCubit>().fetchList();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Call');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    'User Details',
                    style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            BlocBuilder<ListCubit, ListState>(
              builder: (context, state) {
                if (state is LoadingState || state is InitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ResponseState) {
                  final lists = state.lists;
                  return listview(context, lists);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget listview(BuildContext context, List<ResponseModel> userList) {
    debugPrint('ListView Build Call }');
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userList.length,
      itemBuilder: (context, index) {
        ResponseModel data = userList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: ListTile(
            shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: ColorConstant.lightGrey8391A1, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            tileColor: ColorConstant.lightGrey,
            title: Text(
              'Name: ${data.name}',
              style: TextStyle(color: ColorConstant.black),
            ),
            subtitle: Text(
              data.email,
              style: TextStyle(color: ColorConstant.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: InkWell(
                        onTap: () async {
                          int deleteId2 = data.id;
                          if (deleteId2 == data.id) {
                            await DeleteApi.deleteData(id: data.id);
                            if (context.mounted) {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('User Deleted'),
                                        content: Text(
                                            'name: ${data.name},id : ${data.id},email : ${data.email} is Deleted'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            }

                            if (context.mounted) {
                              context.read<ListCubit>().fetchList();
                            }
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: ColorConstant.black,
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                        userName: data.name,
                                        userId: data.id,
                                        userEmail: data.email,
                                        userGender: data.gender,
                                        userStatus: "active",
                                      )));
                          if (context.mounted) {
                            context.read<ListCubit>().fetchList();
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          color: ColorConstant.black,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
