import 'package:butceappflutter/api/models/Category.dart';
import 'package:butceappflutter/api/models/Corporate.dart';
import 'package:butceappflutter/api/models/Expense.dart';
import 'package:butceappflutter/api/models/PaymentMethod.dart';
import 'package:butceappflutter/api/repositories/category_repository.dart';
import 'package:butceappflutter/api/repositories/corporate_repository.dart';
import 'package:butceappflutter/api/repositories/expense_repository.dart';
import 'package:butceappflutter/api/repositories/paymentmethod_repository.dart';
import 'package:butceappflutter/widgets/my_navigation_bar.dart';
import 'package:butceappflutter/widgets/my_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ExpenseAddScreen extends StatefulWidget {
  @override
  _ExpenseAddScreenState createState() => _ExpenseAddScreenState();
}

class _ExpenseAddScreenState extends State<ExpenseAddScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Expense expense = new Expense();
  String selectedCategory;
  String selectedCorporate;
  String selectedCity;
  String selectedPaymentMethod;
  String description;
  String name;
  String amount;
  DateTime selectedDate;
  List<String> _cities = <String>[
    'Adana',
    'Adıyaman',
    'Afyon',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce'
  ];
  DateTime currentdate = new DateTime.now();
  ExpenseRepository expenseRepository = new ExpenseRepository();
  CategoryRepository categoryRepository = new CategoryRepository();
  CorporateRepository corporateRepository = new CorporateRepository();
  PaymentMethodRepository paymentMethodRepository =
      new PaymentMethodRepository();
  var uuid = new Uuid();
  SharedPreferences myPrefs;
  List<Category> categories;
  List<Corporate> corporates;
  List<PaymentMethod> paymentMethods;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: currentdate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2022),
        helpText: 'Harcama Tarihini Seçiniz',
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        }).then((date) {
      this.selectedDate = date;
      print(this.selectedDate);
    });
  }

  @override
  void initState(){
    SharedPreferences.getInstance().then((value) => myPrefs = value);
    this.categoryRepository.get().then((value) {
      setState(() {
        this.categories = value;
        print(categories);
      });
    });
    this.corporateRepository.get().then((value) {
      setState(() {
        this.corporates = value;
      });
    });
    this.paymentMethodRepository.get().then((value) {
      setState(() {
        this.paymentMethods = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Harcama Ekle",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: Icon(
              Icons.date_range,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
      body: (categories != null && corporates != null && paymentMethods != null)
          ? Form(
              key: _formKey,
              autovalidate: true,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Cant be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.name = value;
                      print(this.name);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.pencilAlt,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Harcama İsmi',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.book, //coins
                        size: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      new DropdownButton(
                        hint: Text('Kategori'),
                        value: selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            print(selectedCategory);
                          });
                        },
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            child: new Text(category.name),
                            value: category.id,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingBag, //coins
                        size: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      new DropdownButton(
                        hint: Text('Şirket'),
                        value: selectedCorporate,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCorporate = newValue;
                            print(selectedCorporate);
                          });
                        },
                        items: corporates.map((corporate) {
                          return DropdownMenuItem(
                            child: new Text(corporate.name),
                            value: corporate.id,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Cant be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.amount = value.toString();
                      print(this.amount);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.coins,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Tutar',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingBag, //coins
                        size: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      new DropdownButton(
                        hint: Text('Ödeme Şekli'),
                        value: selectedPaymentMethod,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPaymentMethod = newValue;
                          });
                        },
                        items: paymentMethods.map((paymentMethod) {
                          return DropdownMenuItem(
                            child: new Text(paymentMethod.name),
                            value: paymentMethod.id,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingBag, //coins
                        size: 25.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      new DropdownButton(
                        hint: Text('Şehir'),
                        value: selectedCity,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCity = newValue;
                          });
                        },
                        items: _cities.map((city) {
                          return DropdownMenuItem(
                            child: new Text(city),
                            value: city,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) {
                      this.description = value;
                      print(this.description);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.pencilAlt,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Açıklama',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).accentColor,
                        child: Text('Ekle'),
                        onPressed: !isLoading ? () {
                          setState(() {
                            isLoading = true;
                          });
                          if(_formKey.currentState.validate() && this.selectedDate != null){
                            Expense expense = new Expense(
                            id: uuid.v4(),
                            name: this.name,
                            amount: double.parse(this.amount),
                            city: this.selectedCity,
                            corporateId: this.selectedCorporate,
                            description: this.description,
                            date: this.selectedDate,
                            createdDate: DateTime.now(),
                            userId: myPrefs.get('userId'),
                          );
                          this.expenseRepository.post(expense).then((response) {
                            if (response.statusCode == 200) {
                              Navigator.pop(context);
                              isLoading = false;
                            }
                          });
                          } 
                        }: null),
                  ),
                ],
              ),
            )
          : MySpinKit(),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey),
          child: MyBottomNavigationBar()),
    );
  }
}
