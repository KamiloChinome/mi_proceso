import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:miprocesoapp/providers/add_process_swich_provider.dart';
import 'package:miprocesoapp/providers/button_provider.dart';
import 'package:miprocesoapp/values/colors.dart';
import 'package:miprocesoapp/values/texts.dart';
import 'package:miprocesoapp/widgets/add_process_text_formfield.dart';
import 'package:miprocesoapp/widgets/dropdown_button.dart';
import 'package:provider/provider.dart';

class AddProcessScreen extends StatelessWidget {
  
  const AddProcessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ButtonProvider()),
        ChangeNotifierProvider(create: (context) => AddProcessSwichProvider()),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(sizeHeight*0.1),
          child: const _AppBar(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: _AddProcessFormat(sizeHeight: sizeHeight, sizeWidth: sizeWidth,),
          ),
        )
      ),
    );
  }
}

class _AddProcessFormat extends StatelessWidget {
  const _AddProcessFormat({
    Key? key,
    required this.sizeHeight, required this.sizeWidth,
  }) : super(key: key);

  final double sizeHeight;
  final double sizeWidth;

  @override
  Widget build(BuildContext context) {

    bool isVisible = Provider.of<AddProcessSwichProvider>(context).swich;

    return Column(
      children: [
        SizedBox(height: sizeHeight * 0.03,),
        const Text(addProcessInstruction, style: TextStyle(fontSize: 19, fontFamily: poppinsB),),
        SizedBox(height: sizeHeight * 0.014,),
        _Swich(isVisible: isVisible),
        SizedBox(height: sizeHeight * 0.014,),
        Column(
          children: [
            Visibility(
              visible: !isVisible,
              child: FadeInUp(
                from: 30,
                child: Column(
                  children: [
                    TextFormFieldFormat(
                      sizeWidth: sizeWidth,
                      counterText: '23',
                      hintText: addProcesshinText,
                      labelText: addProcessLabelText,
                      maxLength: 23, icon: Icons.numbers,
                      suffixIcon: Icons.search,
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: isVisible,
          child: FadeInUp(
            from: 30,
            child: Column(
              children: [
                const AddProcessDropDownButton(icon: Icons.place_outlined,),
                SizedBox(height: sizeHeight * 0.03,),
                TextFormFieldFormat(
                  sizeWidth: sizeWidth,
                  counterText: '3',
                  hintText: deliveryHintText,
                  labelText: deliveryLabelText,
                  maxLength: 3,
                  icon: Icons.confirmation_number_outlined, suffixIcon: null,
                ),
                TextFormFieldFormat(
                  sizeWidth: sizeWidth,
                  counterText: '4',
                  hintText: yearHintText,
                  labelText: yearLabelText,
                  maxLength: 4,
                  icon: Icons.calendar_month_outlined, suffixIcon: null,
                ),
                TextFormFieldFormat(
                  sizeWidth: sizeWidth,
                  counterText: '5',
                  hintText: fileNumberHintText,
                  labelText: fileNumberLabelText,
                  maxLength: 5,
                  icon: Icons.file_present, suffixIcon: null,
                ),
                TextFormFieldFormat(
                  sizeWidth: sizeWidth,
                  counterText: '2',
                  hintText: consecutiveNumberHintText,
                  labelText: consecutiveNumberLabelText,
                  maxLength: 2,
                  icon: Icons.content_paste_search_outlined, suffixIcon: null,
                ),
                OutlinedButton(
                style: OutlinedButton.styleFrom(
                elevation: 10,
                  // padding: EdgeInsets.all(),
                  minimumSize: const Size(120, 50),
                  backgroundColor: verdeLitigio,
                  shape: const StadiumBorder()
                ),
                child: const Text(search, style: TextStyle(color: marca1, fontSize: 18),),
                onPressed: (){
                  //TODO Buscar proceso
                },
              )
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}

class _Swich extends StatelessWidget {

  final bool isVisible;
  _Swich({
    Key? key, required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
      width: 193,
      textOff: 'Numero completo',
      textOn: 'Construir numero',
      iconOff: Icons.numbers,
      iconOn: Icons.build,
      colorOn: verdeLitigio,
      colorOff: opcion2,
      value: false,
      onTap: (){}, 
      onDoubleTap: (){}, 
      onSwipe: (){}, 
      onChanged: (_){
        Provider.of<AddProcessSwichProvider>(context, listen: false).swich = !Provider.of<AddProcessSwichProvider>(context, listen: false).swich;
      }
    );
  }
}



class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: appBarbackgroundColor,
      leading:  GestureDetector(
        onTap: () {
          Provider.of<ButtonProvider>(context, listen: false).selectedButton = 0;
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,)
      ),
      title: Stack(
        children:  [
          Column(
            children: const[
              Text(userName, style: TextStyle(fontFamily: poppinsR),),
              Text(addProcess, style: TextStyle(fontFamily: poppinsR),),
            ],
          )
        ],
      ),
    );
  }
}