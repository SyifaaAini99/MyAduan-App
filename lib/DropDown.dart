List<String> categories = [
  "Road Issues",
  "Traffic light",
  "Parking",
  "Building",
  "Dashcam",
  "Illegal waste disposal",
];
/*
class CategoryDropdown extends StatefulWidget {
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<DropdownMenuItem<String>> _dropdownMenuItems;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_categories);
    //selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 0.65*MediaQuery.of(context).size.width,
      height: 75.0,
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: DropdownButtonFormField<String>(
          key: formKey2,
          hint: Container(
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              'Category',
              style: TextStyle(
                  color: Color.fromRGBO(24, 51, 98, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          validator: (value) => value == null ? "Please select a category" : null,
          isExpanded: true,
          elevation: 10,
          value: selectedCategory,
          items: _dropdownMenuItems,
          onChanged: (value) {
            setState(() {
                selectedCategory = value;
            });
          }
        ),
      ),
    );
  }
}*/
