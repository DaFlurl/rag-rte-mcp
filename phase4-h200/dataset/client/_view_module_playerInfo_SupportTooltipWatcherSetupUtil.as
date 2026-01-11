// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_SupportTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.SupportTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_playerInfo_SupportTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SupportTooltip.watcherSetupUtil = new (_view_module_playerInfo_SupportTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[8] = new PropertyWatcher("statusStyle", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[7] = new PropertyWatcher("status", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[2] = new PropertyWatcher("bean", {"propertyChange":true}, [_arg_3[2], _arg_3[4]], _arg_2);
            _arg_4[5] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[3] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[5]);
            _arg_4[2].addChild(_arg_4[3]);
        }


    }
}//package 

