function constantCallback()
{
   var _loc5_ = getTimer();
   var _loc3_ = _loc5_ - startTime;
   if(_loc3_ > initialDisplayTime + fadeOutTime)
   {
      clearInterval(intervalId);
      var _loc6_ = this.createEmptyMovieClip("empty",this.getNextHighestDepth());
      _loc6_.swapDepths(FullScreen_MC);
      FullScreen_MC.removeMovieClip();
      FullScreen_MC.FullScreen_text.text = "";
      _root.AlertResponseOverlayMessage = "close";
   }
   else if(_loc3_ > initialDisplayTime)
   {
      var _loc4_ = 1 - (_loc3_ - initialDisplayTime) / fadeOutTime;
      _loc4_ *= 100;
      FullScreen_MC._alpha = _loc4_;
   }
}
function movInit()
{
   startTime = getTimer();
   intervalId = setInterval(this,"constantCallback",timeInterval);
   _root.AlertResponseOverlayMessage = "layout";
   english_usStrings = new Object();
   english_usStrings.FullScreen = "Press Esc to exit full screen mode.";
   frenchStrings = new Object();
   frenchStrings.FullScreen = "Appuyez sur la touche Echap pour quitter le mode plein écran.";
   germanStrings = new Object();
   germanStrings.FullScreen = "Drücken Sie die Esc-Taste, um den Vollbildmodus zu beenden.";
   japaneseStrings = new Object();
   japaneseStrings.FullScreen = "フルスクリーンモードを終了するには Esc キーを押します。";
   spanishStrings = new Object();
   spanishStrings.FullScreen = "Presione Esc para salir del modo de pantalla completa.";
   italianStrings = new Object();
   italianStrings.FullScreen = "Premere Esc per uscire dalla modalità a schermo intero.";
   ptStrings = new Object();
   ptStrings.FullScreen = "Pressione Esc para sair do modo de tela cheia.";
   nlStrings = new Object();
   nlStrings.FullScreen = "Druk op Esc om de modus Volledig scherm af te sluiten.";
   svStrings = new Object();
   svStrings.FullScreen = "Tryck på Esc om du vill avsluta helskärmsläget.";
   koreanStrings = new Object();
   koreanStrings.FullScreen = "전체 화면 모드를 종료하려면 Esc 키를 누르십시오.";
   CHSStrings = new Object();
   CHSStrings.FullScreen = "按 Esc 退出全屏模式。";
   CHTStrings = new Object();
   CHTStrings.FullScreen = "請按 Esc 鍵以結束全螢幕模式。";
   csStrings = new Object();
   csStrings.FullScreen = "Režim zobrazení na celou obrazovku ukončíte stisknutím klávesy Esc.";
   plStrings = new Object();
   plStrings.FullScreen = "Naciśnij klawisz Esc, aby wyłączyć tryb pełnoekranowy.";
   ruStrings = new Object();
   ruStrings.FullScreen = "Нажмите кнопку Esc, чтобы выйти из полноэкранного режима.";
   trStrings = new Object();
   trStrings.FullScreen = "Tam ekran modundan çıkmak için Esc tuşuna basın.";
   var lang = System.capabilities.language;
   var isWindows = false;
   var isMac = false;
   var latinFont = "_sans";
   if(System.capabilities.os.indexOf("Windows",0) >= 0)
   {
      isWindows = true;
      latinFont = "Tahoma";
   }
   else if(System.capabilities.os.indexOf("Mac",0) >= 0)
   {
      isMac = true;
      latinFont = "Lucida Grande";
   }
   var language = "english_us";
   switch(lang)
   {
      case "en-US":
      case "en":
         language = "english_us";
         fontName = latinFont;
         break;
      case "de":
         language = "german";
         fontSize = 17;
         fontName = latinFont;
         break;
      case "fr":
         language = "french";
         fontSize = 17;
         fontName = latinFont;
         break;
      case "zh-TW":
         language = "CHT";
         break;
      case "zh-CN":
         language = "CHS";
         break;
      case "ja":
         language = "japanese";
         break;
      case "ko":
         language = "korean";
         break;
      case "it":
         language = "italian";
         fontName = latinFont;
         fontSize = 18;
         break;
      case "es":
         language = "spanish";
         fontName = latinFont;
         fontSize = 19;
         break;
      case "pt":
      case "pt-Br":
         language = "pt";
         fontName = latinFont;
         fontSize = 19;
         break;
      case "nl":
         language = "nl";
         fontSize = 17;
         fontName = latinFont;
         break;
      case "sv":
         language = "sv";
         fontSize = 17;
         fontName = latinFont;
         break;
      case "cs":
         language = "cs";
         fontSize = 17;
         break;
      case "pl":
         language = "pl";
         fontSize = 17;
         break;
      case "ru":
         language = "ru";
         fontSize = 17;
         break;
      case "tr":
         language = "tr";
         fontSize = 17;
         break;
      default:
         language = "english_us";
   }
   if(_root.FullScreenAlertText == undefined)
   {
      ls = eval(language + "Strings");
      FullScreen_MC.FullScreen_text.text = ls.FullScreen;
   }
   else
   {
      FullScreen_MC.FullScreen_text.text = _root.FullScreenAlertText;
   }
   theStyle = new TextFormat();
   theStyle.size = fontSize;
   theStyle.font = fontName;
   FullScreen_MC.FullScreen_text.setTextFormat(theStyle);
}
var initialDisplayTime = 3000;
var fadeOutTime = 1000;
var timeInterval = 25;
var intervalID = 0;
var fontSize = 20;
var fontName = "_sans";
var startTime = 0;
movInit();
