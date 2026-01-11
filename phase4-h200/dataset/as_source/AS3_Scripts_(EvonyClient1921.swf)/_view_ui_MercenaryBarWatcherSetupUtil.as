// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_MercenaryBarWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.MercenaryBar;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_MercenaryBarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MercenaryBar.watcherSetupUtil = new (_view_ui_MercenaryBarWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("typeStr", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("_mercenaryBean", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[3] = new PropertyWatcher("targetPosName", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[0] = new PropertyWatcher("percent", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[5] = new PropertyWatcher("spaceTime", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
        }


    }
}//package 

