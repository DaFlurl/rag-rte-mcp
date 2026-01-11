// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_AwardHeroWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.AwardHero;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_herosMansion_AwardHeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AwardHero.watcherSetupUtil = new (_view_module_herosMansion_AwardHeroWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("heroMes", {"propertyChange":true}, [_arg_3[13], _arg_3[9], _arg_3[8], _arg_3[1], _arg_3[7]], _arg_2);
            _arg_4[9] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[13], _arg_3[8]], null);
            _arg_4[10] = new PropertyWatcher("isHero", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[11] = new PropertyWatcher("loyalty", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[2] = new PropertyWatcher("buffsArray", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[8] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[14] = new PropertyWatcher("itemArrayCB", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[9]);
            _arg_4[1].addChild(_arg_4[10]);
            _arg_4[1].addChild(_arg_4[11]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[8]);
            _arg_4[14].updateParent(_arg_1);
        }


    }
}//package 

