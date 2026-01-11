// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_HolidayTipsWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.HolidayTips;
    import mx.core.IFlexModuleFactory;

    public class _view_ui_HolidayTipsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HolidayTips.watcherSetupUtil = new (_view_ui_HolidayTipsWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

