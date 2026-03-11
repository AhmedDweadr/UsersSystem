import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentCubit.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/Cubit.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/State.dart';
import 'package:my_app/core/themes/themes.dart';
import 'package:my_app/view/AddUser.dart';
import 'package:my_app/view/search.dart';
import 'package:my_app/view/user.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    context.read<userCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الصفحة الرئيسية",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchPage()),
            );
          },
          icon: const Icon(Icons.search, color: Colors.black),
          tooltip: 'بحث',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddUser,
            tooltip: 'إضافة مستخدم',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
            tooltip: 'تحديث',
          ),
        ],
      ),
      backgroundColor: Themes.backgroundColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadUsers,
        color: Themes.mainColor,
        child: BlocBuilder<userCubit, UserState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetUserState) {
              final users = state.userData;

              if (users.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return _buildUserCard(user);
                },
              );
            }

            if (state is userError) {
              return _buildErrorState(state.Message);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // ✅ دالة التنقل لإضافة مستخدم (المعدلة)
  Future<void> _navigateToAddUser() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddUserPage()),
    );

    if (result == true) {
      showSnackBar('تمت إضافة المستخدم بنجاح', Colors.green);
      _loadUsers();
    }
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

  Widget _buildUserCard(dynamic user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Themes.SecondColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          await context.read<ContentCubit>().getContent(
            user.id,
          );


          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserDetails( user: user),
            ),
          );

          // لو حصل تعديل، ممكن تعمل refresh
          if (result == true) {
            _loadUsers(); // إعادة تحميل المستخدمين
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Themes.mainColor,
                child: Text(
                  user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        Text(user.address),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        Text(user.phone),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Themes.mainColor),
                onPressed: () {
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
                            style: TextStyle(color: Themes.mainColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<userCubit>().delete_User(
                              user_id: user.id,
                            );
                            Navigator.pop(context);
                            showSnackBar('تم حذف${user.name}', Colors.blue);
                          },
                          child: const Text(
                            "تأكيد الحذف",
                            style: TextStyle(
                              color: Color.fromARGB(255, 186, 69, 60),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(errorMessage, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadUsers,
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
            style: ElevatedButton.styleFrom(backgroundColor: Themes.mainColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 100, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'لا يوجد مستخدمين',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('اضغط على زر + لإضافة مستخدم جديد'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _navigateToAddUser,
            icon: const Icon(Icons.add),
            label: const Text('إضافة مستخدم'),
            style: ElevatedButton.styleFrom(backgroundColor: Themes.mainColor),
          ),
        ],
      ),
    );
  }
}
