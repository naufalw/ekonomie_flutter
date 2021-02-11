import 'package:Ekonomie/backend/hitung_pajak.dart';
import 'package:Ekonomie/constants/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prefs/prefs.dart';

class PBBHasilScreen extends StatefulWidget {
  const PBBHasilScreen({this.nNJOP, this.nNJOPKP, this.nNJOPTKP});
  final double nNJOP;
  final double nNJOPKP;
  final double nNJOPTKP;

  @override
  _PBBHasilScreenState createState() => _PBBHasilScreenState();
}

class _PBBHasilScreenState extends State<PBBHasilScreen> {
  double nNJOP = 0;
  double nNJOPKP = 0;
  double nNJOPTKP = 0;
  double nPBBTerutang = 0;
  var besarPersen;
  var valueBesarPersen;
  var statusNJOPKP;
  var valueNJOPKP;

  void getHasil() async {
    nNJOP = widget.nNJOP ?? 0;
    nNJOPKP = widget.nNJOPKP ?? 0;
    nNJOPTKP = widget.nNJOPTKP ?? 0;
    besarPersen = await Prefs.getStringF("PBBMode");
    statusNJOPKP = await Prefs.getStringF("NJOPMode");
    if (statusNJOPKP == "Diketahui") {
      nPBBTerutang = getPBBKetemuKP(nNJOPKP, besarPersen);
    } else if (statusNJOPKP == "Tidak Diketahui") {
      nPBBTerutang = getPBBGatauKP(nNJOP, nNJOPTKP, besarPersen);
    }
    if (besarPersen == "Auto") {
      if (nNJOP <= 1000000000) {
        valueBesarPersen = "20%";
      } else {
        valueBesarPersen = "40%";
      }
    } else {
      valueBesarPersen = besarPersen;
    }
    valueNJOPKP = nNJOP - nNJOPTKP;
    if (statusNJOPKP != null) {
      setState(() {});
    }
  }

  List<Widget> getWidgetList() {
    if (statusNJOPKP == "Diketahui") {
      return [
        NJOPKPCard(
          value: nNJOPKP,
          subtitle: "NJOPKP sudah diketahui yaitu $nNJOPKP",
        ),
        PBBTerutangCard(
          value: nPBBTerutang,
          subtitle:
              "PBB = NJOPKP x 0.5% x 40% atau 20%\nPBB = $nNJOPKP x 0.5% x $valueBesarPersen\nPBB = $nPBBTerutang",
        )
      ];
    } else if (statusNJOPKP == "Tidak Diketahui") {
      return [
        NJOPCard(
          value: nNJOP,
          subtitle: "NJOP Sudah diketahui yaitu $nNJOP",
        ),
        NJOPTKPCard(
          value: nNJOPTKP,
          subtitle: "NJOPTKP sudah diketahui yaitu $nNJOPTKP",
        ),
        NJOPKPCard(
          value: valueNJOPKP,
          subtitle:
              "NJOPKP = NJOP - NJOPTKP\nNJOPKP = $nNJOP - $nNJOPTKP\nNJOPKP = $valueNJOPKP",
        ),
        PBBTerutangCard(
          value: nPBBTerutang,
          subtitle:
              "PBB = NJOPKP x 0.5% x 40% atau 20%\nPBB = $valueNJOPKP x 0.5% x $valueBesarPersen\nPBB = $nPBBTerutang",
        )
      ];
    } else {
      return [];
    }
  }

  @override
  void initState() {
    getHasil();
    super.initState();
  }

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
          children: getWidgetList(),
        ),
      ),
    );
  }
}

class PBBTerutangCard extends StatelessWidget {
  const PBBTerutangCard({this.value, this.subtitle});

  final double value;
  final String subtitle;

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
        subtitle: Text(value.toString(),
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text(
            subtitle,
            style: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(14.5),
            ),
          ),
        ],
      ),
    );
  }
}

class NJOPCard extends StatelessWidget {
  const NJOPCard({this.value, this.subtitle});

  final double value;
  final String subtitle;
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
          "NJOP",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text(value.toString(),
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text(
            subtitle,
            style: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(14.5),
            ),
          )
        ],
      ),
    );
  }
}

class NJOPTKPCard extends StatelessWidget {
  const NJOPTKPCard({this.value, this.subtitle});

  final double value;
  final String subtitle;
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
          "NJOPTKP",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text(value.toString(),
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text(subtitle,
              style: GoogleFonts.hammersmithOne(
                fontSize: ScreenUtil().setSp(14.5),
              )),
        ],
      ),
    );
  }
}

class NJOPKPCard extends StatelessWidget {
  const NJOPKPCard({this.value, this.subtitle});

  final double value;
  final String subtitle;
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
          "NJOPKP",
          style: GoogleFonts.hammersmithOne(fontSize: ScreenUtil().setSp(21)),
        ),
        subtitle: Text(value.toString(),
            style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(16))),
        children: [
          Divider(
            thickness: 2.0,
            height: 2.0,
          ),
          Text(subtitle,
              style: GoogleFonts.hammersmithOne(
                fontSize: ScreenUtil().setSp(14.5),
              )),
        ],
      ),
    );
  }
}
