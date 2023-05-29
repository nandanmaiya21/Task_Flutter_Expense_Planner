import 'package:flutter/material.dart';
import 'package:planner_app/Screen/edit_screen.dart';
import 'package:planner_app/provider/expenses.dart';
import './widgets/genral_information.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'widgets/genral_information.dart';
import 'package:provider/provider.dart';
import './Screen/summary.dart';
import './Screen/detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('build() MyHomePageState');
    return ChangeNotifierProvider(
      create: (ctx) => Expenses(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: MaterialColorGenerator.from(
              const Color.fromRGBO(147, 118, 224, 1)),
          scaffoldBackgroundColor: const Color.fromRGBO(232, 147, 207, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(147, 118, 224, 1),
            secondary: const Color.fromRGBO(246, 255, 166, 1),
            error: Colors.redAccent,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
          fontFamily: 'SF-Pro',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        home: MyHomePage(),
        routes: {
          EditScreen.routeName: (ctx) => EditScreen(),
          Summary.routeName: (ctx) => Summary(),
          DetailScreen.routeName: (ctx) => DetailScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool show_chart = false;

  List<Transaction> _userTransactions;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(),
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQueryData,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show General'),
          Switch.adaptive(
            value: show_chart,
            onChanged: (val) {
              setState(() {
                show_chart = val;
              });
            },
          ),
        ],
      ),
      show_chart
          ? Container(
              height: (mediaQueryData.size.height -
                      appBar.preferredSize.height -
                      mediaQueryData.padding.top) *
                  0.7,
              child: GeneralInformation())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                txListWidget,
              ],
            )
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: GeneralInformation()),
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          bottom: 8,
        ),
        child: Text(
          "Recent Transactions",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      txListWidget
    ];
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Personal Expenses',
        //style: TextStyle(fontFamily: 'SF-Pro', fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = _buildAppBar();

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(),
    );
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(147, 118, 224, 1),
                        Color.fromRGBO(232, 147, 207, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.9,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Personal Expense",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                ListTile(
                  title: const Text(
                    'Edit Transaction',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(EditScreen.routeName),
                ),
                Divider(
                  thickness: 3,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                ListTile(
                  title: const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Summary.routeName),
                ),
                Divider(
                  thickness: 3,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            )),
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandScape)
                ..._buildLandscapeContent(
                  mediaQuery,
                  appBar,
                  txListWidget,
                ),
              if (!isLandScape)
                ..._buildPortraitContent(
                  mediaQuery,
                  appBar,
                  txListWidget,
                ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
