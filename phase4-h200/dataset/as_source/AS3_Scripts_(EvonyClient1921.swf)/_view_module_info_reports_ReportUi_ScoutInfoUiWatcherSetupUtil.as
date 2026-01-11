// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_ReportUi_ScoutInfoUiWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.ReportUi.ScoutInfoUi;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_ReportUi_ScoutInfoUiWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ScoutInfoUi.watcherSetupUtil = new (_view_module_info_reports_ReportUi_ScoutInfoUiWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("scoutInfoObj", {"propertyChange":true}, [_arg_3[4], _arg_3[30], _arg_3[19], _arg_3[8], _arg_3[23], _arg_3[31], _arg_3[16], _arg_3[18], _arg_3[3], _arg_3[7], _arg_3[27], _arg_3[22], _arg_3[17], _arg_3[2], _arg_3[33], _arg_3[28], _arg_3[6], _arg_3[1], _arg_3[29], _arg_3[20], _arg_3[25], _arg_3[24], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[9] = new PropertyWatcher("population", {"propertyChange":true}, [_arg_3[17], _arg_3[19], _arg_3[23], _arg_3[18], _arg_3[20], _arg_3[25], _arg_3[24], _arg_3[27], _arg_3[22]], null);
            _arg_4[1] = new PropertyWatcher("heroUrl", {"propertyChange":true}, [_arg_3[2], _arg_3[1], _arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("heroName", {"propertyChange":true}, [_arg_3[4], _arg_3[3], _arg_3[5]], null);
            _arg_4[4] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [_arg_3[8], _arg_3[6], _arg_3[7]], null);
            _arg_4[8] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[17], _arg_3[18]], null);
            _arg_4[10] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[17], _arg_3[30], _arg_3[19], _arg_3[33], _arg_3[28], _arg_3[31], _arg_3[18], _arg_3[29], _arg_3[20]], null);
            _arg_4[17] = new PropertyWatcher("scFortObj", {"propertyChange":true}, [_arg_3[47], _arg_3[41], _arg_3[43], _arg_3[42], _arg_3[44]], _arg_2);
            _arg_4[20] = new PropertyWatcher("scTroopObj", {"propertyChange":true}, [_arg_3[51], _arg_3[50], _arg_3[48], _arg_3[54], _arg_3[49]], _arg_2);
            _arg_4[25] = new PropertyWatcher("scTeachObj", {"propertyChange":true}, [_arg_3[64], _arg_3[62], _arg_3[67], _arg_3[61], _arg_3[63]], _arg_2);
            _arg_4[14] = new PropertyWatcher("scBuildObj", {"propertyChange":true}, [_arg_3[34], _arg_3[36], _arg_3[40], _arg_3[35], _arg_3[37]], _arg_2);
            _arg_4[5] = new PropertyWatcher("resoureObj", {"propertyChange":true}, [_arg_3[15], _arg_3[9], _arg_3[11], _arg_3[10], _arg_3[12]], _arg_2);
            _arg_4[23] = new PropertyWatcher("scColonialTroopObj", {"propertyChange":true}, [_arg_3[58], _arg_3[55], _arg_3[60], _arg_3[57], _arg_3[56]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[9]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[10]);
            _arg_4[17].updateParent(_arg_1);
            _arg_4[20].updateParent(_arg_1);
            _arg_4[25].updateParent(_arg_1);
            _arg_4[14].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[23].updateParent(_arg_1);
        }


    }
}//package 

