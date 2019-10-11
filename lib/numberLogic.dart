


List<String> numberLogic(String number) {
    var digit;

    List<String> files = <String>[];  

    String firstAudio;
    String secondAudio;

    digit = number.toString();

     if(digit.length == 1 || (digit.length == 2 &&  digit[1] == '0') || (digit.length >= 3)) {
      print("One time Calling Number #### $digit");

      switch (digit[0]) {
        case '0':
          firstAudio = 'one.m4a';
          break;     
        case '1':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'ten.m4a';
            }
          } else if (digit.length > 2 || digit == '100'){
            firstAudio = 'hundred.m4a';
          } else {
            firstAudio = 'one.m4a';
          }
          break;
        case '2':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'twenty.m4a';
            }
          } else {
            firstAudio = 'two.m4a';
          }
          break;
        case '3':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'thirty.m4a';
            }
          } else {
            firstAudio = 'three.m4a';
          }
          break;
        case '4':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'forty.m4a';
            }
          } else {
            firstAudio = 'four.m4a';
          }
          break;
        case '5':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'fifty.m4a';
            }
          } else {
            firstAudio = 'five.m4a';
          }
          break;
        case '6':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'sixty.m4a';
            }
          } else {
            firstAudio = 'six.m4a';
          }
          break;     
        case '7':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'seventy.m4a';
            }
          } else {
            firstAudio = 'seven.m4a';
          }
          break;     
        case '8':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'eighty.m4a';
            }
          } else {
            firstAudio = 'eight.m4a';
          }
          break;   
        case '9':
          if(digit.length == 2) {
            if(digit[1] == '0') {
              firstAudio = 'ninety.m4a';
            }
          } else {
            firstAudio = 'nine.m4a';
          }
          break;           
        default:
          firstAudio = 'one.m4a';
      }
      files.add('notification.mp3');
      files.add(firstAudio);


      return files;

    } else if(digit.length == 2){
      print("Two time calling numbers ### ");

      switch (digit[0]) {
        case '1':
          firstAudio = 'tenMore.m4a';
          break;
        case '2':
          firstAudio = 'twentyMore.m4a';
          break;
        case '3':
          firstAudio = 'thirtyMore.m4a';
          break;
        case '4':
          firstAudio = 'fortyMore.m4a';
          break;
        case '5':
          firstAudio = 'fiftyMore.m4a';
          break; 
        case '6':
          firstAudio = 'sixtyMore.m4a';
          break; 
        case '7':
          firstAudio = 'seventyMore.m4a';
          break; 
        case '8':
          firstAudio = 'eightyMore.m4a';
          break; 
        case '9':
          firstAudio = 'ninetyMore.m4a';
          break;      
        default:
          firstAudio = '';
      }

      switch (digit[1]) {  
        case '1':
          secondAudio = 'one.m4a';
          break;
        case '2':
          secondAudio = 'two.m4a';
          break;
        case '3':
          secondAudio = 'three.m4a';
          break;
        case '4':
          secondAudio = 'four.m4a';
          break;
        case '5':
          secondAudio = 'five.m4a';
          break;
        case '6':
          secondAudio = 'six.m4a';
          break;     
        case '7':
          secondAudio = 'seven.m4a';
          break;     
        case '8':
          secondAudio = 'eight.m4a';
          break;   
        case '9':
          secondAudio = 'nine.m4a';
          break;           
        default:
          secondAudio = 'one.m4a';
      }

      files.add('notification.mp3');
      files.add(firstAudio);
      files.add(secondAudio);
      return files;
         //play music callback
      // audioTools.loadFile(secondAudio).then( (_){audioTools.playAudioLoop(secondAudio);});

    }
}

 