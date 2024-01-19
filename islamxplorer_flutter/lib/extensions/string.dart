extension CapitalizeFirstLetter on String {
  get capitalizeFirstLetter {
    return this.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).join(' ');
  }
}

extension Validation on String {
  bool isEnglish() {
    final englishRegex = RegExp(r'^[a-zA-Z\s\.,;\"!?()]+');
    return englishRegex.hasMatch(this);
  }

  bool isArabic() {
    final arabicRegex = RegExp(r'[\u0600-\u06FF\s\.,;\"!?()]+$');
    return arabicRegex.hasMatch(this);
  }
}