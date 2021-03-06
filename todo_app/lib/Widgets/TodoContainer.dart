import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final Function onPressDelete;
  const TodoContainer({
    Key? key,
    required this.id,
    required this.title,
    required this.desc,
    required this.isDone,
    required this.onPressDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                color: const Color(0xFF405173),
                child: Column(
                  children: [
                    const Text(
                      "Update your Todo Task",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: title,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF001133),
                            ),
                          ),
                          labelText: "Task",
                          labelStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: desc,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF001133),
                            ),
                          ),
                          labelText: "Description",
                          labelStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white),
                          //   hintText: "Description",
                          //   hintStyle:
                          //       TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => null,
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF001133))),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          //height: 200, specifying no height auto wrap the container according to content
          decoration: const BoxDecoration(
            color: Color(0xFF001133),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () => {},
                    //   icon: Icon(Icons.delete_forever_outlined),
                    //   label: Text("Delete"),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: const Color(0xFF333366),
                    //     // padding:
                    //     //     EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    //     // textStyle:
                    //     //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    IconButton(
                        onPressed: () => onPressDelete(),
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                        ))
                  ],
                ),
                // SizeBox here is being used same as giving padding b/w title & desc
                // const SizedBox(
                //   height: 10,
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      desc,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
