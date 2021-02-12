double getPBBKetemuKP(double nNJOPKP, String besarPersen) {
  if (besarPersen == "Auto") {
    if (nNJOPKP <= 1000000000) {
      return 1 / 1000 * nNJOPKP;
    } else if (nNJOPKP > 1000000000) {
      return 1 / 500 * nNJOPKP;
    } else {
      return 0.0;
    }
  } else if (besarPersen == "20%") {
    return 1 / 1000 * nNJOPKP;
  } else if (besarPersen == "40%") {
    return 1 / 500 * nNJOPKP;
  } else {
    return 0;
  }
}

double getPBBGatauKP(double nNJOP, double nNJOPTKP, String besarPersen) {
  double nNJOPKP = nNJOP - nNJOPTKP;
  if (besarPersen == "Auto") {
    if (nNJOP <= 1000000000) {
      return 1 / 1000 * nNJOPKP;
    } else if (nNJOP > 1000000000) {
      return 1 / 500 * nNJOPKP;
    } else {
      return 0.0;
    }
  } else if (besarPersen == "20%") {
    return 1 / 1000 * nNJOPKP;
  } else if (besarPersen == "40%") {
    return 1 / 500 * nNJOPKP;
  } else {
    return 0;
  }
}

double getPPHKetemuPKP(double nPKP) {
  double nPPH = 0.0;
  if (nPKP < 50000000) {
    nPPH = 5 / 100 * nPKP;
    return nPPH;
  } else if (nPKP >= 50000000 && nPKP < 250000000) {
    var dikurang50jeti = nPKP - 50000000;
    nPPH += 50000000 * 5 / 100;
    nPPH += dikurang50jeti * 15 / 100;
    return nPPH;
  } else if (nPKP >= 250000000 && nPKP < 500000000) {
    var dikurang50jeti = nPKP - 50000000;
    nPPH += 50000000 * 5 / 100;
    nPPH += dikurang50jeti * 15 / 100;
    return nPPH;
  } else {
    return 0;
  }
}
