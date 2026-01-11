// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ZoneInfoTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ZoneInfoTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ZoneInfoTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ZoneInfoTooltip.watcherSetupUtil = new (_view_ZoneInfoTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("zoneInfoBean", {"propertyChange":true}, [_arg_3[6], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[7] = new PropertyWatcher("castleCount", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[6] = new PropertyWatcher("playerCount", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[1] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[8] = new PropertyWatcher("rate", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[7]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[8]);
        }


    }
}//package 

