import 'package:flutter/material.dart';

class AutoCompleteExample extends StatefulWidget {
  const AutoCompleteExample({super.key});

  @override
  State<AutoCompleteExample> createState() => _AutoCompleteExampleState();
}

class _AutoCompleteExampleState extends State<AutoCompleteExample> {
  final List<String> _names = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AutoComplete Example')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Autocomplete<String>(
            displayStringForOption: (String option) =>
                option, // use displayStringForOption if the item is not a string like User() and you want to display the name (option.name)
            initialValue: const TextEditingValue(
              text: 'Grape',
            ), // Initial value
            onSelected: (String selection) {
              debugPrint('You just selected $selection');
            },
            optionsBuilder: (TextEditingValue value) {
              if (value.text.isEmpty) {
                return List.empty();
              }
              return _names.where(
                (name) => name.toLowerCase().contains(value.text.toLowerCase()),
              );
            },
            optionsViewBuilder: // to customize the options list
                (
                  BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options,
                ) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: ListView.separated(
                        itemCount: options.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8.0),
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                              tileColor: Colors.grey[200],
                              leading: Icon(Icons.abc_sharp),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
            fieldViewBuilder: // to customize the field
            (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                onSubmitted: (String value) {
                  onFieldSubmitted();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type to search',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
