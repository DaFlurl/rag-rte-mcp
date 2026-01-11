// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.controls.themes.Themes

package autoevony.gui.controls.themes
{
    import flash.utils.describeType;

    public class Themes 
    {


        public function get Classic_Blue_RE_Theme():Object
        {
            var _local_1:Object = new Object();
            _local_1.mainApp = {
                "backgroundColor":1719386,
                "backgroundGradientAlphas":[0, 0]
            };
            _local_1.ToolTip = {
                "cornerRadius":3,
                "paddingTop":7,
                "paddingBottom":7,
                "paddingLeft":8,
                "paddingRight":8,
                "color":0xFFFFFF,
                "fontSize":11,
                "fontFamily":"DejaVu Sans",
                "backgroundColor":2302752,
                "backgroundAlpha":0.93
            };
            _local_1._REmainLoginForm = {
                "cornerRadius":3,
                "borderColor":549,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":3429492,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REmainFormText = {
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF
            };
            _local_1._REmainScreen = {
                "backgroundAlpha":1,
                "backgroundImage":ThemeAssets._embed_classicBlue_winCloseBtnOver_png,
                "backgroundSize":"100%"
            };
            _local_1._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
            _local_1._REmainScreenTopNameText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":15,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REmainScreenServerClockTimeField = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":21,
                "color":0xFFFFFF
            };
            _local_1._REmainScreenMainPanel = {
                "borderColor":9,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":2178133,
                "backgroundAlpha":1
            };
            _local_1._REtoggleBox = {
                "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
                "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
                "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
                "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
                "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
                "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
            };
            _local_1._REcheckBox = {
                "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
                "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
                "upIcon":ThemeAssets._embed_checkBox_png,
                "overIcon":ThemeAssets._embed_checkBox_png,
                "downIcon":ThemeAssets._embed_checkBox_png
            };
            _local_1._txtAreaStyle = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0xFFFFFF,
                "backgroundColor":3755106,
                "backgroundAlpha":1,
                "themeColor":66090,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._inputArea = {
                "textAlign":"left",
                "cornerRadius":5,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0x101010,
                "backgroundColor":16382456,
                "backgroundDisabledColor":13290185,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":0x222222,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._RElogBox = {
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
            _local_1._clearLogBtn = {
                "upSkin":ThemeAssets._embed_clearLogBtn_png,
                "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
                "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearLogBtn_png
            };
            _local_1._REchatBox = {
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
            _local_1._REdataGrid = {
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontThickness":20,
                "headerColors":[2178133, 66090],
                "themeColor":66090,
                "rollOverColor":12439022,
                "selectionColor":8376063,
                "alternatingItemColors":[14021110, 15399678],
                "backgroundDisabledColor":11123913,
                "horizontalGridLines":true,
                "horizontalGridLineColor":6456228,
                "verticalGridLines":true,
                "verticalGridLineColor":5468302,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1
            };
            _local_1._columnHeaderSyle = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontWeight":"normal",
                "fontThickness":120
            };
            _local_1._REwinBtn = {
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
                "fillColors":[16772173, 16745293, 16772689, 16745293],
                "fillAlphas":[0.9, 0.85, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinOkayBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":66090,
                "themeColor":0x238C00,
                "color":66090,
                "textRollOverColor":0x105C00,
                "disabledColor":6185371,
                "fillColors":[16772173, 16745293, 12181931, 5878091],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinCancelBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":66090,
                "themeColor":15425889,
                "color":66090,
                "textRollOverColor":0x820000,
                "disabledColor":6185371,
                "fillColors":[16772173, 16745293, 15117227, 11946827],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REpopupWinBase = {
                "cornerRadius":3,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":4552359,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REpopupWinTitleText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":13,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REnumStepUpBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepUp_png
            };
            _local_1._REnumStepDnBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepDn_png
            };
            _local_1._REaddBtn = {
                "width":12,
                "height":12,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addIcon_png,
                "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
            };
            _local_1._REaddAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
            };
            _local_1._REsubAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_subAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
            };
            _local_1._horizontalSeparator2pxLine = {
                "height":2,
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoLine_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoDarkFadedBackground = {
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoBackGrnd_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoText = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontThickness":20,
                "fontWeight":"bold",
                "fontSize":13
            };
            _local_1._newArmyTroop = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12
            };
            _local_1._REtabBar = {
                "fontFamily":"DejaVu Sans",
                "fontThickness":0
            };
            _local_1._REtabBarTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "cornerRadius":0,
                "borderColor":66090,
                "themeColor":66090,
                "backgroundColor":855604,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[2178133, 66090, 3230826, 2178133],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarAccountTabs = {
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
                "fillColors":[16772173, 16745293, 16772689, 16745293],
                "fillAlphas":[0.9, 0.85, 1, 1]
            };
            _local_1._REtabBarCitiesTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "horizontalGap":0,
                "cornerRadius":3,
                "borderColor":66090,
                "themeColor":66090,
                "backgroundColor":855604,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[2178133, 66090, 2243927, 395058],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REmailComposeView = {"backgroundColor":3755106};
            _local_1._ComboBox = {
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
                "fillColors":[16772173, 16745293, 16772689, 16745293],
                "fillAlphas":[1, 1, 1, 1],
                "focusAlpha":0,
                "dropdownStyleName":"comboBoxDropdown"
            };
            _local_1._comboBoxDropdown = {
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
            _local_1._nextBtn = {
                "upSkin":ThemeAssets._embed_RE_nextBtn_png,
                "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
            };
            _local_1._previousBtn = {
                "upSkin":ThemeAssets._embed_RE_previousBtn_png,
                "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
            };
            _local_1._refreshBtn = {
                "upSkin":ThemeAssets._embed_refreshBtn_png,
                "downSkin":ThemeAssets._embed_refreshBtnDown_png,
                "overSkin":ThemeAssets._embed_refreshBtnOver_png,
                "disabledSkin":ThemeAssets._embed_refreshBtn_png
            };
            _local_1._editBtn = {
                "upSkin":ThemeAssets._embed_editButton_png,
                "downSkin":ThemeAssets._embed_editBtnDown_png,
                "overSkin":ThemeAssets._embed_editBtnOver_png,
                "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
            };
            _local_1._clearTextBtn = {
                "upSkin":ThemeAssets._embed_clearTextBtn_png,
                "downSkin":ThemeAssets._embed_clearTextBtn_png,
                "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearTextBtn_png
            };
            _local_1._close = {
                "upSkin":ThemeAssets._embed_winCloseBtn_png,
                "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
                "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
                "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
            };
            _local_1._textBackground = {
                "cornerRadius":3,
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF,
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
            _local_1._chatInput = {
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
            _local_1._textInput = {
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
            _local_1._labelWithBackGround = {
                "textAlign":"center",
                "color":0xFFFFFF,
                "backgroundAlpha":0,
                "fontSize":12,
                "borderStyle":"none",
                "fontFamily":"DejaVu Sans"
            };
            _local_1._PropertyName1 = {
                "color":0xFFFFFF,
                "fontWeight":"bold",
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._ParamgraphText1 = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._focusColor = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans"
            };
            return (_local_1);
        }

        public function get Burgundy_by_Ioshik_Theme():Object
        {
            var _local_1:Object = new Object();
            _local_1.mainApp = {
                "backgroundColor":14384999,
                "backgroundGradientAlphas":[0, 0]
            };
            _local_1.ToolTip = {
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
            _local_1._REmainLoginForm = {
                "cornerRadius":5,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":10713971,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REmainFormText = {
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF
            };
            _local_1._REmainScreen = {
                "backgroundAlpha":0,
                "backgroundImage":null
            };
            _local_1._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_rePopUpWinTitleBg_png};
            _local_1._REmainScreenTopNameText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":15,
                "color":0xFFFFFF,
                "top":4
            };
            _local_1._REmainScreenServerClockTimeField = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":21,
                "color":0xFFFFFF
            };
            _local_1._REmainScreenMainPanel = {
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":10713971,
                "backgroundAlpha":1
            };
            _local_1._REtoggleBox = {
                "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
                "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
                "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
                "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
                "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
                "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
            };
            _local_1._REcheckBox = {
                "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
                "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
                "upIcon":ThemeAssets._embed_checkBox_png,
                "overIcon":ThemeAssets._embed_checkBox_png,
                "downIcon":ThemeAssets._embed_checkBox_png
            };
            _local_1._txtAreaStyle = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0xFFFFFF,
                "backgroundColor":4139307,
                "backgroundAlpha":1,
                "themeColor":4139307,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._inputArea = {
                "textAlign":"left",
                "cornerRadius":5,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0x101010,
                "backgroundColor":16382456,
                "backgroundDisabledColor":10790686,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":0x222222,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._RElogBox = {
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
            _local_1._clearLogBtn = {
                "upSkin":ThemeAssets._embed_clearLogBtn_png,
                "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
                "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearLogBtn_png
            };
            _local_1._REchatBox = {
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
            _local_1._REdataGrid = {
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontThickness":20,
                "headerColors":[14797234, 10713971],
                "themeColor":4139307,
                "rollOverColor":14384999,
                "selectionColor":10713971,
                "alternatingItemColors":[15325127, 15655381],
                "backgroundDisabledColor":7958052,
                "horizontalGridLines":true,
                "horizontalGridLineColor":14797234,
                "verticalGridLines":true,
                "verticalGridLineColor":14797234,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1
            };
            _local_1._columnHeaderSyle = {
                "color":4139307,
                "fontSize":12,
                "fontWeight":"normal",
                "fontThickness":120
            };
            _local_1._REwinBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":0x621B00,
                "color":592654,
                "textRollOverColor":592654,
                "disabledColor":0x555555,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinOkayBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":0x238C00,
                "color":592654,
                "textRollOverColor":0x105C00,
                "disabledColor":0x555555,
                "fillColors":[14797234, 10713971, 12181931, 5878091],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinCancelBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":15425889,
                "color":592654,
                "textRollOverColor":0x820000,
                "disabledColor":0x555555,
                "fillColors":[14797234, 10713971, 15117227, 11946827],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REpopupWinBase = {
                "cornerRadius":3,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":14797234,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REpopupWinTitleText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":13,
                "color":0xFFFFFF,
                "top":4
            };
            _local_1._REnumStepUpBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":4139307,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepUp_png
            };
            _local_1._REnumStepDnBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":4139307,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepDn_png
            };
            _local_1._REaddBtn = {
                "width":12,
                "height":12,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":4139307,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addIcon_png,
                "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
            };
            _local_1._REaddAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":4139307,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
            };
            _local_1._REsubAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":4139307,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_subAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
            };
            _local_1._horizontalSeparator2pxLine = {
                "height":2,
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoDarkFadedBackground = {
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoText = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontThickness":20,
                "fontWeight":"bold",
                "fontSize":13
            };
            _local_1._newArmyTroop = {
                "color":4139307,
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12
            };
            _local_1._REtabBar = {
                "fontFamily":"DejaVu Sans",
                "fontThickness":0
            };
            _local_1._REtabBarTab = {
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
                "fillColors":[14797234, 10713971, 14797234, 10713971],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarAccountTabs = {
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
                "fillColors":[14797234, 12888997, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarCitiesTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "horizontalGap":0,
                "cornerRadius":0,
                "borderColor":3289909,
                "backgroundColor":14797234,
                "themeColor":4139307,
                "color":0x111111,
                "textRollOverColor":66090,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[14797234, 10713971, 15117227, 15117227],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REmailComposeView = {"backgroundColor":10713971};
            _local_1._ComboBox = {
                "cornerRadius":3,
                "fontAlign":"center",
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "textRollOverColor":0x111111,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":15655381,
                "fillColors":[14797234, 10713971, 15127232, 14797234],
                "fillAlphas":[1, 1, 1, 1],
                "focusAlpha":0,
                "dropdownStyleName":"comboBoxDropdown"
            };
            _local_1._comboBoxDropdown = {
                "cornerRadius":3,
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "backgroundColor":14797234,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":14384999
            };
            _local_1._nextBtn = {
                "upSkin":ThemeAssets._embed_RE_nextBtn_png,
                "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
            };
            _local_1._previousBtn = {
                "upSkin":ThemeAssets._embed_RE_previousBtn_png,
                "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
            };
            _local_1._refreshBtn = {
                "upSkin":ThemeAssets._embed_refreshBtn_png,
                "downSkin":ThemeAssets._embed_refreshBtnDown_png,
                "overSkin":ThemeAssets._embed_refreshBtnOver_png,
                "disabledSkin":ThemeAssets._embed_refreshBtn_png
            };
            _local_1._editBtn = {
                "upSkin":ThemeAssets._embed_editButton_png,
                "downSkin":ThemeAssets._embed_editBtnDown_png,
                "overSkin":ThemeAssets._embed_editBtnOver_png,
                "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
            };
            _local_1._clearTextBtn = {
                "upSkin":ThemeAssets._embed_clearTextBtn_png,
                "downSkin":ThemeAssets._embed_clearTextBtn_png,
                "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearTextBtn_png
            };
            _local_1._close = {
                "upSkin":ThemeAssets._embed_winCloseBtn_png,
                "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
                "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
                "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
            };
            _local_1._textBackground = {
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
            _local_1._chatInput = {
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
            _local_1._textInput = {
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
            _local_1._labelWithBackGround = {
                "textAlign":"center",
                "color":0xFFFFFF,
                "backgroundAlpha":0,
                "fontSize":12,
                "borderStyle":"none",
                "fontFamily":"DejaVu Sans"
            };
            _local_1._PropertyName1 = {
                "color":0xFFFFFF,
                "fontWeight":"bold",
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._ParamgraphText1 = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._focusColor = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans"
            };
            return (_local_1);
        }

        public function get themeList():Array
        {
            var _local_4:*;
            var _local_5:int;
            var _local_1:Array = new Array();
            var _local_2:XML = describeType(this);
            var _local_3:* = "";
            for each (_local_4 in _local_2.accessor)
            {
                _local_3 = _local_4.@name;
                if (_local_3 == "Default_Theme")
                {
                    _local_1.unshift(_local_3.substring(0, _local_3.indexOf("_Theme")).split("_").join(" "));
                }
                else
                {
                    if (_local_3.indexOf("_Theme") != -1)
                    {
                        _local_1.push(_local_3.substring(0, _local_3.indexOf("_Theme")).split("_").join(" "));
                    };
                };
            };
            _local_5 = 0;
            while (_local_5 < _local_1.length)
            {
                if (_local_1[_local_5].indexOf("RE") != -1)
                {
                    if (_local_1[_local_5].indexOf("Default") != -1)
                    {
                        _local_1.unshift(_local_1.splice(_local_5, 1)[0]);
                    }
                    else
                    {
                        if (_local_1[_local_5].indexOf("Classic") != -1)
                        {
                            if (_local_1[0].indexOf("Default") != -1)
                            {
                                _local_1.splice(1, 0, _local_1.splice(_local_5, 1)[0]);
                            }
                            else
                            {
                                _local_1.unshift(_local_1.splice(_local_5, 1)[0]);
                            };
                        }
                        else
                        {
                            if (_local_1[_local_5].indexOf("Ice") != -1)
                            {
                                if (_local_1[0].indexOf("Default") != -1)
                                {
                                    if (_local_1[1].indexOf("Classic") != -1)
                                    {
                                        _local_1.splice(2, 0, _local_1.splice(_local_5, 1)[0]);
                                    }
                                    else
                                    {
                                        _local_1.splice(1, 0, _local_1.splice(_local_5, 1)[0]);
                                    };
                                }
                                else
                                {
                                    if (_local_1[0].indexOf("Classic") != -1)
                                    {
                                        _local_1.splice(1, 0, _local_1.splice(_local_5, 1)[0]);
                                    }
                                    else
                                    {
                                        _local_1.unshift(_local_1.splice(_local_5, 1)[0]);
                                    };
                                };
                            };
                        };
                    };
                };
                _local_5++;
            };
            return (_local_1);
        }

        public function get Autumn_Leaves_by_Ioshik_Theme():Object
        {
            var _local_1:Object = new Object();
            _local_1.mainApp = {
                "backgroundColor":7958052,
                "backgroundGradientAlphas":[0, 0]
            };
            _local_1.ToolTip = {
                "cornerRadius":3,
                "paddingTop":7,
                "paddingBottom":7,
                "paddingLeft":8,
                "paddingRight":8,
                "color":0x4E0000,
                "fontSize":11,
                "fontFamily":"DejaVu Sans",
                "backgroundColor":16375693,
                "backgroundAlpha":0.93
            };
            _local_1._REmainLoginForm = {
                "cornerRadius":0,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":15637537,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REmainFormText = {
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF
            };
            _local_1._REmainScreen = {
                "backgroundAlpha":0,
                "backgroundImage":null
            };
            _local_1._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
            _local_1._REmainScreenTopNameText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":15,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REmainScreenServerClockTimeField = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":21,
                "color":0xFFFFFF
            };
            _local_1._REmainScreenMainPanel = {
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":15637537,
                "backgroundAlpha":1
            };
            _local_1._REtoggleBox = {
                "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
                "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
                "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
                "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
                "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
                "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
            };
            _local_1._REcheckBox = {
                "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
                "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
                "upIcon":ThemeAssets._embed_checkBox_png,
                "overIcon":ThemeAssets._embed_checkBox_png,
                "downIcon":ThemeAssets._embed_checkBox_png
            };
            _local_1._txtAreaStyle = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0xFFFFFF,
                "backgroundColor":10702388,
                "backgroundAlpha":1,
                "themeColor":5535511,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._inputArea = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0x101010,
                "backgroundColor":16773574,
                "backgroundDisabledColor":13290185,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":0x222222,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._RElogBox = {
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
            _local_1._clearLogBtn = {
                "upSkin":ThemeAssets._embed_clearLogBtn_png,
                "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
                "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearLogBtn_png
            };
            _local_1._REchatBox = {
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
            _local_1._REdataGrid = {
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontThickness":20,
                "headerColors":[8001560, 0x4E0000],
                "themeColor":5535511,
                "rollOverColor":15367460,
                "selectionColor":7958052,
                "alternatingItemColors":[16643808, 16776175],
                "backgroundDisabledColor":10702388,
                "horizontalGridLines":true,
                "horizontalGridLineColor":15852471,
                "verticalGridLines":true,
                "verticalGridLineColor":15852471,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1
            };
            _local_1._columnHeaderSyle = {
                "color":16375693,
                "fontSize":12,
                "fontWeight":"normal",
                "fontThickness":120
            };
            _local_1._REwinBtn = {
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
                "disabledColor":0x555555,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinOkayBtn = {
                "cornerRadius":0,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":0x238C00,
                "color":592654,
                "textRollOverColor":0x105C00,
                "disabledColor":0x555555,
                "fillColors":[16375693, 15637537, 12181931, 5878091],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinCancelBtn = {
                "cornerRadius":0,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":15425889,
                "color":592654,
                "textRollOverColor":0x820000,
                "disabledColor":0x555555,
                "fillColors":[16375693, 15637537, 15117227, 11946827],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REpopupWinBase = {
                "cornerRadius":0,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":16375693,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REpopupWinTitleText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":13,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REnumStepUpBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepUp_png
            };
            _local_1._REnumStepDnBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepDn_png
            };
            _local_1._REaddBtn = {
                "width":12,
                "height":12,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addIcon_png,
                "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
            };
            _local_1._REaddAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
            };
            _local_1._REsubAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_subAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
            };
            _local_1._horizontalSeparator2pxLine = {
                "height":2,
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoDarkFadedBackground = {
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoText = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontThickness":20,
                "fontWeight":"bold",
                "fontSize":13
            };
            _local_1._newArmyTroop = {
                "color":0x4E0000,
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12
            };
            _local_1._REtabBar = {
                "fontFamily":"DejaVu Sans",
                "fontThickness":0
            };
            _local_1._REtabBarTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "cornerRadius":0,
                "borderColor":2105893,
                "themeColor":2105893,
                "backgroundColor":16375693,
                "color":0x4E0000,
                "textRollOverColor":0x4E0000,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[16375693, 15637537, 16775136, 16773574],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarAccountTabs = {
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
                "fillColors":[8001560, 0x4E0000, 8793389, 6166295],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarCitiesTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "horizontalGap":0,
                "cornerRadius":0,
                "borderColor":3289909,
                "backgroundColor":16375693,
                "themeColor":3289909,
                "color":0x4E0000,
                "textRollOverColor":0x4E0000,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[16769369, 16770152, 16770413, 16771455],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REmailComposeView = {"backgroundColor":15637537};
            _local_1._ComboBox = {
                "cornerRadius":0,
                "fontAlign":"center",
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "textRollOverColor":0x111111,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":5535511,
                "fillColors":[16375693, 15637537, 16442529, 15906653],
                "fillAlphas":[1, 1, 1, 1],
                "focusAlpha":0,
                "dropdownStyleName":"comboBoxDropdown"
            };
            _local_1._comboBoxDropdown = {
                "cornerRadius":0,
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "backgroundColor":16375693,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":5535511
            };
            _local_1._nextBtn = {
                "upSkin":ThemeAssets._embed_RE_nextBtn_png,
                "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
            };
            _local_1._previousBtn = {
                "upSkin":ThemeAssets._embed_RE_previousBtn_png,
                "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
            };
            _local_1._refreshBtn = {
                "upSkin":ThemeAssets._embed_refreshBtn_png,
                "downSkin":ThemeAssets._embed_refreshBtnDown_png,
                "overSkin":ThemeAssets._embed_refreshBtnOver_png,
                "disabledSkin":ThemeAssets._embed_refreshBtn_png
            };
            _local_1._editBtn = {
                "upSkin":ThemeAssets._embed_editButton_png,
                "downSkin":ThemeAssets._embed_editBtnDown_png,
                "overSkin":ThemeAssets._embed_editBtnOver_png,
                "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
            };
            _local_1._clearTextBtn = {
                "upSkin":ThemeAssets._embed_clearTextBtn_png,
                "downSkin":ThemeAssets._embed_clearTextBtn_png,
                "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearTextBtn_png
            };
            _local_1._close = {
                "upSkin":ThemeAssets._embed_winCloseBtn_png,
                "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
                "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
                "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
            };
            _local_1._textBackground = {
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
            _local_1._chatInput = {
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
            _local_1._textInput = {
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
            _local_1._labelWithBackGround = {
                "textAlign":"center",
                "color":0xFFFFFF,
                "backgroundAlpha":0,
                "fontSize":12,
                "borderStyle":"none",
                "fontFamily":"DejaVu Sans"
            };
            _local_1._PropertyName1 = {
                "color":0xFFFFFF,
                "fontWeight":"bold",
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._ParamgraphText1 = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._focusColor = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans"
            };
            return (_local_1);
        }

        public function get Ice_Blue_RE_Theme():Object
        {
            var _local_1:Object = new Object();
            _local_1.mainApp = {
                "backgroundColor":3762577,
                "backgroundGradientAlphas":[0, 0]
            };
            _local_1.ToolTip = {
                "cornerRadius":3,
                "paddingTop":7,
                "paddingBottom":7,
                "paddingLeft":8,
                "paddingRight":8,
                "color":0xFFFFFF,
                "fontSize":11,
                "fontFamily":"DejaVu Sans",
                "backgroundColor":2302752,
                "backgroundAlpha":0.93
            };
            _local_1._REmainLoginForm = {
                "cornerRadius":3,
                "borderColor":549,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":9154769,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REmainFormText = {
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF
            };
            _local_1._REmainScreen = {
                "backgroundAlpha":1,
                "backgroundImage":ThemeAssets._embed_classicBlue_winCloseBtnOver_png,
                "backgroundSize":"100%"
            };
            _local_1._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_classicBlue_rePopUpWinTitleBg_png};
            _local_1._REmainScreenTopNameText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":15,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REmainScreenServerClockTimeField = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":21,
                "color":0xFFFFFF
            };
            _local_1._REmainScreenMainPanel = {
                "borderColor":9,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":9154769,
                "backgroundAlpha":1
            };
            _local_1._REtoggleBox = {
                "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
                "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
                "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
                "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
                "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
                "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
            };
            _local_1._REcheckBox = {
                "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
                "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
                "upIcon":ThemeAssets._embed_checkBox_png,
                "overIcon":ThemeAssets._embed_checkBox_png,
                "downIcon":ThemeAssets._embed_checkBox_png
            };
            _local_1._txtAreaStyle = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0xFFFFFF,
                "backgroundColor":3755106,
                "backgroundAlpha":1,
                "themeColor":66090,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._inputArea = {
                "textAlign":"left",
                "cornerRadius":5,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0x101010,
                "backgroundColor":16382456,
                "backgroundDisabledColor":13290185,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":0x222222,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._RElogBox = {
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
            _local_1._clearLogBtn = {
                "upSkin":ThemeAssets._embed_clearLogBtn_png,
                "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
                "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearLogBtn_png
            };
            _local_1._REchatBox = {
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
            _local_1._REdataGrid = {
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontThickness":20,
                "headerColors":[2178133, 66090],
                "themeColor":66090,
                "rollOverColor":12439022,
                "selectionColor":8376063,
                "alternatingItemColors":[14021110, 15399678],
                "backgroundDisabledColor":11123913,
                "horizontalGridLines":true,
                "horizontalGridLineColor":6456228,
                "verticalGridLines":true,
                "verticalGridLineColor":5468302,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1
            };
            _local_1._columnHeaderSyle = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontWeight":"normal",
                "fontThickness":120
            };
            _local_1._REwinBtn = {
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
                "fillColors":[12184572, 5342889, 13692159, 2261452],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinOkayBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":2186358,
                "themeColor":0x238C00,
                "color":66090,
                "textRollOverColor":0x105C00,
                "disabledColor":3239046,
                "fillColors":[12184572, 5342889, 12181931, 5878091],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinCancelBtn = {
                "cornerRadius":3,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":2186358,
                "themeColor":15425889,
                "color":66090,
                "textRollOverColor":0x820000,
                "disabledColor":3239046,
                "fillColors":[12184572, 5342889, 15117227, 11946827],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REpopupWinBase = {
                "cornerRadius":3,
                "borderColor":66090,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":9154769,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REpopupWinTitleText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":13,
                "color":0xFFFFFF,
                "top":6
            };
            _local_1._REnumStepUpBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepUp_png
            };
            _local_1._REnumStepDnBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepDn_png
            };
            _local_1._REaddBtn = {
                "width":12,
                "height":12,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addIcon_png,
                "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
            };
            _local_1._REaddAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
            };
            _local_1._REsubAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_subAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
            };
            _local_1._horizontalSeparator2pxLine = {
                "height":2,
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoLine_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoDarkFadedBackground = {
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_classicBlue_cityInfoBackGrnd_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoText = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontThickness":20,
                "fontWeight":"bold",
                "fontSize":13
            };
            _local_1._newArmyTroop = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12
            };
            _local_1._REtabBar = {
                "fontFamily":"DejaVu Sans",
                "fontThickness":0
            };
            _local_1._REtabBarTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "cornerRadius":0,
                "borderColor":66090,
                "themeColor":66090,
                "backgroundColor":855604,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[2178133, 66090, 3230826, 2178133],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarAccountTabs = {
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
                "fillColors":[12184572, 5342889, 13692159, 2261452],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarCitiesTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "horizontalGap":0,
                "cornerRadius":0,
                "borderColor":66090,
                "backgroundColor":855604,
                "themeColor":66090,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[2178133, 66090, 2243927, 395058],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REmailComposeView = {"backgroundColor":3762065};
            _local_1._ComboBox = {
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
                "fillColors":[12184572, 5342889, 13692159, 2261452],
                "fillAlphas":[1, 1, 1, 1],
                "focusAlpha":0,
                "dropdownStyleName":"comboBoxDropdown"
            };
            _local_1._comboBoxDropdown = {
                "cornerRadius":3,
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":66090,
                "backgroundColor":0xFFFFFF,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":2186358,
                "themeColor":2198715
            };
            _local_1._nextBtn = {
                "upSkin":ThemeAssets._embed_RE_nextBtn_png,
                "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
            };
            _local_1._previousBtn = {
                "upSkin":ThemeAssets._embed_RE_previousBtn_png,
                "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
            };
            _local_1._refreshBtn = {
                "upSkin":ThemeAssets._embed_refreshBtn_png,
                "downSkin":ThemeAssets._embed_refreshBtnDown_png,
                "overSkin":ThemeAssets._embed_refreshBtnOver_png,
                "disabledSkin":ThemeAssets._embed_refreshBtn_png
            };
            _local_1._editBtn = {
                "upSkin":ThemeAssets._embed_editButton_png,
                "downSkin":ThemeAssets._embed_editBtnDown_png,
                "overSkin":ThemeAssets._embed_editBtnOver_png,
                "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
            };
            _local_1._clearTextBtn = {
                "upSkin":ThemeAssets._embed_clearTextBtn_png,
                "downSkin":ThemeAssets._embed_clearTextBtn_png,
                "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearTextBtn_png
            };
            _local_1._close = {
                "upSkin":ThemeAssets._embed_winCloseBtn_png,
                "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
                "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
                "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
            };
            _local_1._textBackground = {
                "cornerRadius":3,
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF,
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
            _local_1._chatInput = {
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
            _local_1._textInput = {
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
            _local_1._labelWithBackGround = {
                "textAlign":"center",
                "color":0xFFFFFF,
                "backgroundAlpha":0,
                "fontSize":12,
                "borderStyle":"none",
                "fontFamily":"DejaVu Sans"
            };
            _local_1._PropertyName1 = {
                "color":0xFFFFFF,
                "fontWeight":"bold",
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._ParamgraphText1 = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._focusColor = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans"
            };
            return (_local_1);
        }

        public function get Default_Grey_RE_Theme():Object
        {
            var _local_1:Object = new Object();
            _local_1.mainApp = {
                "backgroundColor":6513767,
                "backgroundGradientAlphas":[0, 0]
            };
            _local_1.ToolTip = {
                "cornerRadius":0,
                "paddingTop":7,
                "paddingBottom":7,
                "paddingLeft":8,
                "paddingRight":8,
                "color":0xFFFFFF,
                "fontSize":11,
                "fontFamily":"DejaVu Sans",
                "backgroundColor":2302752,
                "backgroundAlpha":0.93
            };
            _local_1._REmainLoginForm = {
                "cornerRadius":0,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":10066588,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REmainFormText = {
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF
            };
            _local_1._REmainScreen = {
                "backgroundAlpha":0,
                "backgroundImage":null
            };
            _local_1._REmainScreenTopNamePopupTitleContainer = {"backgroundImage":ThemeAssets._embed_rePopUpWinTitleBg_png};
            _local_1._REmainScreenTopNameText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":15,
                "color":0xFFFFFF,
                "top":4
            };
            _local_1._REmainScreenServerClockTimeField = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":21,
                "color":0xFFFFFF
            };
            _local_1._REmainScreenMainPanel = {
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":10066588,
                "backgroundAlpha":1
            };
            _local_1._REtoggleBox = {
                "disabledIcon":ThemeAssets._embed_RE_toggleBoxOffDisabled_png,
                "selectedDisabledIcon":ThemeAssets._embed_RE_toggleBoxOnDisabled_png,
                "selectedUpIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "selectedOverIcon":ThemeAssets._embed_RE_toggleBoxOnOver_png,
                "selectedDownIcon":ThemeAssets._embed_RE_toggleBoxOn_png,
                "upIcon":ThemeAssets._embed_RE_toggleBoxOff_png,
                "overIcon":ThemeAssets._embed_RE_toggleBoxOffOver_png,
                "downIcon":ThemeAssets._embed_RE_toggleBoxOff_png
            };
            _local_1._REcheckBox = {
                "disabledIcon":ThemeAssets._embed_checkBoxDisable_png,
                "selectedDisabledIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedUpIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedOverIcon":ThemeAssets._embed_checkBoxSelected_png,
                "selectedDownIcon":ThemeAssets._embed_checkBoxSelected_png,
                "upIcon":ThemeAssets._embed_checkBox_png,
                "overIcon":ThemeAssets._embed_checkBox_png,
                "downIcon":ThemeAssets._embed_checkBox_png
            };
            _local_1._txtAreaStyle = {
                "textAlign":"left",
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0xFFFFFF,
                "backgroundColor":5197905,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._inputArea = {
                "textAlign":"left",
                "cornerRadius":5,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "color":0x101010,
                "backgroundColor":16382456,
                "backgroundDisabledColor":13290185,
                "backgroundAlpha":1,
                "themeColor":2105893,
                "borderColor":0x222222,
                "borderStyle":"solid",
                "borderThickness":1,
                "focusAlpha":0
            };
            _local_1._RElogBox = {
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
            _local_1._clearLogBtn = {
                "upSkin":ThemeAssets._embed_clearLogBtn_png,
                "downSkin":ThemeAssets._embed_clearLogBtnDown_png,
                "overSkin":ThemeAssets._embed_clearLogBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearLogBtn_png
            };
            _local_1._REchatBox = {
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
            _local_1._REdataGrid = {
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontThickness":20,
                "headerColors":[5790043, 4868683],
                "themeColor":2105893,
                "rollOverColor":11908792,
                "selectionColor":8376063,
                "alternatingItemColors":[15592942, 16185079],
                "backgroundDisabledColor":13421769,
                "horizontalGridLines":true,
                "horizontalGridLineColor":0xADADAD,
                "verticalGridLines":true,
                "verticalGridLineColor":0x9D9D9D,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1
            };
            _local_1._columnHeaderSyle = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontWeight":"normal",
                "fontThickness":120
            };
            _local_1._REwinBtn = {
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
                "disabledColor":0x555555,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinOkayBtn = {
                "cornerRadius":0,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":0x238C00,
                "color":592654,
                "textRollOverColor":0x136100,
                "disabledColor":0x555555,
                "fillColors":[14672356, 14672356, 12181931, 12181931],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REwinCancelBtn = {
                "cornerRadius":0,
                "fontThickness":0,
                "minWidth":40,
                "height":21,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":15425889,
                "color":592654,
                "textRollOverColor":0xA20000,
                "disabledColor":0x555555,
                "fillColors":[14672356, 14672356, 15117227, 15117227],
                "fillAlphas":[1, 1, 1, 1],
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12,
                "horizontalGap":0,
                "paddingLeft":5,
                "paddingRight":5,
                "paddingTop":1,
                "paddingBottom":0
            };
            _local_1._REpopupWinBase = {
                "cornerRadius":0,
                "borderColor":2105893,
                "borderStyle":"solid",
                "borderThickness":1,
                "backgroundColor":10066588,
                "backgroundAlpha":1,
                "dropShadowEnabled":true,
                "dropShadowColor":395017
            };
            _local_1._REpopupWinTitleText = {
                "fontFamily":"DejaVu Sans",
                "fontWeight":"bold",
                "fontSize":13,
                "color":0xFFFFFF,
                "top":4
            };
            _local_1._REnumStepUpBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepUp_png
            };
            _local_1._REnumStepDnBtn = {
                "width":19,
                "height":11,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_numStepDn_png
            };
            _local_1._REaddBtn = {
                "width":12,
                "height":12,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addIcon_png,
                "disabledIcon":ThemeAssets._embed_addIcon_disabled_png
            };
            _local_1._REaddAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_addAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_addAttribIcon_disabled_png
            };
            _local_1._REsubAttributeBtn = {
                "width":16,
                "height":16,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":4211269,
                "themeColor":489687,
                "fillColors":[14672356, 14672356, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "cornerRadius":0,
                "horizontalGap":0,
                "paddingLeft":1,
                "paddingRight":1,
                "paddingTop":0,
                "paddingBottom":0,
                "icon":ThemeAssets._embed_subAttribIcon_png,
                "disabledIcon":ThemeAssets._embed_subAttribIcon_disabled_png
            };
            _local_1._horizontalSeparator2pxLine = {
                "height":2,
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoLine_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoDarkFadedBackground = {
                "horizontalGap":0,
                "verticalGap":0,
                "backgroundImage":ThemeAssets._embed_cityInfoBackGrnd_png,
                "backgroundSize":"100%",
                "backgroundAlpha":1
            };
            _local_1._cityTopInfoText = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontThickness":20,
                "fontWeight":"bold",
                "fontSize":13
            };
            _local_1._newArmyTroop = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontWeight":"normal",
                "fontSize":12
            };
            _local_1._REtabBar = {
                "fontFamily":"DejaVu Sans",
                "fontThickness":0
            };
            _local_1._REtabBarTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "cornerRadius":0,
                "borderColor":2105893,
                "themeColor":2105893,
                "backgroundColor":2105893,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[0x323232, 2105893, 0x424242, 0x323232],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarAccountTabs = {
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
                "fillColors":[13685461, 9474709, 14540755, 10328739],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REtabBarCitiesTab = {
                "paddingLeft":3,
                "paddingRight":3,
                "horizontalGap":0,
                "cornerRadius":0,
                "borderColor":3289909,
                "themeColor":3289909,
                "backgroundColor":3289909,
                "color":0xFFFFFF,
                "textRollOverColor":0xFFFFFF,
                "fontFamily":"DejaVu Sans",
                "fontSize":12,
                "fontWeight":"normal",
                "fillColors":[0xA0A0A0, 5395285, 0xBDBDBD, 7105903],
                "fillAlphas":[1, 1, 1, 1]
            };
            _local_1._REmailComposeView = {"backgroundColor":6513767};
            _local_1._ComboBox = {
                "cornerRadius":0,
                "fontAlign":"center",
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "textRollOverColor":0x111111,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":489687,
                "fillColors":[0xE1E1E1, 0xE1E1E1, 15069691, 15069691],
                "fillAlphas":[1, 1, 1, 1],
                "focusAlpha":0,
                "dropdownStyleName":"comboBoxDropdown"
            };
            _local_1._comboBoxDropdown = {
                "cornerRadius":0,
                "fontSize":11,
                "fontWeight":"normal",
                "fontFamily":"DejaVu Sans",
                "color":0x111111,
                "backgroundColor":0xFFFFFF,
                "borderThickness":1,
                "borderStyle":"solid",
                "borderColor":0x6D6D6D,
                "themeColor":489687
            };
            _local_1._nextBtn = {
                "upSkin":ThemeAssets._embed_RE_nextBtn_png,
                "downSkin":ThemeAssets._embed_RE_nextBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_nextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_nextBtnDisabled_png
            };
            _local_1._previousBtn = {
                "upSkin":ThemeAssets._embed_RE_previousBtn_png,
                "downSkin":ThemeAssets._embed_RE_previousBtnDown_png,
                "overSkin":ThemeAssets._embed_RE_previousBtnOver_png,
                "disabledSkin":ThemeAssets._embed_RE_previousBtnDisabled_png
            };
            _local_1._refreshBtn = {
                "upSkin":ThemeAssets._embed_refreshBtn_png,
                "downSkin":ThemeAssets._embed_refreshBtnDown_png,
                "overSkin":ThemeAssets._embed_refreshBtnOver_png,
                "disabledSkin":ThemeAssets._embed_refreshBtn_png
            };
            _local_1._editBtn = {
                "upSkin":ThemeAssets._embed_editButton_png,
                "downSkin":ThemeAssets._embed_editBtnDown_png,
                "overSkin":ThemeAssets._embed_editBtnOver_png,
                "disabledSkin":ThemeAssets._embed_editBtnDisabled_png
            };
            _local_1._clearTextBtn = {
                "upSkin":ThemeAssets._embed_clearTextBtn_png,
                "downSkin":ThemeAssets._embed_clearTextBtn_png,
                "overSkin":ThemeAssets._embed_clearTextBtnOver_png,
                "disabledSkin":ThemeAssets._embed_clearTextBtn_png
            };
            _local_1._close = {
                "upSkin":ThemeAssets._embed_winCloseBtn_png,
                "downSkin":ThemeAssets._embed_winCloseBtnDown_png,
                "overSkin":ThemeAssets._embed_winCloseBtnOver_png,
                "disabledSkin":ThemeAssets._embed_winCloseBtnDown_png
            };
            _local_1._textBackground = {
                "cornerRadius":0,
                "fontFamily":"DejaVu Sans",
                "fontSize":13,
                "color":0xFFFFFF,
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
            _local_1._chatInput = {
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
            _local_1._textInput = {
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
            _local_1._labelWithBackGround = {
                "textAlign":"center",
                "color":0xFFFFFF,
                "backgroundAlpha":0,
                "fontSize":12,
                "borderStyle":"none",
                "fontFamily":"DejaVu Sans"
            };
            _local_1._PropertyName1 = {
                "color":0xFFFFFF,
                "fontWeight":"bold",
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._ParamgraphText1 = {
                "color":0xFFFFFF,
                "fontSize":12,
                "fontFamily":"DejaVu Sans"
            };
            _local_1._focusColor = {
                "color":0xFFFFFF,
                "fontFamily":"DejaVu Sans"
            };
            return (_local_1);
        }


    }
}//package autoevony.gui.controls.themes

