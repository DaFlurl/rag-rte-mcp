// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_HeroChangeNameWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.HeroChangeName;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_herosMansion_HeroChangeNameWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HeroChangeName.watcherSetupUtil = new (_view_module_herosMansion_HeroChangeNameWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[4] = new PropertyWatcher("heroMes", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[5] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
        }


    }
}//package 

