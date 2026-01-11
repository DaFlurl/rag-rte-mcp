// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_BattleReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.BattleReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_BattleReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BattleReportDetail.watcherSetupUtil = new (_view_module_info_reports_BattleReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[53] = new PropertyWatcher("lotResObj", {"propertyChange":true}, [_arg_3[131], _arg_3[133], _arg_3[132], _arg_3[135], _arg_3[130]], _arg_2);
            _arg_4[15] = new PropertyWatcher("atkTroopObj", {"propertyChange":true}, [_arg_3[19], _arg_3[26], _arg_3[28], _arg_3[21], _arg_3[29], _arg_3[20], _arg_3[25], _arg_3[27]], _arg_2);
            _arg_4[16] = new PropertyWatcher("king", {"propertyChange":true}, [_arg_3[19], _arg_3[21], _arg_3[20]], null);
            _arg_4[56] = new PropertyWatcher("bakTroopObj", {"propertyChange":true}, [_arg_3[136], _arg_3[141], _arg_3[139], _arg_3[137], _arg_3[143], _arg_3[145], _arg_3[142], _arg_3[144], _arg_3[138]], _arg_2);
            _arg_4[58] = new PropertyWatcher("isBack", {"propertyChange":true}, [_arg_3[141], _arg_3[143], _arg_3[142], _arg_3[144]], null);
            _arg_4[48] = new PropertyWatcher("loseHeroObj", {"propertyChange":true}, [_arg_3[119], _arg_3[117], _arg_3[116], _arg_3[115], _arg_3[118]], _arg_2);
            _arg_4[60] = new PropertyWatcher("showReturn", {"propertyChange":true}, [_arg_3[148], _arg_3[147]], _arg_2);
            _arg_4[3] = new PropertyWatcher("startPos", {"propertyChange":true}, [_arg_3[146], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[0] = new PropertyWatcher("obj", {"propertyChange":true}, [_arg_3[30], _arg_3[171], _arg_3[158], _arg_3[31], _arg_3[95], _arg_3[123], _arg_3[113], _arg_3[159], _arg_3[86], _arg_3[59], _arg_3[34], _arg_3[96], _arg_3[124], _arg_3[169], _arg_3[160], _arg_3[60], _arg_3[85], _arg_3[61], _arg_3[1], _arg_3[100], _arg_3[122], _arg_3[68], _arg_3[58], _arg_3[63], _arg_3[3], _arg_3[172], _arg_3[81], _arg_3[166], _arg_3[64], _arg_3[2], _arg_3[121], _arg_3[120], _arg_3[163], _arg_3[94], _arg_3[126], _arg_3[168], _arg_3[23], _arg_3[87], _arg_3[150], _arg_3[35], _arg_3[7], _arg_3[54], _arg_3[161], _arg_3[149], _arg_3[105], _arg_3[53], _arg_3[65], _arg_3[33], _arg_3[6], _arg_3[93], _arg_3[125], _arg_3[24], _arg_3[88], _arg_3[4], _arg_3[55], _arg_3[114], _arg_3[127], _arg_3[167], _arg_3[108], _arg_3[76], _arg_3[128], _arg_3[74], _arg_3[164], _arg_3[153], _arg_3[56], _arg_3[79], _arg_3[107], _arg_3[16], _arg_3[48], _arg_3[112], _arg_3[80], _arg_3[73], _arg_3[129], _arg_3[41], _arg_3[97], _arg_3[70], _arg_3[106], _arg_3[14], _arg_3[83], _arg_3[47], _arg_3[75], _arg_3[175], _arg_3[18], _arg_3[155], _arg_3[66], _arg_3[103], _arg_3[98], _arg_3[12], _arg_3[17], _arg_3[13], _arg_3[156], _arg_3[102], _arg_3[84], _arg_3[101], _arg_3[151], _arg_3[51], _arg_3[8], _arg_3[40], _arg_3[99], _arg_3[104], _arg_3[49], _arg_3[71], _arg_3[22], _arg_3[134], _arg_3[9], _arg_3[152], _arg_3[78], _arg_3[52], _arg_3[90], _arg_3[111], _arg_3[11], _arg_3[50], _arg_3[91], _arg_3[39], _arg_3[109], _arg_3[92], _arg_3[89], _arg_3[110], _arg_3[174], _arg_3[10], _arg_3[69], _arg_3[0]], _arg_2);
            _arg_4[40] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[68], _arg_3[96], _arg_3[97], _arg_3[65], _arg_3[99], _arg_3[95], _arg_3[66], _arg_3[98], _arg_3[69]], null);
            _arg_4[42] = new PropertyWatcher("heroExp", {"propertyChange":true}, [_arg_3[100], _arg_3[73], _arg_3[104], _arg_3[70], _arg_3[102], _arg_3[74], _arg_3[103], _arg_3[71], _arg_3[101]], null);
            _arg_4[9] = new PropertyWatcher("isAntiColony", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[6], _arg_3[1], _arg_3[3], _arg_3[7]], null);
            _arg_4[68] = new PropertyWatcher("isUprising", {"propertyChange":true}, [_arg_3[168], _arg_3[169], _arg_3[171], _arg_3[175], _arg_3[174], _arg_3[172]], null);
            _arg_4[50] = new PropertyWatcher("isSeize", {"propertyChange":true}, [_arg_3[128], _arg_3[129], _arg_3[126], _arg_3[127], _arg_3[125]], null);
            _arg_4[17] = new PropertyWatcher("isAttackSuccess", {"propertyChange":true}, [_arg_3[47], _arg_3[23], _arg_3[40], _arg_3[158], _arg_3[175], _arg_3[167], _arg_3[155], _arg_3[39], _arg_3[159], _arg_3[22], _arg_3[166], _arg_3[134], _arg_3[41], _arg_3[156], _arg_3[152], _arg_3[174], _arg_3[24], _arg_3[153]], null);
            _arg_4[30] = new PropertyWatcher("isColonial", {"propertyChange":true}, [_arg_3[149], _arg_3[47], _arg_3[156], _arg_3[158], _arg_3[150], _arg_3[152], _arg_3[155], _arg_3[153], _arg_3[159]], null);
            _arg_4[27] = new PropertyWatcher("round", {"propertyChange":true}, [_arg_3[47], _arg_3[48], _arg_3[49]], null);
            _arg_4[46] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[111], _arg_3[83], _arg_3[114], _arg_3[84], _arg_3[112], _arg_3[110], _arg_3[80], _arg_3[113], _arg_3[81]], null);
            _arg_4[11] = new PropertyWatcher("unNomal", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[11], _arg_3[10], _arg_3[12]], null);
            _arg_4[36] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[58], _arg_3[55], _arg_3[87], _arg_3[85], _arg_3[89], _arg_3[56], _arg_3[86], _arg_3[88], _arg_3[59]], null);
            _arg_4[49] = new PropertyWatcher("seizeProblem", {"propertyChange":true}, [_arg_3[122], _arg_3[124], _arg_3[121], _arg_3[123], _arg_3[120]], null);
            _arg_4[35] = new PropertyWatcher("attackWinnerItems", {"propertyChange":true}, [_arg_3[51], _arg_3[53], _arg_3[50], _arg_3[52], _arg_3[54]], null);
            _arg_4[65] = new PropertyWatcher("isSuppress", {"propertyChange":true}, [_arg_3[166], _arg_3[161], _arg_3[163], _arg_3[160], _arg_3[164], _arg_3[167]], null);
            _arg_4[1] = new PropertyWatcher("isAttack", {"propertyChange":true}, [_arg_3[34], _arg_3[17], _arg_3[134], _arg_3[2], _arg_3[151], _arg_3[33], _arg_3[16], _arg_3[1], _arg_3[18], _arg_3[35], _arg_3[0]], null);
            _arg_4[38] = new PropertyWatcher("injuredPer", {"propertyChange":true}, [_arg_3[90], _arg_3[64], _arg_3[94], _arg_3[92], _arg_3[60], _arg_3[61], _arg_3[63], _arg_3[93], _arg_3[91]], null);
            _arg_4[44] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[105], _arg_3[107], _arg_3[79], _arg_3[109], _arg_3[75], _arg_3[106], _arg_3[78], _arg_3[108], _arg_3[76]], null);
            _arg_4[71] = new PropertyWatcher("autoHealObj", {"propertyChange":true}, [_arg_3[178], _arg_3[177], _arg_3[176]], _arg_2);
            _arg_4[69] = new PropertyWatcher("upriseSuppressText", {"propertyChange":true}, [_arg_3[170]], _arg_2);
            _arg_4[5] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[63] = new PropertyWatcher("timeText", {"propertyChange":true}, [_arg_3[154]], _arg_2);
            _arg_4[66] = new PropertyWatcher("coloniSuppressText", {"propertyChange":true}, [_arg_3[162]], _arg_2);
            _arg_4[23] = new PropertyWatcher("defTroopObj", {"propertyChange":true}, [_arg_3[45], _arg_3[36], _arg_3[38], _arg_3[43], _arg_3[46], _arg_3[42], _arg_3[37], _arg_3[44]], _arg_2);
            _arg_4[24] = new PropertyWatcher("king", {"propertyChange":true}, [_arg_3[36], _arg_3[38], _arg_3[37]], null);
            _arg_4[64] = new PropertyWatcher("colonizationText", {"propertyChange":true}, [_arg_3[157]], _arg_2);
            _arg_4[53].updateParent(_arg_1);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[15].addChild(_arg_4[16]);
            _arg_4[56].updateParent(_arg_1);
            _arg_4[56].addChild(_arg_4[58]);
            _arg_4[48].updateParent(_arg_1);
            _arg_4[60].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[40]);
            _arg_4[0].addChild(_arg_4[42]);
            _arg_4[0].addChild(_arg_4[9]);
            _arg_4[0].addChild(_arg_4[68]);
            _arg_4[0].addChild(_arg_4[50]);
            _arg_4[0].addChild(_arg_4[17]);
            _arg_4[0].addChild(_arg_4[30]);
            _arg_4[0].addChild(_arg_4[27]);
            _arg_4[0].addChild(_arg_4[46]);
            _arg_4[0].addChild(_arg_4[11]);
            _arg_4[0].addChild(_arg_4[36]);
            _arg_4[0].addChild(_arg_4[49]);
            _arg_4[0].addChild(_arg_4[35]);
            _arg_4[0].addChild(_arg_4[65]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[38]);
            _arg_4[0].addChild(_arg_4[44]);
            _arg_4[71].updateParent(_arg_1);
            _arg_4[69].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[63].updateParent(_arg_1);
            _arg_4[66].updateParent(_arg_1);
            _arg_4[23].updateParent(_arg_1);
            _arg_4[23].addChild(_arg_4[24]);
            _arg_4[64].updateParent(_arg_1);
        }


    }
}//package 

