// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_ColonyAllArmyWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.ColonyAllArmy;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_ColonyAllArmyWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonyAllArmy.watcherSetupUtil = new (_view_castleList_ColonyAllArmyWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("_troop", {"propertyChange":true}, [_arg_3[34], _arg_3[13], _arg_3[4], _arg_3[19], _arg_3[28], _arg_3[31], _arg_3[16], _arg_3[37], _arg_3[25], _arg_3[10], _arg_3[7], _arg_3[22]], _arg_2);
            _arg_4[14] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[34] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[25]], null);
            _arg_4[22] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[42] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[31]], null);
            _arg_4[46] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[34]], null);
            _arg_4[18] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[50] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[37]], null);
            _arg_4[38] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[28]], null);
            _arg_4[26] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[10] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[30] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[6] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[14]);
            _arg_4[5].addChild(_arg_4[34]);
            _arg_4[5].addChild(_arg_4[22]);
            _arg_4[5].addChild(_arg_4[42]);
            _arg_4[5].addChild(_arg_4[46]);
            _arg_4[5].addChild(_arg_4[18]);
            _arg_4[5].addChild(_arg_4[50]);
            _arg_4[5].addChild(_arg_4[38]);
            _arg_4[5].addChild(_arg_4[26]);
            _arg_4[5].addChild(_arg_4[10]);
            _arg_4[5].addChild(_arg_4[30]);
            _arg_4[5].addChild(_arg_4[6]);
        }


    }
}//package 

