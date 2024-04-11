enum Band {
  meters160(1800, 2000),
  meters80(3500, 4000),
  meters60(5332, 5405),
  meters40(7000, 7300),
  meters30(10100, 10150),
  meters20(14000, 14350),
  meters17(18068, 18168),
  meters15(21000, 21450),
  meters12(24890, 24990),
  meters10(28000, 29700),
  meters6(50000, 54000),
  meters2(144000, 148000),
  meters125(222000, 225000),
  centimeters70(420000, 450000),
  centimeters33(902000, 928000),
  centimeters23(1240000, 1300000);

  final int lowerFrequencyKHz;
  final int upperFrequencyKHz;

  const Band(this.lowerFrequencyKHz, this.upperFrequencyKHz);

  static Band? getBand(double frequencyKHz) {
  // Convert the double to int to avoid floating-point precision issues
  // during comparison with integer bounds
  final int roundedFrequency = frequencyKHz.round();
  return values.where((band) =>
      roundedFrequency >= band.lowerFrequencyKHz && roundedFrequency <= band.upperFrequencyKHz).firstOrNull;
}
}
