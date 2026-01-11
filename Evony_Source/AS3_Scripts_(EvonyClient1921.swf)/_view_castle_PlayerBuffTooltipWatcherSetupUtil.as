// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_PlayerBuffTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.PlayerBuffTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castle_PlayerBuffTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PlayerBuffTooltip.watcherSetupUtil = new (_view_castle_PlayerBuffTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("bean", {"propertyChange":true}, [_arg_3[2], _arg_3[1], _arg_3[3], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("descName", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("endTime", {"propertyChange":true}, [_arg_3[2], _arg_3[1], _arg_3[3]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[2]);
        }


    }
}//package 

