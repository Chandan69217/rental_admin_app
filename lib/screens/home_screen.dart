import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import '../models/dashboard_data.dart';
import '../utilities/cust_color.dart';
import '../widgets/cust_circular_indicator.dart';
import 'hostel_floors.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.only(left:  20,right: 20,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ButtonsSection(),
          Text('Dashboard', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 10),
          HostelExpensesCard(hostelName: 'Sweta Girls Hostel',monthlyExpenses: '1200',totalExpenses: '24000',remainingBudget: '2345',),
          SizedBox(height: 20),
          Text('Hostels', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 10),
          Expanded(
            child: DashboardData.hostels == null ? Center(child: CustCircularIndicator(),):
            ListView.builder(itemCount: DashboardData.hostels != null ? DashboardData.hostels!.length:0,
                itemBuilder: (context,index){
                  return HostelCard(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: DashboardData.hostels![index]['hostelName'],subTitle: DashboardData.hostels![index]['hostelType'],hostel_id:DashboardData.hostels![index]['id']??0,))),
                    title: DashboardData.hostels![index]['hostelName'],
                    subtitle:DashboardData.hostels![index]['hostelType'],
                    stats: [
                      {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '${DashboardData.hostels![index]['totalFloor']}'},
                      {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '${DashboardData.hostels![index]['totalRoom']}'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '${DashboardData.hostels![index]['totalBed']}'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': 'N/A'},
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

}

class HostelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> stats;
  final VoidCallback? onTap;
  HostelCard({required this.title, required this.subtitle, required this.stats,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: subtitle == 'Girls Hostel' ? CustColor.Pink : CustColor.Blue),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            GridView.count(crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2.5,
              children: stats.map((stat) {
                return StatCard(
                  icon: stat['icon'],
                  label: stat['label'],
                  value: stat['value'],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CustColor.Light_Green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(flex:1,child: Icon(icon, size: 24, color: CustColor.Green)),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w500,color: CustColor.Gray))),
                Expanded(child: Text(value, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HostelExpensesCard extends StatelessWidget {
  final String hostelName;
  final String totalExpenses;
  final String monthlyExpenses;
  final String remainingBudget;

  // Constructor to accept data for the hostel expenses card
  HostelExpensesCard({
    required this.hostelName,
    required this.totalExpenses,
    required this.monthlyExpenses,
    required this.remainingBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hostel Title
            Text(
              hostelName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: StatBox(title: '2000', subtitle: "Today's Collection")),
                SizedBox(width: 10,),
                Expanded(child: StatBox(title: '56000', subtitle: "Dues till Date")),
              ],
            ),

            // Total Expenses Row
            // _buildExpenseRow(
            //   icon: FontAwesomeIcons.dollarSign,
            //   label: 'Total Expenses',
            //   value: totalExpenses,
            //   color: Colors.blue,
            // ),
            // SizedBox(height: 8),

            // Monthly Expenses Row
            // _buildExpenseRow(
            //   icon: FontAwesomeIcons.calendarAlt,
            //   label: 'Monthly Expenses',
            //   value: monthlyExpenses,
            //   color: Colors.green,
            // ),
            // SizedBox(height: 8),

            // Remaining Budget Row
            // _buildExpenseRow(
            //   icon: FontAwesomeIcons.wallet,
            //   label: 'Remaining Budget',
            //   value: remainingBudget,
            //   color: Colors.red,
            // ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the individual expense rows
  Widget _buildExpenseRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}



// Widget for Stats
class StatBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const StatBox({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustColor.Light_Green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( 
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
              decoration: BoxDecoration(color: Colors.black12,
                borderRadius: BorderRadius.circular(20)
              ),
              
              child: Image.asset('assets/icons/money.webp',width: 40,height: 40,)
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.indianRupeeSign,size: 25,color: CustColor.Blue_shade2,),
              Text(
                title,
                style: const TextStyle(
                  color: CustColor.Blue_shade2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CustColor.Gray,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
