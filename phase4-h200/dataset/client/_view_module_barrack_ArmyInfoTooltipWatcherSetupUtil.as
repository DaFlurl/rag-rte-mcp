// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_barrack_ArmyInfoTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.barrack.ArmyInfoTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_barrack_ArmyInfoTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyInfoTooltip.watcherSetupUtil = new (_view_module_barrack_ArmyInfoTooltipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("troopEum", {"propertyChange":true}, [_arg_3[17], _arg_3[15], _arg_3[13], _arg_3[9], _arg_3[11], _arg_3[1], _arg_3[3], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[16] = new PropertyWatcher("foodRequest", {"propertyChange":true}, [_arg_3[15]], null);
            _arg_4[12] = new PropertyWatcher("speed", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[14] = new PropertyWatcher("load", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[6] = new PropertyWatcher("attack", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[18] = new PropertyWatcher("population", {"propertyChange":true}, [_arg_3[17]], null);
            _arg_4[4] = new PropertyWatcher("life", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[8] = new PropertyWatcher("defence", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[2] = new PropertyWatcher("wikiDesc", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[10] = new PropertyWatcher("range", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[1] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[16]);
            _arg_4[0].addChild(_arg_4[12]);
            _arg_4[0].addChild(_arg_4[14]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[18]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[10]);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

