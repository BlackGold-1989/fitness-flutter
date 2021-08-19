class StringService {
  static String getTime(DateTime dateTime) {
    var strHour = '${dateTime.hour}';
    if (dateTime.hour < 10) {
      strHour = '0$strHour';
    }
    var strMin = '${dateTime.minute}';
    if (dateTime.minute < 10) {
      strMin = '0$strMin';
    }
    return '$strHour : $strMin';
  }

  static String getTimeByString(String time) {
    var value = int.parse(time);
    if (value == 0) return '-- : --';
    int valMin = ((value - (value % 60)) / 60).round();
    var strMin = '$valMin';
    if (valMin < 10) {
      strMin = '0$strMin';
    }
    int valSec = value % 60;
    var strSec = '$valSec';
    if (valSec < 10) {
      strSec = '0$strSec';
    }
    return '$strMin : $strSec';
  }

  static String getFavCount(int fav) {
    if (fav == 0) {
      return 'Not';
    } else if (fav < 10) {
      return '1+';
    } else if (fav < 20) {
      return '10+';
    } else if (fav < 50) {
      return '20+';
    } else if (fav < 100) {
      return '50+';
    } else if (fav < 200) {
      return '100+';
    } else if (fav < 500) {
      return '200+';
    } else if (fav < 1000) {
      return '500+';
    } else if (fav < 10000) {
      return '1K+';
    } else if (fav < 100000) {
      return '10K+';
    } else if (fav < 1000000) {
      return '100K+';
    } else {
      return '1M+';
    }
  }
}
