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
