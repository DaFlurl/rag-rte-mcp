package autoevony.gui.controls.themes
{
   import flash.utils.describeType;
   
   public class Themes
   {
      public function Themes()
      {
         super();
      }
      
      public function get Classic_Blue_RE_Theme() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.mainApp = {
            "backgroundColor":1719386,
            "backgroundGradientAlphas":[0,0]
         };
         _loc1_.ToolTip = {
            "cornerRadius":3,
            "paddingTop":7,
            "paddingBottom":7,
            "paddingLeft":8,
            "paddingRight":8,
            "color":16777215,
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "backgroundColor":2302752,
            "backgroundAlpha":0.93
         };
         _loc1_._REmainLoginForm = {
            "cornerRadius":3,
            "borderColor":549,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":3429492,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REmainFormText = {
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215
         };
         _loc1_._REmainScreen = {
            "backgroundAlpha":1,
            "backgroundImage":ThemeAssets._embed_classicBlue_winCloseBtnOver_png,
            "backgroundSize":"100%"
         };
         _loc1_._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
         _loc1_._REmainScreenTopNameText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":15,
            "color":16777215,
            "top":6
         };
         _loc1_._REmainScreenServerClockTimeField = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":21,
            "color":16777215
         };
         _loc1_._REmainScreenMainPanel = {
            "borderColor":9,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":2178133,
            "backgroundAlpha":1
         };
         _loc1_._REtoggleBox = {
            "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
            "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
            "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
            "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
            "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
            "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
         };
         _loc1_._REcheckBox = {
            "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
            "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
            "upIcon":ThemeAssets._embed_checkBox_png,
            "overIcon":ThemeAssets._embed_checkBox_png,
            "downIcon":ThemeAssets._embed_checkBox_png
         };
         _loc1_._txtAreaStyle = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":16777215,
            "backgroundColor":3755106,
            "backgroundAlpha":1,
            "themeColor":66090,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._inputArea = {
            "textAlign":"left",
            "cornerRadius":5,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":1052688,
            "backgroundColor":16382456,
            "backgroundDisabledColor":13290185,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2236962,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._RElogBox = {
            "textAlign":"left",
            "color":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16448249,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._clearLogBtn = {
            "upSkin":ThemeAssets._embed_clearLogBtn_png,
            "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
            "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearLogBtn_png
         };
         _loc1_._REchatBox = {
            "textAlign":"left",
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16514042,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "bottom":0,
            "right":0
         };
         _loc1_._REdataGrid = {
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontThickness":20,
            "headerColors":[2178133,66090],
            "themeColor":66090,
            "rollOverColor":12439022,
            "selectionColor":8376063,
            "alternatingItemColors":[14021110,15399678],
            "backgroundDisabledColor":11123913,
            "horizontalGridLines":true,
            "horizontalGridLineColor":6456228,
            "verticalGridLines":true,
            "verticalGridLineColor":5468302,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1
         };
         _loc1_._columnHeaderSyle = {
            "color":16777215,
            "fontSize":12,
            "fontWeight":"normal",
            "fontThickness":120
         };
         _loc1_._REwinBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":66090,
            "themeColor":66090,
            "color":66090,
            "textRollOverColor":66090,
            "disabledColor":6185371,
            "fillColors":[16772173,16745293,16772689,16745293],
            "fillAlphas":[0.9,0.85,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinOkayBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":66090,
            "themeColor":2329600,
            "color":66090,
            "textRollOverColor":1072128,
            "disabledColor":6185371,
            "fillColors":[16772173,16745293,12181931,5878091],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinCancelBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":66090,
            "themeColor":15425889,
            "color":66090,
            "textRollOverColor":8519680,
            "disabledColor":6185371,
            "fillColors":[16772173,16745293,15117227,11946827],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REpopupWinBase = {
            "cornerRadius":3,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":4552359,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REpopupWinTitleText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":13,
            "color":16777215,
            "top":6
         };
         _loc1_._REnumStepUpBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepUp_png
         };
         _loc1_._REnumStepDnBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepDn_png
         };
         _loc1_._REaddBtn = {
            "width":12,
            "height":12,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addIcon_png,
            "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
         };
         _loc1_._REaddAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
         };
         _loc1_._REsubAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_subAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
         };
         _loc1_._horizontalSeparator2pxLine = {
            "height":2,
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoLine_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoDarkFadedBackground = {
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoBackGrnd_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoText = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontThickness":20,
            "fontWeight":"bold",
            "fontSize":13
         };
         _loc1_._newArmyTroop = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12
         };
         _loc1_._REtabBar = {
            "fontFamily":"DejaVu Sans",
            "fontThickness":0
         };
         _loc1_._REtabBarTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":66090,
            "themeColor":66090,
            "backgroundColor":855604,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[2178133,66090,3230826,2178133],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarAccountTabs = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":66090,
            "themeColor":66090,
            "backgroundColor":16763740,
            "color":66090,
            "textRollOverColor":66090,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[16772173,16745293,16772689,16745293],
            "fillAlphas":[0.9,0.85,1,1]
         };
         _loc1_._REtabBarCitiesTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "horizontalGap":0,
            "cornerRadius":3,
            "borderColor":66090,
            "themeColor":66090,
            "backgroundColor":855604,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[2178133,66090,2243927,395058],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REmailComposeView = {"backgroundColor":3755106};
         _loc1_._ComboBox = {
            "cornerRadius":3,
            "fontAlign":"center",
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":66090,
            "textRollOverColor":66090,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":66090,
            "themeColor":489687,
            "fillColors":[16772173,16745293,16772689,16745293],
            "fillAlphas":[1,1,1,1],
            "focusAlpha":0,
            "dropdownStyleName":"comboBoxDropdown"
         };
         _loc1_._comboBoxDropdown = {
            "cornerRadius":3,
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":66090,
            "backgroundColor":16771515,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":66090,
            "themeColor":489687
         };
         _loc1_._nextBtn = {
            "upSkin":ThemeAssets._embed_RE_nextBtn_png,
            "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
         };
         _loc1_._previousBtn = {
            "upSkin":ThemeAssets._embed_RE_previousBtn_png,
            "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
         };
         _loc1_._refreshBtn = {
            "upSkin":ThemeAssets._embed_refreshBtn_png,
            "downSkin":ThemeAssets._embed_refreshBtnDown_png,
            "overSkin":ThemeAssets._embed_refreshBtnOver_png,
            "disabledSkin":ThemeAssets._embed_refreshBtn_png
         };
         _loc1_._editBtn = {
            "upSkin":ThemeAssets._embed_editButton_png,
            "downSkin":ThemeAssets._embed_editBtnDown_png,
            "overSkin":ThemeAssets._embed_editBtnOver_png,
            "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
         };
         _loc1_._clearTextBtn = {
            "upSkin":ThemeAssets._embed_clearTextBtn_png,
            "downSkin":ThemeAssets._embed_clearTextBtn_png,
            "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearTextBtn_png
         };
         _loc1_._close = {
            "upSkin":ThemeAssets._embed_winCloseBtn_png,
            "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
            "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
            "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
         };
         _loc1_._textBackground = {
            "cornerRadius":3,
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215,
            "borderColor":549,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":2178133,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":3,
            "paddingBottom":3,
            "focusAlpha":0
         };
         _loc1_._chatInput = {
            "fontSize":13,
            "fontFamily":"DejaVu Sans",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._textInput = {
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._labelWithBackGround = {
            "textAlign":"center",
            "color":16777215,
            "backgroundAlpha":0,
            "fontSize":12,
            "borderStyle":"none",
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._PropertyName1 = {
            "color":16777215,
            "fontWeight":"bold",
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._ParamgraphText1 = {
            "color":16777215,
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._focusColor = {
            "color":16777215,
            "fontFamily":"DejaVu Sans"
         };
         return _loc1_;
      }
      
      public function get Burgundy_by_Ioshik_Theme() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.mainApp = {
            "backgroundColor":14384999,
            "backgroundGradientAlphas":[0,0]
         };
         _loc1_.ToolTip = {
            "cornerRadius":3,
            "paddingTop":7,
            "paddingBottom":7,
            "paddingLeft":8,
            "paddingRight":8,
            "color":15655381,
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "backgroundColor":4139307,
            "backgroundAlpha":0.93
         };
         _loc1_._REmainLoginForm = {
            "cornerRadius":5,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":10713971,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REmainFormText = {
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215
         };
         _loc1_._REmainScreen = {
            "backgroundAlpha":0,
            "backgroundImage":null
         };
         _loc1_._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_rePopUpWinTitleBg_png};
         _loc1_._REmainScreenTopNameText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":15,
            "color":16777215,
            "top":4
         };
         _loc1_._REmainScreenServerClockTimeField = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":21,
            "color":16777215
         };
         _loc1_._REmainScreenMainPanel = {
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":10713971,
            "backgroundAlpha":1
         };
         _loc1_._REtoggleBox = {
            "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
            "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
            "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
            "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
            "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
            "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
         };
         _loc1_._REcheckBox = {
            "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
            "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
            "upIcon":ThemeAssets._embed_checkBox_png,
            "overIcon":ThemeAssets._embed_checkBox_png,
            "downIcon":ThemeAssets._embed_checkBox_png
         };
         _loc1_._txtAreaStyle = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":16777215,
            "backgroundColor":4139307,
            "backgroundAlpha":1,
            "themeColor":4139307,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._inputArea = {
            "textAlign":"left",
            "cornerRadius":5,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":1052688,
            "backgroundColor":16382456,
            "backgroundDisabledColor":10790686,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2236962,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._RElogBox = {
            "textAlign":"left",
            "color":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":15853276,
            "themeColor":4139307,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._clearLogBtn = {
            "upSkin":ThemeAssets._embed_clearLogBtn_png,
            "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
            "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearLogBtn_png
         };
         _loc1_._REchatBox = {
            "textAlign":"left",
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":15853276,
            "themeColor":4139307,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "bottom":0,
            "right":0
         };
         _loc1_._REdataGrid = {
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontThickness":20,
            "headerColors":[14797234,10713971],
            "themeColor":4139307,
            "rollOverColor":14384999,
            "selectionColor":10713971,
            "alternatingItemColors":[15325127,15655381],
            "backgroundDisabledColor":7958052,
            "horizontalGridLines":true,
            "horizontalGridLineColor":14797234,
            "verticalGridLines":true,
            "verticalGridLineColor":14797234,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1
         };
         _loc1_._columnHeaderSyle = {
            "color":4139307,
            "fontSize":12,
            "fontWeight":"normal",
            "fontThickness":120
         };
         _loc1_._REwinBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":6429440,
            "color":592654,
            "textRollOverColor":592654,
            "disabledColor":5592405,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinOkayBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":2329600,
            "color":592654,
            "textRollOverColor":1072128,
            "disabledColor":5592405,
            "fillColors":[14797234,10713971,12181931,5878091],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinCancelBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":15425889,
            "color":592654,
            "textRollOverColor":8519680,
            "disabledColor":5592405,
            "fillColors":[14797234,10713971,15117227,11946827],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REpopupWinBase = {
            "cornerRadius":3,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":14797234,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REpopupWinTitleText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":13,
            "color":16777215,
            "top":4
         };
         _loc1_._REnumStepUpBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":4139307,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepUp_png
         };
         _loc1_._REnumStepDnBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":4139307,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepDn_png
         };
         _loc1_._REaddBtn = {
            "width":12,
            "height":12,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":4139307,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addIcon_png,
            "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
         };
         _loc1_._REaddAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":4139307,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
         };
         _loc1_._REsubAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":4139307,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_subAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
         };
         _loc1_._horizontalSeparator2pxLine = {
            "height":2,
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoDarkFadedBackground = {
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoText = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontThickness":20,
            "fontWeight":"bold",
            "fontSize":13
         };
         _loc1_._newArmyTroop = {
            "color":4139307,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12
         };
         _loc1_._REtabBar = {
            "fontFamily":"DejaVu Sans",
            "fontThickness":0
         };
         _loc1_._REtabBarTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2105893,
            "themeColor":4139307,
            "backgroundColor":14797234,
            "color":66090,
            "textRollOverColor":66090,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[14797234,10713971,14797234,10713971],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarAccountTabs = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2237479,
            "themeColor":3290167,
            "backgroundColor":14797234,
            "color":461068,
            "textRollOverColor":461068,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[14797234,12888997,15127232,14797234],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarCitiesTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "horizontalGap":0,
            "cornerRadius":0,
            "borderColor":3289909,
            "backgroundColor":14797234,
            "themeColor":4139307,
            "color":1118481,
            "textRollOverColor":66090,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[14797234,10713971,15117227,15117227],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REmailComposeView = {"backgroundColor":10713971};
         _loc1_._ComboBox = {
            "cornerRadius":3,
            "fontAlign":"center",
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "textRollOverColor":1118481,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":15655381,
            "fillColors":[14797234,10713971,15127232,14797234],
            "fillAlphas":[1,1,1,1],
            "focusAlpha":0,
            "dropdownStyleName":"comboBoxDropdown"
         };
         _loc1_._comboBoxDropdown = {
            "cornerRadius":3,
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "backgroundColor":14797234,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":14384999
         };
         _loc1_._nextBtn = {
            "upSkin":ThemeAssets._embed_RE_nextBtn_png,
            "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
         };
         _loc1_._previousBtn = {
            "upSkin":ThemeAssets._embed_RE_previousBtn_png,
            "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
         };
         _loc1_._refreshBtn = {
            "upSkin":ThemeAssets._embed_refreshBtn_png,
            "downSkin":ThemeAssets._embed_refreshBtnDown_png,
            "overSkin":ThemeAssets._embed_refreshBtnOver_png,
            "disabledSkin":ThemeAssets._embed_refreshBtn_png
         };
         _loc1_._editBtn = {
            "upSkin":ThemeAssets._embed_editButton_png,
            "downSkin":ThemeAssets._embed_editBtnDown_png,
            "overSkin":ThemeAssets._embed_editBtnOver_png,
            "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
         };
         _loc1_._clearTextBtn = {
            "upSkin":ThemeAssets._embed_clearTextBtn_png,
            "downSkin":ThemeAssets._embed_clearTextBtn_png,
            "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearTextBtn_png
         };
         _loc1_._close = {
            "upSkin":ThemeAssets._embed_winCloseBtn_png,
            "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
            "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
            "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
         };
         _loc1_._textBackground = {
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":14384999,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":3,
            "paddingBottom":3,
            "focusAlpha":0
         };
         _loc1_._chatInput = {
            "fontSize":13,
            "fontFamily":"DejaVu Sans",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":15853276,
            "backgroundDisabledColor":14474459
         };
         _loc1_._textInput = {
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":15853276,
            "backgroundDisabledColor":14474459
         };
         _loc1_._labelWithBackGround = {
            "textAlign":"center",
            "color":16777215,
            "backgroundAlpha":0,
            "fontSize":12,
            "borderStyle":"none",
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._PropertyName1 = {
            "color":16777215,
            "fontWeight":"bold",
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._ParamgraphText1 = {
            "color":16777215,
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._focusColor = {
            "color":16777215,
            "fontFamily":"DejaVu Sans"
         };
         return _loc1_;
      }
      
      public function get themeList() : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:XML = describeType(this);
         var _loc3_:String = "";
         for each(_loc4_ in _loc2_.accessor)
         {
            _loc3_ = _loc4_.@name;
            if(_loc3_ == "Default_Theme")
            {
               _loc1_.unshift(_loc3_.substring(0,_loc3_.indexOf("_Theme")).split("_").join(" "));
            }
            else if(_loc3_.indexOf("_Theme") != -1)
            {
               _loc1_.push(_loc3_.substring(0,_loc3_.indexOf("_Theme")).split("_").join(" "));
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_].indexOf("RE") != -1)
            {
               if(_loc1_[_loc5_].indexOf("Default") != -1)
               {
                  _loc1_.unshift(_loc1_.splice(_loc5_,1)[0]);
               }
               else if(_loc1_[_loc5_].indexOf("Classic") != -1)
               {
                  if(_loc1_[0].indexOf("Default") != -1)
                  {
                     _loc1_.splice(1,0,_loc1_.splice(_loc5_,1)[0]);
                  }
                  else
                  {
                     _loc1_.unshift(_loc1_.splice(_loc5_,1)[0]);
                  }
               }
               else if(_loc1_[_loc5_].indexOf("Ice") != -1)
               {
                  if(_loc1_[0].indexOf("Default") != -1)
                  {
                     if(_loc1_[1].indexOf("Classic") != -1)
                     {
                        _loc1_.splice(2,0,_loc1_.splice(_loc5_,1)[0]);
                     }
                     else
                     {
                        _loc1_.splice(1,0,_loc1_.splice(_loc5_,1)[0]);
                     }
                  }
                  else if(_loc1_[0].indexOf("Classic") != -1)
                  {
                     _loc1_.splice(1,0,_loc1_.splice(_loc5_,1)[0]);
                  }
                  else
                  {
                     _loc1_.unshift(_loc1_.splice(_loc5_,1)[0]);
                  }
               }
            }
            _loc5_++;
         }
         return _loc1_;
      }
      
      public function get Autumn_Leaves_by_Ioshik_Theme() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.mainApp = {
            "backgroundColor":7958052,
            "backgroundGradientAlphas":[0,0]
         };
         _loc1_.ToolTip = {
            "cornerRadius":3,
            "paddingTop":7,
            "paddingBottom":7,
            "paddingLeft":8,
            "paddingRight":8,
            "color":5111808,
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "backgroundColor":16375693,
            "backgroundAlpha":0.93
         };
         _loc1_._REmainLoginForm = {
            "cornerRadius":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":15637537,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REmainFormText = {
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215
         };
         _loc1_._REmainScreen = {
            "backgroundAlpha":0,
            "backgroundImage":null
         };
         _loc1_._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
         _loc1_._REmainScreenTopNameText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":15,
            "color":16777215,
            "top":6
         };
         _loc1_._REmainScreenServerClockTimeField = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":21,
            "color":16777215
         };
         _loc1_._REmainScreenMainPanel = {
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":15637537,
            "backgroundAlpha":1
         };
         _loc1_._REtoggleBox = {
            "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
            "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
            "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
            "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
            "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
            "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
         };
         _loc1_._REcheckBox = {
            "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
            "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
            "upIcon":ThemeAssets._embed_checkBox_png,
            "overIcon":ThemeAssets._embed_checkBox_png,
            "downIcon":ThemeAssets._embed_checkBox_png
         };
         _loc1_._txtAreaStyle = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":16777215,
            "backgroundColor":10702388,
            "backgroundAlpha":1,
            "themeColor":5535511,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._inputArea = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":1052688,
            "backgroundColor":16773574,
            "backgroundDisabledColor":13290185,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2236962,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._RElogBox = {
            "textAlign":"left",
            "color":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16776177,
            "themeColor":5535511,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._clearLogBtn = {
            "upSkin":ThemeAssets._embed_clearLogBtn_png,
            "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
            "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearLogBtn_png
         };
         _loc1_._REchatBox = {
            "textAlign":"left",
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16776177,
            "themeColor":5535511,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "bottom":0,
            "right":0
         };
         _loc1_._REdataGrid = {
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontThickness":20,
            "headerColors":[8001560,5111808],
            "themeColor":5535511,
            "rollOverColor":15367460,
            "selectionColor":7958052,
            "alternatingItemColors":[16643808,16776175],
            "backgroundDisabledColor":10702388,
            "horizontalGridLines":true,
            "horizontalGridLineColor":15852471,
            "verticalGridLines":true,
            "verticalGridLineColor":15852471,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1
         };
         _loc1_._columnHeaderSyle = {
            "color":16375693,
            "fontSize":12,
            "fontWeight":"normal",
            "fontThickness":120
         };
         _loc1_._REwinBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "color":592654,
            "textRollOverColor":592654,
            "disabledColor":5592405,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinOkayBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":2329600,
            "color":592654,
            "textRollOverColor":1072128,
            "disabledColor":5592405,
            "fillColors":[16375693,15637537,12181931,5878091],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinCancelBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":15425889,
            "color":592654,
            "textRollOverColor":8519680,
            "disabledColor":5592405,
            "fillColors":[16375693,15637537,15117227,11946827],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REpopupWinBase = {
            "cornerRadius":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":16375693,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REpopupWinTitleText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":13,
            "color":16777215,
            "top":6
         };
         _loc1_._REnumStepUpBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepUp_png
         };
         _loc1_._REnumStepDnBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepDn_png
         };
         _loc1_._REaddBtn = {
            "width":12,
            "height":12,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addIcon_png,
            "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
         };
         _loc1_._REaddAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
         };
         _loc1_._REsubAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_subAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
         };
         _loc1_._horizontalSeparator2pxLine = {
            "height":2,
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoDarkFadedBackground = {
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoText = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontThickness":20,
            "fontWeight":"bold",
            "fontSize":13
         };
         _loc1_._newArmyTroop = {
            "color":5111808,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12
         };
         _loc1_._REtabBar = {
            "fontFamily":"DejaVu Sans",
            "fontThickness":0
         };
         _loc1_._REtabBarTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2105893,
            "themeColor":2105893,
            "backgroundColor":16375693,
            "color":5111808,
            "textRollOverColor":5111808,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[16375693,15637537,16775136,16773574],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarAccountTabs = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2237479,
            "themeColor":3290167,
            "backgroundColor":8793389,
            "color":16375693,
            "textRollOverColor":16442529,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[8001560,5111808,8793389,6166295],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarCitiesTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "horizontalGap":0,
            "cornerRadius":0,
            "borderColor":3289909,
            "backgroundColor":16375693,
            "themeColor":3289909,
            "color":5111808,
            "textRollOverColor":5111808,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[16769369,16770152,16770413,16771455],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REmailComposeView = {"backgroundColor":15637537};
         _loc1_._ComboBox = {
            "cornerRadius":0,
            "fontAlign":"center",
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "textRollOverColor":1118481,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":5535511,
            "fillColors":[16375693,15637537,16442529,15906653],
            "fillAlphas":[1,1,1,1],
            "focusAlpha":0,
            "dropdownStyleName":"comboBoxDropdown"
         };
         _loc1_._comboBoxDropdown = {
            "cornerRadius":0,
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "backgroundColor":16375693,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":5535511
         };
         _loc1_._nextBtn = {
            "upSkin":ThemeAssets._embed_RE_nextBtn_png,
            "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
         };
         _loc1_._previousBtn = {
            "upSkin":ThemeAssets._embed_RE_previousBtn_png,
            "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
         };
         _loc1_._refreshBtn = {
            "upSkin":ThemeAssets._embed_refreshBtn_png,
            "downSkin":ThemeAssets._embed_refreshBtnDown_png,
            "overSkin":ThemeAssets._embed_refreshBtnOver_png,
            "disabledSkin":ThemeAssets._embed_refreshBtn_png
         };
         _loc1_._editBtn = {
            "upSkin":ThemeAssets._embed_editButton_png,
            "downSkin":ThemeAssets._embed_editBtnDown_png,
            "overSkin":ThemeAssets._embed_editBtnOver_png,
            "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
         };
         _loc1_._clearTextBtn = {
            "upSkin":ThemeAssets._embed_clearTextBtn_png,
            "downSkin":ThemeAssets._embed_clearTextBtn_png,
            "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearTextBtn_png
         };
         _loc1_._close = {
            "upSkin":ThemeAssets._embed_winCloseBtn_png,
            "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
            "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
            "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
         };
         _loc1_._textBackground = {
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":15367460,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":3,
            "paddingBottom":3,
            "focusAlpha":0
         };
         _loc1_._chatInput = {
            "fontSize":13,
            "fontFamily":"DejaVu Sans",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16776177,
            "backgroundDisabledColor":14474459
         };
         _loc1_._textInput = {
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16773574,
            "backgroundDisabledColor":14474459
         };
         _loc1_._labelWithBackGround = {
            "textAlign":"center",
            "color":16777215,
            "backgroundAlpha":0,
            "fontSize":12,
            "borderStyle":"none",
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._PropertyName1 = {
            "color":16777215,
            "fontWeight":"bold",
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._ParamgraphText1 = {
            "color":16777215,
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._focusColor = {
            "color":16777215,
            "fontFamily":"DejaVu Sans"
         };
         return _loc1_;
      }
      
      public function get Ice_Blue_RE_Theme() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.mainApp = {
            "backgroundColor":3762577,
            "backgroundGradientAlphas":[0,0]
         };
         _loc1_.ToolTip = {
            "cornerRadius":3,
            "paddingTop":7,
            "paddingBottom":7,
            "paddingLeft":8,
            "paddingRight":8,
            "color":16777215,
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "backgroundColor":2302752,
            "backgroundAlpha":0.93
         };
         _loc1_._REmainLoginForm = {
            "cornerRadius":3,
            "borderColor":549,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":9154769,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REmainFormText = {
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215
         };
         _loc1_._REmainScreen = {
            "backgroundAlpha":1,
            "backgroundImage":ThemeAssets._embed_classicBlue_winCloseBtnOver_png,
            "backgroundSize":"100%"
         };
         _loc1_._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
         _loc1_._REmainScreenTopNameText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":15,
            "color":16777215,
            "top":6
         };
         _loc1_._REmainScreenServerClockTimeField = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":21,
            "color":16777215
         };
         _loc1_._REmainScreenMainPanel = {
            "borderColor":9,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":9154769,
            "backgroundAlpha":1
         };
         _loc1_._REtoggleBox = {
            "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
            "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
            "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
            "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
            "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
            "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
         };
         _loc1_._REcheckBox = {
            "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
            "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
            "upIcon":ThemeAssets._embed_checkBox_png,
            "overIcon":ThemeAssets._embed_checkBox_png,
            "downIcon":ThemeAssets._embed_checkBox_png
         };
         _loc1_._txtAreaStyle = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":16777215,
            "backgroundColor":3755106,
            "backgroundAlpha":1,
            "themeColor":66090,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._inputArea = {
            "textAlign":"left",
            "cornerRadius":5,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":1052688,
            "backgroundColor":16382456,
            "backgroundDisabledColor":13290185,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2236962,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._RElogBox = {
            "textAlign":"left",
            "color":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16448249,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._clearLogBtn = {
            "upSkin":ThemeAssets._embed_clearLogBtn_png,
            "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
            "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearLogBtn_png
         };
         _loc1_._REchatBox = {
            "textAlign":"left",
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16514042,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "bottom":0,
            "right":0
         };
         _loc1_._REdataGrid = {
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontThickness":20,
            "headerColors":[2178133,66090],
            "themeColor":66090,
            "rollOverColor":12439022,
            "selectionColor":8376063,
            "alternatingItemColors":[14021110,15399678],
            "backgroundDisabledColor":11123913,
            "horizontalGridLines":true,
            "horizontalGridLineColor":6456228,
            "verticalGridLines":true,
            "verticalGridLineColor":5468302,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1
         };
         _loc1_._columnHeaderSyle = {
            "color":16777215,
            "fontSize":12,
            "fontWeight":"normal",
            "fontThickness":120
         };
         _loc1_._REwinBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":2186358,
            "themeColor":2198715,
            "color":66090,
            "textRollOverColor":66090,
            "disabledColor":3239046,
            "fillColors":[12184572,5342889,13692159,2261452],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinOkayBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":2186358,
            "themeColor":2329600,
            "color":66090,
            "textRollOverColor":1072128,
            "disabledColor":3239046,
            "fillColors":[12184572,5342889,12181931,5878091],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinCancelBtn = {
            "cornerRadius":3,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":2186358,
            "themeColor":15425889,
            "color":66090,
            "textRollOverColor":8519680,
            "disabledColor":3239046,
            "fillColors":[12184572,5342889,15117227,11946827],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REpopupWinBase = {
            "cornerRadius":3,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":9154769,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REpopupWinTitleText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":13,
            "color":16777215,
            "top":6
         };
         _loc1_._REnumStepUpBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepUp_png
         };
         _loc1_._REnumStepDnBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepDn_png
         };
         _loc1_._REaddBtn = {
            "width":12,
            "height":12,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addIcon_png,
            "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
         };
         _loc1_._REaddAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
         };
         _loc1_._REsubAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_subAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
         };
         _loc1_._horizontalSeparator2pxLine = {
            "height":2,
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoLine_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoDarkFadedBackground = {
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoBackGrnd_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoText = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontThickness":20,
            "fontWeight":"bold",
            "fontSize":13
         };
         _loc1_._newArmyTroop = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12
         };
         _loc1_._REtabBar = {
            "fontFamily":"DejaVu Sans",
            "fontThickness":0
         };
         _loc1_._REtabBarTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":66090,
            "themeColor":66090,
            "backgroundColor":855604,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[2178133,66090,3230826,2178133],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarAccountTabs = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2186358,
            "themeColor":2198715,
            "backgroundColor":11262442,
            "color":66090,
            "textRollOverColor":66090,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[12184572,5342889,13692159,2261452],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarCitiesTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "horizontalGap":0,
            "cornerRadius":0,
            "borderColor":66090,
            "backgroundColor":855604,
            "themeColor":66090,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[2178133,66090,2243927,395058],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REmailComposeView = {"backgroundColor":3762065};
         _loc1_._ComboBox = {
            "cornerRadius":3,
            "fontAlign":"center",
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":66090,
            "textRollOverColor":66090,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":2186358,
            "themeColor":2198715,
            "fillColors":[12184572,5342889,13692159,2261452],
            "fillAlphas":[1,1,1,1],
            "focusAlpha":0,
            "dropdownStyleName":"comboBoxDropdown"
         };
         _loc1_._comboBoxDropdown = {
            "cornerRadius":3,
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":66090,
            "backgroundColor":16777215,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":2186358,
            "themeColor":2198715
         };
         _loc1_._nextBtn = {
            "upSkin":ThemeAssets._embed_RE_nextBtn_png,
            "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
         };
         _loc1_._previousBtn = {
            "upSkin":ThemeAssets._embed_RE_previousBtn_png,
            "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
         };
         _loc1_._refreshBtn = {
            "upSkin":ThemeAssets._embed_refreshBtn_png,
            "downSkin":ThemeAssets._embed_refreshBtnDown_png,
            "overSkin":ThemeAssets._embed_refreshBtnOver_png,
            "disabledSkin":ThemeAssets._embed_refreshBtn_png
         };
         _loc1_._editBtn = {
            "upSkin":ThemeAssets._embed_editButton_png,
            "downSkin":ThemeAssets._embed_editBtnDown_png,
            "overSkin":ThemeAssets._embed_editBtnOver_png,
            "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
         };
         _loc1_._clearTextBtn = {
            "upSkin":ThemeAssets._embed_clearTextBtn_png,
            "downSkin":ThemeAssets._embed_clearTextBtn_png,
            "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearTextBtn_png
         };
         _loc1_._close = {
            "upSkin":ThemeAssets._embed_winCloseBtn_png,
            "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
            "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
            "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
         };
         _loc1_._textBackground = {
            "cornerRadius":3,
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215,
            "borderColor":66090,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":3762065,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":3,
            "paddingBottom":3,
            "focusAlpha":0
         };
         _loc1_._chatInput = {
            "fontSize":13,
            "fontFamily":"DejaVu Sans",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._textInput = {
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._labelWithBackGround = {
            "textAlign":"center",
            "color":16777215,
            "backgroundAlpha":0,
            "fontSize":12,
            "borderStyle":"none",
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._PropertyName1 = {
            "color":16777215,
            "fontWeight":"bold",
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._ParamgraphText1 = {
            "color":16777215,
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._focusColor = {
            "color":16777215,
            "fontFamily":"DejaVu Sans"
         };
         return _loc1_;
      }
      
      public function get Default_Grey_RE_Theme() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.mainApp = {
            "backgroundColor":6513767,
            "backgroundGradientAlphas":[0,0]
         };
         _loc1_.ToolTip = {
            "cornerRadius":0,
            "paddingTop":7,
            "paddingBottom":7,
            "paddingLeft":8,
            "paddingRight":8,
            "color":16777215,
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "backgroundColor":2302752,
            "backgroundAlpha":0.93
         };
         _loc1_._REmainLoginForm = {
            "cornerRadius":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":10066588,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REmainFormText = {
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215
         };
         _loc1_._REmainScreen = {
            "backgroundAlpha":0,
            "backgroundImage":null
         };
         _loc1_._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_rePopUpWinTitleBg_png};
         _loc1_._REmainScreenTopNameText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":15,
            "color":16777215,
            "top":4
         };
         _loc1_._REmainScreenServerClockTimeField = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":21,
            "color":16777215
         };
         _loc1_._REmainScreenMainPanel = {
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":10066588,
            "backgroundAlpha":1
         };
         _loc1_._REtoggleBox = {
            "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
            "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
            "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
            "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
            "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
            "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
            "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
         };
         _loc1_._REcheckBox = {
            "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
            "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
            "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
            "upIcon":ThemeAssets._embed_checkBox_png,
            "overIcon":ThemeAssets._embed_checkBox_png,
            "downIcon":ThemeAssets._embed_checkBox_png
         };
         _loc1_._txtAreaStyle = {
            "textAlign":"left",
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":16777215,
            "backgroundColor":5197905,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._inputArea = {
            "textAlign":"left",
            "cornerRadius":5,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "color":1052688,
            "backgroundColor":16382456,
            "backgroundDisabledColor":13290185,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "borderColor":2236962,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._RElogBox = {
            "textAlign":"left",
            "color":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16448249,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "focusAlpha":0
         };
         _loc1_._clearLogBtn = {
            "upSkin":ThemeAssets._embed_clearLogBtn_png,
            "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
            "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearLogBtn_png
         };
         _loc1_._REchatBox = {
            "textAlign":"left",
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "backgroundColor":16514042,
            "themeColor":2105893,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "bottom":0,
            "right":0
         };
         _loc1_._REdataGrid = {
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontThickness":20,
            "headerColors":[5790043,4868683],
            "themeColor":2105893,
            "rollOverColor":11908792,
            "selectionColor":8376063,
            "alternatingItemColors":[15592942,16185079],
            "backgroundDisabledColor":13421769,
            "horizontalGridLines":true,
            "horizontalGridLineColor":11382189,
            "verticalGridLines":true,
            "verticalGridLineColor":10329501,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1
         };
         _loc1_._columnHeaderSyle = {
            "color":16777215,
            "fontSize":12,
            "fontWeight":"normal",
            "fontThickness":120
         };
         _loc1_._REwinBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "color":592654,
            "textRollOverColor":592654,
            "disabledColor":5592405,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinOkayBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":2329600,
            "color":592654,
            "textRollOverColor":1270016,
            "disabledColor":5592405,
            "fillColors":[14672356,14672356,12181931,12181931],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REwinCancelBtn = {
            "cornerRadius":0,
            "fontThickness":0,
            "minWidth":40,
            "height":21,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":15425889,
            "color":592654,
            "textRollOverColor":10616832,
            "disabledColor":5592405,
            "fillColors":[14672356,14672356,15117227,15117227],
            "fillAlphas":[1,1,1,1],
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12,
            "horizontalGap":0,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":1,
            "paddingBottom":0
         };
         _loc1_._REpopupWinBase = {
            "cornerRadius":0,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":10066588,
            "backgroundAlpha":1,
            "dropShadowEnabled":true,
            "dropShadowColor":395017
         };
         _loc1_._REpopupWinTitleText = {
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "fontSize":13,
            "color":16777215,
            "top":4
         };
         _loc1_._REnumStepUpBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepUp_png
         };
         _loc1_._REnumStepDnBtn = {
            "width":19,
            "height":11,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_numStepDn_png
         };
         _loc1_._REaddBtn = {
            "width":12,
            "height":12,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addIcon_png,
            "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
         };
         _loc1_._REaddAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_addAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
         };
         _loc1_._REsubAttributeBtn = {
            "width":16,
            "height":16,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":4211269,
            "themeColor":489687,
            "fillColors":[14672356,14672356,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "cornerRadius":0,
            "horizontalGap":0,
            "paddingLeft":1,
            "paddingRight":1,
            "paddingTop":0,
            "paddingBottom":0,
            "icon":ThemeAssets._embed_subAttribIcon_png,
            "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
         };
         _loc1_._horizontalSeparator2pxLine = {
            "height":2,
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoDarkFadedBackground = {
            "horizontalGap":0,
            "verticalGap":0,
            "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
            "backgroundSize":"100%",
            "backgroundAlpha":1
         };
         _loc1_._cityTopInfoText = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontThickness":20,
            "fontWeight":"bold",
            "fontSize":13
         };
         _loc1_._newArmyTroop = {
            "color":16777215,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"normal",
            "fontSize":12
         };
         _loc1_._REtabBar = {
            "fontFamily":"DejaVu Sans",
            "fontThickness":0
         };
         _loc1_._REtabBarTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2105893,
            "themeColor":2105893,
            "backgroundColor":2105893,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[3289650,2105893,4342338,3289650],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarAccountTabs = {
            "paddingLeft":3,
            "paddingRight":3,
            "cornerRadius":0,
            "borderColor":2237479,
            "themeColor":3290167,
            "backgroundColor":14738149,
            "color":461068,
            "textRollOverColor":461068,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[13685461,9474709,14540755,10328739],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REtabBarCitiesTab = {
            "paddingLeft":3,
            "paddingRight":3,
            "horizontalGap":0,
            "cornerRadius":0,
            "borderColor":3289909,
            "themeColor":3289909,
            "backgroundColor":3289909,
            "color":16777215,
            "textRollOverColor":16777215,
            "fontFamily":"DejaVu Sans",
            "fontSize":12,
            "fontWeight":"normal",
            "fillColors":[10526880,5395285,12434877,7105903],
            "fillAlphas":[1,1,1,1]
         };
         _loc1_._REmailComposeView = {"backgroundColor":6513767};
         _loc1_._ComboBox = {
            "cornerRadius":0,
            "fontAlign":"center",
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "textRollOverColor":1118481,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":489687,
            "fillColors":[14803425,14803425,15069691,15069691],
            "fillAlphas":[1,1,1,1],
            "focusAlpha":0,
            "dropdownStyleName":"comboBoxDropdown"
         };
         _loc1_._comboBoxDropdown = {
            "cornerRadius":0,
            "fontSize":11,
            "fontWeight":"normal",
            "fontFamily":"DejaVu Sans",
            "color":1118481,
            "backgroundColor":16777215,
            "borderThickness":1,
            "borderStyle":"solid",
            "borderColor":7171437,
            "themeColor":489687
         };
         _loc1_._nextBtn = {
            "upSkin":ThemeAssets._embed_RE_nextBtn_png,
            "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
         };
         _loc1_._previousBtn = {
            "upSkin":ThemeAssets._embed_RE_previousBtn_png,
            "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
            "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
            "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
         };
         _loc1_._refreshBtn = {
            "upSkin":ThemeAssets._embed_refreshBtn_png,
            "downSkin":ThemeAssets._embed_refreshBtnDown_png,
            "overSkin":ThemeAssets._embed_refreshBtnOver_png,
            "disabledSkin":ThemeAssets._embed_refreshBtn_png
         };
         _loc1_._editBtn = {
            "upSkin":ThemeAssets._embed_editButton_png,
            "downSkin":ThemeAssets._embed_editBtnDown_png,
            "overSkin":ThemeAssets._embed_editBtnOver_png,
            "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
         };
         _loc1_._clearTextBtn = {
            "upSkin":ThemeAssets._embed_clearTextBtn_png,
            "downSkin":ThemeAssets._embed_clearTextBtn_png,
            "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
            "disabledSkin":ThemeAssets._embed_clearTextBtn_png
         };
         _loc1_._close = {
            "upSkin":ThemeAssets._embed_winCloseBtn_png,
            "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
            "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
            "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
         };
         _loc1_._textBackground = {
            "cornerRadius":0,
            "fontFamily":"DejaVu Sans",
            "fontSize":13,
            "color":16777215,
            "borderColor":2105893,
            "borderStyle":"solid",
            "borderThickness":1,
            "backgroundColor":5197905,
            "backgroundAlpha":1,
            "themeColor":2105893,
            "paddingLeft":5,
            "paddingRight":5,
            "paddingTop":3,
            "paddingBottom":3,
            "focusAlpha":0
         };
         _loc1_._chatInput = {
            "fontSize":13,
            "fontFamily":"DejaVu Sans",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._textInput = {
            "fontSize":11,
            "fontFamily":"DejaVu Sans",
            "fontWeight":"bold",
            "focusAlpha":0,
            "color":1052687,
            "cornerRadius":0,
            "paddingLeft":2,
            "paddingTop":0,
            "paddingRight":2,
            "paddingBottom":0,
            "borderThickness":1,
            "borderStyle":"inset",
            "borderColor":2105893,
            "backgroundColor":16448249,
            "backgroundDisabledColor":14474459
         };
         _loc1_._labelWithBackGround = {
            "textAlign":"center",
            "color":16777215,
            "backgroundAlpha":0,
            "fontSize":12,
            "borderStyle":"none",
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._PropertyName1 = {
            "color":16777215,
            "fontWeight":"bold",
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._ParamgraphText1 = {
            "color":16777215,
            "fontSize":12,
            "fontFamily":"DejaVu Sans"
         };
         _loc1_._focusColor = {
            "color":16777215,
            "fontFamily":"DejaVu Sans"
         };
         return _loc1_;
      }
   }
}

