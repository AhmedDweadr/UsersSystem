import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentCubit.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentState.dart';
import 'package:my_app/Fetures/Users/Domain/Entity.dart';
import 'package:my_app/core/themes/themes.dart';
import 'package:my_app/view/addContent.dart';
import 'package:my_app/view/updateContent.dart';

class UserDetails extends StatefulWidget {
  final UserEntity user;

  const UserDetails({super.key, required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
    context.read<ContentCubit>().getContent(widget.user.id);
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            /// 🔵 AppBar
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: Themes.mainColor,
              expandedHeight: 130,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(widget.user.phone),
                          const SizedBox(height: 5),
                          Text(widget.user.address),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Addcontent(user_id: widget.user.id),
                            ),
                          );

                          if (result == true) {
                            showSnackBar(
                              'تمت إضافة الملحوظه بنجاح',
                              Colors.green,
                            );

                            context.read<ContentCubit>().getContent(
                              widget.user.id,
                            );
                          }
                        },
                        icon: const Icon(Icons.add, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔵 Content List
            BlocBuilder<ContentCubit, ContentState>(
              builder: (context, state) {
                if (state is ContentLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is Contenterror) {
                  return SliverFillRemaining(
                    child: Center(child: Text("${state.message}😥 ")),
                  );
                }

                if (state is ContentLoaded) {
                  print("content+++++++++++++++++");
                  print(state.content);
                  final sortedContent = List<ContentEntity>.from(state.content)
                    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

                  if (sortedContent.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "لا توجد ملاحظات",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = sortedContent[index];

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// التاريخ
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'dd-MM-yyyy – kk:mm',
                                      ).format(item.createdAt),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => UpdateContentPage(
                                              content: item.content,
                                              Contentid: item.id,
                                            ),
                                          ),
                                        );

                                        if (result == true) {
                                          context
                                              .read<ContentCubit>()
                                              .getContent(widget.user.id);

                                          showSnackBar(
                                            'تمت إضافة الملحوظه بنجاح',
                                            Colors.green,
                                          );
                                        }
                                      },

                                      icon: Icon(
                                        Icons.edit,
                                        color: Themes.mainColor,
                                      ),
                                    ),

                                    // ==================delete
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("هل أنت متأكد؟"),
                                            content: const Text(
                                              "سيتم حذف هذا المستخدم وجميع البيانات المرتبطة به نهائيًا.",
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "إلغاء",
                                                  style: TextStyle(
                                                    color: Themes.mainColor,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<ContentCubit>()
                                                      .deleteContent(item.id,widget.user.id);
                                                  Navigator.pop(context);
                                                  showSnackBar(
                                                    'تم حذف',
                                                    Colors.blue,
                                                  );
                                                },
                                                child: const Text(
                                                  "تأكيد الحذف",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                      255,
                                                      186,
                                                      69,
                                                      60,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                      
                                      },

                                      icon: Icon(
                                        Icons.delete,
                                        color: Themes.mainColor,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                /// النص
                                Text(
                                  item.content.isEmpty
                                      ? "لا توجد ملاحظات"
                                      : item.content,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, childCount: sortedContent.length),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
