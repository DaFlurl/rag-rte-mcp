// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_MainWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.MainWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.Context;
    import view.module.guide.GuideStep;
    import com.evony.GameConfig;

    public class _view_MainWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MainWin.watcherSetupUtil = new (_view_MainWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[48] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[36]], null);
            watchers[49] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[36]], null);
            watchers[100] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[71]], null);
            watchers[101] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[71]], null);
            watchers[188] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[103]], null);
            watchers[189] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[103]], null);
            watchers[96] = new PropertyWatcher("skipBtnBottom", {"propertyChange":true}, [bindings[66]], propertyGetter);
            watchers[73] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[57]], null);
            watchers[74] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[57]], null);
            watchers[46] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[35]], null);
            watchers[47] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[35]], null);
            watchers[143] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[85]], null);
            watchers[137] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[84]], null);
            watchers[138] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[84]], null);
            watchers[186] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[102]], null);
            watchers[187] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[102]], null);
            watchers[115] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[79]], null);
            watchers[116] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[79]], null);
            watchers[104] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[73]], null);
            watchers[105] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[73]], null);
            watchers[117] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[80]], null);
            watchers[118] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[80]], null);
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[0]], null);
            watchers[109] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[76]], null);
            watchers[110] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[76]], null);
            watchers[114] = new PropertyWatcher("noticeText", {"propertyChange":true}, [bindings[78]], propertyGetter);
            watchers[190] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[104]], null);
            watchers[191] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[104]], null);
            watchers[203] = new PropertyWatcher("allWinFrmHv", {"propertyChange":true}, [bindings[111]], propertyGetter);
            watchers[50] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[37]], null);
            watchers[51] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[37]], null);
            watchers[182] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[100]], null);
            watchers[183] = new PropertyWatcher("hideViewHere", {"propertyChange":true}, [bindings[100]], null);
            watchers[78] = new PropertyWatcher("equipBtn", {"propertyChange":true}, [bindings[60]], propertyGetter);
            watchers[79] = new PropertyWatcher("enabled", {"enabledChanged":true}, [bindings[60]], null);
            watchers[200] = new PropertyWatcher("helpUrl", {"propertyChange":true}, [bindings[109]], propertyGetter);
            watchers[38] = new PropertyWatcher("chat_HtmlMsg", {"propertyChange":true}, [bindings[30]], propertyGetter);
            watchers[163] = new PropertyWatcher("guidLadyBottom", {"propertyChange":true}, [bindings[96], bindings[91]], propertyGetter);
            watchers[157] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[88]], null);
            watchers[158] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[88]], null);
            watchers[196] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[107]], null);
            watchers[197] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[107]], null);
            watchers[204] = new PropertyWatcher("allWinFrmVv", {"propertyChange":true}, [bindings[112]], propertyGetter);
            watchers[14] = new PropertyWatcher("skipBtnRight", {"propertyChange":true}, [bindings[8], bindings[65], bindings[11]], propertyGetter);
            watchers[67] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[53]], null);
            watchers[68] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[53]], null);
            watchers[172] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[99]], null);
            watchers[173] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[99]], null);
            watchers[149] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[86]], null);
            watchers[150] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[86]], null);
            watchers[60] = new PropertyWatcher("newQuestNumber", {"propertyChange":true}, [bindings[43], bindings[42], bindings[44]], propertyGetter);
            watchers[54] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[39]], null);
            watchers[55] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[39]], null);
            watchers[102] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[72]], null);
            watchers[103] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[72]], null);
            watchers[52] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[38]], null);
            watchers[53] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[38]], null);
            watchers[201] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[110]], null);
            watchers[202] = new PropertyWatcher("need_QuestGuid", {"propertyChange":true}, [bindings[110]], null);
            watchers[153] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[86]], null);
            watchers[154] = new PropertyWatcher("hideViewHere", {"propertyChange":true}, [bindings[86]], null);
            watchers[170] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[98]], null);
            watchers[171] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[98]], null);
            watchers[80] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[61]], null);
            watchers[81] = new PropertyWatcher("serverID", {"propertyChange":true}, [bindings[61]], null);
            watchers[84] = new FunctionReturnWatcher("toLowerCase", target, function ():Array
            {
                return ([]);
            }, null, [bindings[61]], null);
            watchers[86] = new FunctionReturnWatcher("toLowerCase", target, function ():Array
            {
                return ([]);
            }, null, [bindings[61]], null);
            watchers[123] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[81]], null);
            watchers[124] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[81]], null);
            watchers[192] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[105]], null);
            watchers[193] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[105]], null);
            watchers[58] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[41]], null);
            watchers[59] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[41]], null);
            watchers[18] = new StaticPropertyWatcher("isTryUser", {"propertyChange":true}, [bindings[10], bindings[69]], null);
            watchers[155] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[87]], null);
            watchers[156] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[87]], null);
            watchers[65] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[52]], null);
            watchers[66] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[52]], null);
            watchers[147] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[86]], null);
            watchers[148] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[86]], null);
            watchers[141] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[85]], null);
            watchers[142] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[85]], null);
            watchers[4] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[5] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[2]], null);
            watchers[93] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[63]], null);
            watchers[94] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[63]], null);
            watchers[125] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[82]], null);
            watchers[126] = new PropertyWatcher("townTask", {"propertyChange":true}, [bindings[82]], null);
            watchers[135] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[84]], null);
            watchers[136] = new PropertyWatcher("cityTask", {"propertyChange":true}, [bindings[84]], null);
            watchers[61] = new PropertyWatcher("newUsualReportNumber", {"propertyChange":true}, [bindings[45], bindings[47], bindings[46]], propertyGetter);
            watchers[174] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[99]], null);
            watchers[175] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[99]], null);
            watchers[8] = new PropertyWatcher("skip_btn", {"propertyChange":true}, [bindings[4], bindings[3], bindings[10], bindings[5]], propertyGetter);
            watchers[9] = new PropertyWatcher("visible", {
                "show":true,
                "hide":true
            }, [bindings[4], bindings[3], bindings[10], bindings[5]], null);
            watchers[127] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[82]], null);
            watchers[128] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[82]], null);
            watchers[178] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[100]], null);
            watchers[179] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[100]], null);
            watchers[6] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[7] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[2]], null);
            watchers[165] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[93]], null);
            watchers[166] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[93]], null);
            watchers[159] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[89]], null);
            watchers[160] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[89]], null);
            watchers[12] = new PropertyWatcher("irisIn", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[107] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[75]], null);
            watchers[108] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[75]], null);
            watchers[113] = new PropertyWatcher("isBookMark", {"propertyChange":true}, [bindings[76]], propertyGetter);
            watchers[13] = new PropertyWatcher("irisOut", {"propertyChange":true}, [bindings[7]], propertyGetter);
            watchers[131] = new PropertyWatcher("cityOutBtn", {"propertyChange":true}, [bindings[83], bindings[84]], propertyGetter);
            watchers[132] = new PropertyWatcher("selected", {
                "valueCommit":true,
                "click":true
            }, [bindings[83], bindings[84]], null);
            watchers[98] = new PropertyWatcher("saveBtnBottom", {"propertyChange":true}, [bindings[68]], propertyGetter);
            watchers[180] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[100]], null);
            watchers[181] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[100]], null);
            watchers[139] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[85]], null);
            watchers[140] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[85]], null);
            watchers[16] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[17] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[10]], null);
            watchers[161] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[90]], null);
            watchers[162] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[90]], null);
            watchers[42] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[33]], null);
            watchers[43] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[33]], null);
            watchers[176] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[99]], null);
            watchers[177] = new PropertyWatcher("hideViewHere", {"propertyChange":true}, [bindings[99]], null);
            watchers[19] = new PropertyWatcher("playerInfoBean", {"propertyChange":true}, [bindings[15], bindings[13], bindings[19], bindings[26], bindings[21], bindings[16], bindings[18], bindings[29], bindings[24], bindings[27], bindings[22]], propertyGetter);
            watchers[29] = new PropertyWatcher("honor", {"propertyChange":true}, [bindings[21], bindings[22]], null);
            watchers[20] = new PropertyWatcher("userName", {"propertyChange":true}, [bindings[13]], null);
            watchers[37] = new PropertyWatcher("titleId", {"propertyChange":true}, [bindings[29]], null);
            watchers[31] = new PropertyWatcher("office", {"propertyChange":true}, [bindings[24]], null);
            watchers[26] = new PropertyWatcher("allianceLevel", {"propertyChange":true}, [bindings[19]], null);
            watchers[23] = new PropertyWatcher("prestige", {"propertyChange":true}, [bindings[15], bindings[16]], null);
            watchers[25] = new PropertyWatcher("alliance", {"propertyChange":true}, [bindings[18]], null);
            watchers[34] = new PropertyWatcher("ranking", {"propertyChange":true}, [bindings[26], bindings[27]], null);
            watchers[119] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[81]], null);
            watchers[120] = new PropertyWatcher("townTask", {"propertyChange":true}, [bindings[81]], null);
            watchers[97] = new PropertyWatcher("saveBtnRight", {"propertyChange":true}, [bindings[67]], propertyGetter);
            watchers[133] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[83]], null);
            watchers[134] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[83]], null);
            watchers[151] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[86]], null);
            watchers[56] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[40]], null);
            watchers[57] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[40]], null);
            watchers[75] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[58]], null);
            watchers[76] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[58]], null);
            watchers[15] = new PropertyWatcher("height", {"heightChanged":true}, [bindings[9], bindings[12]], propertyGetter);
            watchers[194] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[106]], null);
            watchers[195] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[106]], null);
            watchers[10] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[5]], null);
            watchers[11] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[5]], null);
            watchers[62] = new PropertyWatcher("newEmailNumber", {"propertyChange":true}, [bindings[50], bindings[48], bindings[49]], propertyGetter);
            watchers[129] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[83]], null);
            watchers[130] = new PropertyWatcher("cityTask", {"propertyChange":true}, [bindings[83]], null);
            watchers[63] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[51]], null);
            watchers[64] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[51]], null);
            watchers[44] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[34]], null);
            watchers[45] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[34]], null);
            watchers[111] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[76]], null);
            watchers[112] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[76]], null);
            watchers[164] = new PropertyWatcher("glRight", {"propertyChange":true}, [bindings[92], bindings[95]], propertyGetter);
            watchers[121] = new PropertyWatcher("cityInBtn", {"propertyChange":true}, [bindings[82], bindings[81]], propertyGetter);
            watchers[122] = new PropertyWatcher("selected", {
                "valueCommit":true,
                "click":true
            }, [bindings[82], bindings[81]], null);
            watchers[184] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[101]], null);
            watchers[185] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[101]], null);
            watchers[40] = new PropertyWatcher("ChatWorld", {"propertyChange":true}, [bindings[32]], propertyGetter);
            watchers[41] = new PropertyWatcher("selected", {
                "valueCommit":true,
                "click":true
            }, [bindings[32]], null);
            watchers[70] = new PropertyWatcher("autofit", {"propertyChange":true}, [bindings[55]], propertyGetter);
            watchers[71] = new PropertyWatcher("selected", {
                "valueCommit":true,
                "click":true
            }, [bindings[55]], null);
            watchers[198] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[108]], null);
            watchers[199] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[108]], null);
            watchers[169] = new PropertyWatcher("strVisitLabel", {"propertyChange":true}, [bindings[97]], propertyGetter);
            watchers[91] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[62]], null);
            watchers[92] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[62]], null);
            watchers[2] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[1]], null);
            watchers[145] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[85]], null);
            watchers[146] = new PropertyWatcher("hideViewHere", {"propertyChange":true}, [bindings[85]], null);
            watchers[167] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[94]], null);
            watchers[168] = new PropertyWatcher("needUserGuide", {"propertyChange":true}, [bindings[94]], null);
            watchers[48].updateParent(Context);
            watchers[48].addChild(watchers[49]);
            watchers[100].updateParent(Context);
            watchers[100].addChild(watchers[101]);
            watchers[188].updateParent(GuideStep);
            watchers[188].addChild(watchers[189]);
            watchers[96].updateParent(target);
            watchers[73].updateParent(Context);
            watchers[73].addChild(watchers[74]);
            watchers[46].updateParent(Context);
            watchers[46].addChild(watchers[47]);
            watchers[143].updateParent(Context);
            watchers[137].updateParent(Context);
            watchers[137].addChild(watchers[138]);
            watchers[186].updateParent(GuideStep);
            watchers[186].addChild(watchers[187]);
            watchers[115].updateParent(GuideStep);
            watchers[115].addChild(watchers[116]);
            watchers[104].updateParent(Context);
            watchers[104].addChild(watchers[105]);
            watchers[117].updateParent(GuideStep);
            watchers[117].addChild(watchers[118]);
            watchers[0].updateParent(Context);
            watchers[0].addChild(watchers[1]);
            watchers[109].updateParent(Context);
            watchers[109].addChild(watchers[110]);
            watchers[114].updateParent(target);
            watchers[190].updateParent(GuideStep);
            watchers[190].addChild(watchers[191]);
            watchers[203].updateParent(target);
            watchers[50].updateParent(Context);
            watchers[50].addChild(watchers[51]);
            watchers[182].updateParent(GuideStep);
            watchers[182].addChild(watchers[183]);
            watchers[78].updateParent(target);
            watchers[78].addChild(watchers[79]);
            watchers[200].updateParent(target);
            watchers[38].updateParent(target);
            watchers[163].updateParent(target);
            watchers[157].updateParent(GuideStep);
            watchers[157].addChild(watchers[158]);
            watchers[196].updateParent(GuideStep);
            watchers[196].addChild(watchers[197]);
            watchers[204].updateParent(target);
            watchers[14].updateParent(target);
            watchers[67].updateParent(Context);
            watchers[67].addChild(watchers[68]);
            watchers[172].updateParent(GuideStep);
            watchers[172].addChild(watchers[173]);
            watchers[149].updateParent(GuideStep);
            watchers[149].addChild(watchers[150]);
            watchers[60].updateParent(target);
            watchers[54].updateParent(Context);
            watchers[54].addChild(watchers[55]);
            watchers[102].updateParent(Context);
            watchers[102].addChild(watchers[103]);
            watchers[52].updateParent(Context);
            watchers[52].addChild(watchers[53]);
            watchers[201].updateParent(Context);
            watchers[201].addChild(watchers[202]);
            watchers[153].updateParent(GuideStep);
            watchers[153].addChild(watchers[154]);
            watchers[170].updateParent(Context);
            watchers[170].addChild(watchers[171]);
            watchers[80].updateParent(GameConfig);
            watchers[80].addChild(watchers[81]);
            watchers[84].parentWatcher = watchers[81];
            watchers[81].addChild(watchers[84]);
            watchers[86].parentWatcher = watchers[81];
            watchers[81].addChild(watchers[86]);
            watchers[123].updateParent(Context);
            watchers[123].addChild(watchers[124]);
            watchers[192].updateParent(GuideStep);
            watchers[192].addChild(watchers[193]);
            watchers[58].updateParent(Context);
            watchers[58].addChild(watchers[59]);
            watchers[18].updateParent(EvonyClient);
            watchers[155].updateParent(GuideStep);
            watchers[155].addChild(watchers[156]);
            watchers[65].updateParent(Context);
            watchers[65].addChild(watchers[66]);
            watchers[147].updateParent(GuideStep);
            watchers[147].addChild(watchers[148]);
            watchers[141].updateParent(GuideStep);
            watchers[141].addChild(watchers[142]);
            watchers[4].updateParent(Context);
            watchers[4].addChild(watchers[5]);
            watchers[93].updateParent(Context);
            watchers[93].addChild(watchers[94]);
            watchers[125].updateParent(GuideStep);
            watchers[125].addChild(watchers[126]);
            watchers[135].updateParent(GuideStep);
            watchers[135].addChild(watchers[136]);
            watchers[61].updateParent(target);
            watchers[174].updateParent(GuideStep);
            watchers[174].addChild(watchers[175]);
            watchers[8].updateParent(target);
            watchers[8].addChild(watchers[9]);
            watchers[127].updateParent(Context);
            watchers[127].addChild(watchers[128]);
            watchers[178].updateParent(GuideStep);
            watchers[178].addChild(watchers[179]);
            watchers[6].updateParent(Context);
            watchers[6].addChild(watchers[7]);
            watchers[165].updateParent(Context);
            watchers[165].addChild(watchers[166]);
            watchers[159].updateParent(GuideStep);
            watchers[159].addChild(watchers[160]);
            watchers[12].updateParent(target);
            watchers[107].updateParent(Context);
            watchers[107].addChild(watchers[108]);
            watchers[113].updateParent(target);
            watchers[13].updateParent(target);
            watchers[131].updateParent(target);
            watchers[131].addChild(watchers[132]);
            watchers[98].updateParent(target);
            watchers[180].updateParent(GuideStep);
            watchers[180].addChild(watchers[181]);
            watchers[139].updateParent(GuideStep);
            watchers[139].addChild(watchers[140]);
            watchers[16].updateParent(Context);
            watchers[16].addChild(watchers[17]);
            watchers[161].updateParent(GuideStep);
            watchers[161].addChild(watchers[162]);
            watchers[42].updateParent(Context);
            watchers[42].addChild(watchers[43]);
            watchers[176].updateParent(GuideStep);
            watchers[176].addChild(watchers[177]);
            watchers[19].updateParent(target);
            watchers[19].addChild(watchers[29]);
            watchers[19].addChild(watchers[20]);
            watchers[19].addChild(watchers[37]);
            watchers[19].addChild(watchers[31]);
            watchers[19].addChild(watchers[26]);
            watchers[19].addChild(watchers[23]);
            watchers[19].addChild(watchers[25]);
            watchers[19].addChild(watchers[34]);
            watchers[119].updateParent(GuideStep);
            watchers[119].addChild(watchers[120]);
            watchers[97].updateParent(target);
            watchers[133].updateParent(Context);
            watchers[133].addChild(watchers[134]);
            watchers[151].updateParent(Context);
            watchers[56].updateParent(Context);
            watchers[56].addChild(watchers[57]);
            watchers[75].updateParent(Context);
            watchers[75].addChild(watchers[76]);
            watchers[15].updateParent(target);
            watchers[194].updateParent(GuideStep);
            watchers[194].addChild(watchers[195]);
            watchers[10].updateParent(Context);
            watchers[10].addChild(watchers[11]);
            watchers[62].updateParent(target);
            watchers[129].updateParent(GuideStep);
            watchers[129].addChild(watchers[130]);
            watchers[63].updateParent(Context);
            watchers[63].addChild(watchers[64]);
            watchers[44].updateParent(Context);
            watchers[44].addChild(watchers[45]);
            watchers[111].updateParent(Context);
            watchers[111].addChild(watchers[112]);
            watchers[164].updateParent(target);
            watchers[121].updateParent(target);
            watchers[121].addChild(watchers[122]);
            watchers[184].updateParent(GuideStep);
            watchers[184].addChild(watchers[185]);
            watchers[40].updateParent(target);
            watchers[40].addChild(watchers[41]);
            watchers[70].updateParent(target);
            watchers[70].addChild(watchers[71]);
            watchers[198].updateParent(GuideStep);
            watchers[198].addChild(watchers[199]);
            watchers[169].updateParent(target);
            watchers[91].updateParent(Context);
            watchers[91].addChild(watchers[92]);
            watchers[2].updateParent(Context);
            watchers[2].addChild(watchers[3]);
            watchers[145].updateParent(GuideStep);
            watchers[145].addChild(watchers[146]);
            watchers[167].updateParent(Context);
            watchers[167].addChild(watchers[168]);
        }


    }
}//package 

