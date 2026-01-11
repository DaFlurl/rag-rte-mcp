// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_TroopMovementDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.TroopMovementDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_TroopMovementDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TroopMovementDetail.watcherSetupUtil = new (_view_module_info_reports_TroopMovementDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[15] = new PropertyWatcher("resourceObj", {"propertyChange":true}, [_arg_3[26], _arg_3[23], _arg_3[25], _arg_3[24], _arg_3[22]], _arg_2);
            _arg_4[5] = new PropertyWatcher("startPos", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("troopMovementObj", {"propertyChange":true}, [_arg_3[15], _arg_3[4], _arg_3[19], _arg_3[8], _arg_3[11], _arg_3[16], _arg_3[18], _arg_3[3], _arg_3[7], _arg_3[12], _arg_3[17], _arg_3[2], _arg_3[9], _arg_3[21], _arg_3[6], _arg_3[1], _arg_3[20], _arg_3[14], _arg_3[10], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("type", {"propertyChange":true}, [_arg_3[3], _arg_3[0]], null);
            _arg_4[9] = new PropertyWatcher("problem", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[6], _arg_3[10], _arg_3[7]], null);
            _arg_4[10] = new PropertyWatcher("heroUrl", {"propertyChange":true}, [_arg_3[17], _arg_3[11], _arg_3[16], _arg_3[18], _arg_3[12]], null);
            _arg_4[13] = new PropertyWatcher("heroName", {"propertyChange":true}, [_arg_3[19], _arg_3[21], _arg_3[20]], null);
            _arg_4[11] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [_arg_3[19], _arg_3[11], _arg_3[12]], null);
            _arg_4[6] = new PropertyWatcher("isBack", {"propertyChange":true}, [_arg_3[15], _arg_3[2], _arg_3[4], _arg_3[11], _arg_3[1], _arg_3[14], _arg_3[12], _arg_3[5]], null);
            _arg_4[1] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[3], _arg_3[0]], _arg_2);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[3].addChild(_arg_4[9]);
            _arg_4[3].addChild(_arg_4[10]);
            _arg_4[3].addChild(_arg_4[13]);
            _arg_4[3].addChild(_arg_4[11]);
            _arg_4[3].addChild(_arg_4[6]);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

