double getPBBKetemuKP(int nNJOPKP) {
  if (nNJOPKP <= 1000000000) {
    return 1 / 1000 * nNJOPKP;
  } else if (nNJOPKP > 1000000000) {
    return 1 / 500 * nNJOPKP;
  } else {
    return 0.0;
  }
}

double getPBBGatauKP(int nNJOP, int nNJOPTKP) {
  int n = nNJOP - nNJOPTKP;
  if (n <= 1000000000) {
    return 1 / 1000 * n;
  } else if (n > 1000000000) {
    return 1 / 500 * n;
  } else {
    return 0.0;
  }
}
