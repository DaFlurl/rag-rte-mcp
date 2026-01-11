// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_HerosMansion_inlineComponent5WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.HerosMansion_inlineComponent5;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_herosMansion_HerosMansion_inlineComponent5WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HerosMansion_inlineComponent5.watcherSetupUtil = new (_view_module_herosMansion_HerosMansion_inlineComponent5WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[2], _arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("isHero", null, [_arg_3[1], _arg_3[0]], null);
            _arg_4[6] = new PropertyWatcher("intelligence", null, [_arg_3[2]], null);
            _arg_4[4] = new PropertyWatcher("stratagemBuffAdded", null, [_arg_3[2]], null);
            _arg_4[5] = new PropertyWatcher("stratagem", null, [_arg_3[2]], null);
            _arg_4[2] = new PropertyWatcher("parentDocument", {"initialize":true}, [_arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("isKingOrQueen", null, [_arg_3[1], _arg_3[0]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
        }


    }
}//package 

