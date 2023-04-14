import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/providers/todo_provider.dart';
import 'package:notekeep/screens/add_todo_screen.dart';
import 'package:notekeep/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoProvider todoProvider;
  @override
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: const Text(
            "Tasks",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await AuthHelper.instance.logout();
                Get.to(() => const SplashScreen());
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddTodoScreen());
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return todoProvider.todos.isEmpty
                ? const Center(
                    child: Text(
                      "No todo added",
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: todoProvider.todos.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle),
                        child: ListTile(
                          title: Text(
                            todoProvider.todos[index].title,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            todoProvider.todos[index].description,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300),
                          ),
                          leading: Checkbox(
                            value: todoProvider.todos[index].isDone,
                            onChanged: (value) {
                              setState(() {
                                todoProvider.todos[index].isDone = value!;
                                todoProvider.updateTodo(
                                  index,
                                  todoProvider.todos[index],
                                );
                              });
                            },
                            checkColor: Colors.amber,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text(
                                  "${todoProvider.todos[index].createdAt.day}/${todoProvider.todos[index].createdAt.month}/${todoProvider.todos[index].createdAt.year}",
                                  style: GoogleFonts.aboreto(
                                      fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade100,
                                    borderRadius: BorderRadius.circular(45)),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    todoProvider.removeTodo(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ));
  }

  void getData() async {
    await todoProvider.getTodo();
  }
}
