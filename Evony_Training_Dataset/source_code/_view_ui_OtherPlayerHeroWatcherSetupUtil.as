// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_OtherPlayerHeroWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.OtherPlayerHero;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_OtherPlayerHeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            OtherPlayerHero.watcherSetupUtil = new (_view_ui_OtherPlayerHeroWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("hero3", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[6] = new PropertyWatcher("heroMes", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[7] = new PropertyWatcher("sex", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[1] = new PropertyWatcher("hero1", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[4] = new PropertyWatcher("hero2", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[2] = new PropertyWatcher("heroList", {"propertyChange":true}, [_arg_3[2], _arg_3[9], _arg_3[8], _arg_3[6], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[3] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[2], _arg_3[9], _arg_3[8], _arg_3[6], _arg_3[3], _arg_3[5]], null);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[7]);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
        }


    }
}//package 

