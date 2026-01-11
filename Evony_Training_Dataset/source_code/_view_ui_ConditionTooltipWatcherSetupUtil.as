// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_ConditionTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ConditionTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_ConditionTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ConditionTooltip.watcherSetupUtil = new (_view_ui_ConditionTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("dataP", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[3] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[3]], null);
            _arg_4[12] = new PropertyWatcher("buildingTime", {"propertyChange":true}, [_arg_3[14], _arg_3[12]], _arg_2);
            _arg_4[0] = new PropertyWatcher("title", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[7] = new PropertyWatcher("recoverDataP", {"propertyChange":true}, [_arg_3[8], _arg_3[7]], _arg_2);
            _arg_4[8] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[8]], null);
            _arg_4[1] = new PropertyWatcher("desc", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[7].addChild(_arg_4[8]);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

