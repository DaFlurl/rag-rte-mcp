// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_ScoutBattleReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.ScoutBattleReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_ScoutBattleReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ScoutBattleReportDetail.watcherSetupUtil = new (_view_module_info_reports_ScoutBattleReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[49] = new PropertyWatcher("startPos", {"propertyChange":true}, [_arg_3[134]], _arg_2);
            _arg_4[42] = new PropertyWatcher("lotResObj", {"propertyChange":true}, [_arg_3[122], _arg_3[119], _arg_3[117], _arg_3[120], _arg_3[118]], _arg_2);
            _arg_4[0] = new PropertyWatcher("obj", {"propertyChange":true}, [_arg_3[15], _arg_3[62], _arg_3[107], _arg_3[79], _arg_3[43], _arg_3[31], _arg_3[16], _arg_3[95], _arg_3[48], _arg_3[112], _arg_3[80], _arg_3[113], _arg_3[86], _arg_3[32], _arg_3[73], _arg_3[41], _arg_3[96], _arg_3[97], _arg_3[70], _arg_3[85], _arg_3[60], _arg_3[1], _arg_3[61], _arg_3[106], _arg_3[14], _arg_3[100], _arg_3[83], _arg_3[47], _arg_3[68], _arg_3[82], _arg_3[75], _arg_3[58], _arg_3[63], _arg_3[3], _arg_3[103], _arg_3[66], _arg_3[98], _arg_3[81], _arg_3[27], _arg_3[44], _arg_3[2], _arg_3[77], _arg_3[102], _arg_3[121], _arg_3[84], _arg_3[57], _arg_3[101], _arg_3[94], _arg_3[51], _arg_3[8], _arg_3[40], _arg_3[23], _arg_3[104], _arg_3[99], _arg_3[87], _arg_3[72], _arg_3[135], _arg_3[71], _arg_3[22], _arg_3[105], _arg_3[9], _arg_3[53], _arg_3[65], _arg_3[33], _arg_3[6], _arg_3[116], _arg_3[93], _arg_3[78], _arg_3[52], _arg_3[42], _arg_3[115], _arg_3[88], _arg_3[111], _arg_3[90], _arg_3[4], _arg_3[114], _arg_3[26], _arg_3[55], _arg_3[50], _arg_3[67], _arg_3[108], _arg_3[91], _arg_3[76], _arg_3[39], _arg_3[45], _arg_3[109], _arg_3[92], _arg_3[133], _arg_3[89], _arg_3[46], _arg_3[110], _arg_3[25], _arg_3[10], _arg_3[56], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[30] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[90], _arg_3[58], _arg_3[87], _arg_3[60], _arg_3[89], _arg_3[61], _arg_3[57], _arg_3[91], _arg_3[88]], null);
            _arg_4[32] = new PropertyWatcher("heroExp", {"propertyChange":true}, [_arg_3[62], _arg_3[94], _arg_3[96], _arg_3[92], _arg_3[65], _arg_3[95], _arg_3[63], _arg_3[93], _arg_3[66]], null);
            _arg_4[8] = new PropertyWatcher("isAttackSuccess", {"propertyChange":true}, [_arg_3[32], _arg_3[15], _arg_3[33], _arg_3[31], _arg_3[16], _arg_3[14], _arg_3[39]], null);
            _arg_4[39] = new PropertyWatcher("isSeize", {"propertyChange":true}, [_arg_3[114], _arg_3[116], _arg_3[112], _arg_3[135], _arg_3[113], _arg_3[115]], null);
            _arg_4[18] = new PropertyWatcher("round", {"propertyChange":true}, [_arg_3[41], _arg_3[40], _arg_3[39]], null);
            _arg_4[36] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[105], _arg_3[73], _arg_3[75], _arg_3[104], _arg_3[102], _arg_3[72], _arg_3[106], _arg_3[103], _arg_3[76]], null);
            _arg_4[1] = new PropertyWatcher("unNomal", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[1], _arg_3[3], _arg_3[0]], null);
            _arg_4[26] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[47], _arg_3[79], _arg_3[77], _arg_3[51], _arg_3[50], _arg_3[48], _arg_3[78], _arg_3[80], _arg_3[81]], null);
            _arg_4[38] = new PropertyWatcher("seizeProblem", {"propertyChange":true}, [_arg_3[111], _arg_3[107], _arg_3[109], _arg_3[110], _arg_3[108]], null);
            _arg_4[23] = new PropertyWatcher("attackWinnerItems", {"propertyChange":true}, [_arg_3[45], _arg_3[43], _arg_3[46], _arg_3[42], _arg_3[44]], null);
            _arg_4[3] = new PropertyWatcher("isAttack", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[26], _arg_3[133], _arg_3[121], _arg_3[25], _arg_3[10], _arg_3[27]], null);
            _arg_4[28] = new PropertyWatcher("injuredPer", {"propertyChange":true}, [_arg_3[83], _arg_3[82], _arg_3[53], _arg_3[55], _arg_3[85], _arg_3[84], _arg_3[52], _arg_3[56], _arg_3[86]], null);
            _arg_4[34] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[100], _arg_3[68], _arg_3[97], _arg_3[99], _arg_3[70], _arg_3[67], _arg_3[98], _arg_3[71], _arg_3[101]], null);
            _arg_4[6] = new PropertyWatcher("atkTroopObj", {"propertyChange":true}, [_arg_3[17], _arg_3[13], _arg_3[19], _arg_3[21], _arg_3[11], _arg_3[18], _arg_3[20], _arg_3[12]], _arg_2);
            _arg_4[7] = new PropertyWatcher("king", {"propertyChange":true}, [_arg_3[13], _arg_3[11], _arg_3[12]], null);
            _arg_4[45] = new PropertyWatcher("bakTroopObj", {"propertyChange":true}, [_arg_3[131], _arg_3[128], _arg_3[129], _arg_3[126], _arg_3[124], _arg_3[132], _arg_3[123], _arg_3[130], _arg_3[125]], _arg_2);
            _arg_4[47] = new PropertyWatcher("isBack", {"propertyChange":true}, [_arg_3[131], _arg_3[128], _arg_3[129], _arg_3[130]], null);
            _arg_4[14] = new PropertyWatcher("defTroopObj", {"propertyChange":true}, [_arg_3[34], _arg_3[36], _arg_3[30], _arg_3[38], _arg_3[28], _arg_3[29], _arg_3[35], _arg_3[37]], _arg_2);
            _arg_4[15] = new PropertyWatcher("king", {"propertyChange":true}, [_arg_3[30], _arg_3[28], _arg_3[29]], null);
            _arg_4[49].updateParent(_arg_1);
            _arg_4[42].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[30]);
            _arg_4[0].addChild(_arg_4[32]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[39]);
            _arg_4[0].addChild(_arg_4[18]);
            _arg_4[0].addChild(_arg_4[36]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[26]);
            _arg_4[0].addChild(_arg_4[38]);
            _arg_4[0].addChild(_arg_4[23]);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[28]);
            _arg_4[0].addChild(_arg_4[34]);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[7]);
            _arg_4[45].updateParent(_arg_1);
            _arg_4[45].addChild(_arg_4[47]);
            _arg_4[14].updateParent(_arg_1);
            _arg_4[14].addChild(_arg_4[15]);
        }


    }
}//package 

