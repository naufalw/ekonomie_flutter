import 'package:Ekonomie/constants/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_fonts/google_fonts.dart';

class PBBHasilScreen extends StatefulWidget {
  const PBBHasilScreen({this.nNJOP, this.nNJOPKP, this.nNJOPTKP});
  final int nNJOP;
  final int nNJOPKP;
  final int nNJOPTKP;

  @override
  _PBBHasilScreenState createState() => _PBBHasilScreenState();
}

class _PBBHasilScreenState extends State<PBBHasilScreen> {
  int nNJOP = 0;
  int nNJOPKP = 0;
  int nNJOPTKP = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil PBB",
          style: GoogleFonts.secularOne(),
        ),
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
        child: Column(
          children: [PBBTerutangCard()],
        ),
      ),
    );
  }
}

class PBBTerutangCard extends StatelessWidget {
  const PBBTerutangCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setWidth(12),
      ),
      child: ExpansionTileCard(
        elevation: 0.0,
        baseColor: kSecondaryColor,
        expandedColor: kSecondaryColor,
        title: Text(
          "PBB Terutang",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(22)),
        ),
        subtitle: Text("Rp. 2.000.000",
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text(
            "NJOPKP = NJOP - NJOPTKP",
            style: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(18),
            ),
          ),
          Text(
            "NJOPKP = 2.000.000 - 1.000.000",
            style: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(18),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "NJOPKP = 1.000.000",
            style: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(18),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class NJOPCard extends StatelessWidget {
  const NJOPCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setWidth(12),
      ),
      child: ExpansionTileCard(
        elevation: 0.0,
        baseColor: kSecondaryColor,
        expandedColor: kSecondaryColor,
        title: Text(
          "PBB Terutang",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text("Rp. 2.000.000",
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text("Cara : "),
          Text("NJOPKP = NJOP - NJOPTKP")
        ],
      ),
    );
  }
}

class NJOPTKPCard extends StatelessWidget {
  const NJOPTKPCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setWidth(12),
      ),
      child: ExpansionTileCard(
        elevation: 0.0,
        baseColor: kSecondaryColor,
        expandedColor: kSecondaryColor,
        title: Text(
          "PBB Terutang",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text("Rp. 2.000.000",
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text("Cara : "),
          Text("NJOPKP = NJOP - NJOPTKP")
        ],
      ),
    );
  }
}

class NJOPKPCard extends StatelessWidget {
  const NJOPKPCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setWidth(12),
      ),
      child: ExpansionTileCard(
        elevation: 0.0,
        baseColor: kSecondaryColor,
        expandedColor: kSecondaryColor,
        title: Text(
          "PBB Terutang",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text("Rp. 2.000.000",
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text("Cara : "),
          Text("NJOPKP = NJOP - NJOPTKP")
        ],
      ),
    );
  }
}
