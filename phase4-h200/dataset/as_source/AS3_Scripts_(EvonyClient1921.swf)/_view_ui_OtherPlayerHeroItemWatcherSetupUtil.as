// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_OtherPlayerHeroItemWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.OtherPlayerHeroItem;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_OtherPlayerHeroItemWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            OtherPlayerHeroItem.watcherSetupUtil = new (_view_ui_OtherPlayerHeroItemWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("heroMes", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[8], _arg_3[6], _arg_3[1], _arg_3[3], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[6] = new PropertyWatcher("speed", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[9] = new PropertyWatcher("power", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[10] = new PropertyWatcher("attack", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[8] = new PropertyWatcher("management", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[4] = new PropertyWatcher("stamina", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[5] = new PropertyWatcher("maxStrength", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[12] = new PropertyWatcher("stratagem", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[1] = new PropertyWatcher("logoUrl", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[13] = new PropertyWatcher("remainPoint", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[11] = new PropertyWatcher("intelligence", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[2] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[7] = new PropertyWatcher("politics", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[9]);
            _arg_4[0].addChild(_arg_4[10]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[12]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[13]);
            _arg_4[0].addChild(_arg_4[11]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[7]);
        }


    }
}//package 

