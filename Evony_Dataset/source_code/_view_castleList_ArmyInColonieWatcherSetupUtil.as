// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_ArmyInColonieWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.ArmyInColonie;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castleList_ArmyInColonieWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyInColonie.watcherSetupUtil = new (_view_castleList_ArmyInColonieWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[7] = new PropertyWatcher("showItem", {"propertyChange":true}, [_arg_3[34], _arg_3[30], _arg_3[26], _arg_3[38], _arg_3[6], _arg_3[50], _arg_3[18], _arg_3[46], _arg_3[14], _arg_3[42], _arg_3[10], _arg_3[22]], _arg_2);
            _arg_4[8] = new PropertyWatcher("addHandle", {"propertyChange":true}, [_arg_3[47], _arg_3[15], _arg_3[51], _arg_3[19], _arg_3[23], _arg_3[43], _arg_3[11], _arg_3[31], _arg_3[35], _arg_3[39], _arg_3[7], _arg_3[27]], _arg_2);
            _arg_4[0] = new PropertyWatcher("reduceEnable", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("tooltips", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[5] = new PropertyWatcher("troop", {"propertyChange":true}, [_arg_3[45], _arg_3[17], _arg_3[41], _arg_3[13], _arg_3[9], _arg_3[33], _arg_3[21], _arg_3[29], _arg_3[37], _arg_3[25], _arg_3[49], _arg_3[5]], _arg_2);
            _arg_4[12] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[22] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[33]], null);
            _arg_4[16] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[21]], null);
            _arg_4[26] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[41]], null);
            _arg_4[28] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[14] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[17]], null);
            _arg_4[30] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[49]], null);
            _arg_4[24] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[37]], null);
            _arg_4[18] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[25]], null);
            _arg_4[10] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[20] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[29]], null);
            _arg_4[6] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[12]);
            _arg_4[5].addChild(_arg_4[22]);
            _arg_4[5].addChild(_arg_4[16]);
            _arg_4[5].addChild(_arg_4[26]);
            _arg_4[5].addChild(_arg_4[28]);
            _arg_4[5].addChild(_arg_4[14]);
            _arg_4[5].addChild(_arg_4[30]);
            _arg_4[5].addChild(_arg_4[24]);
            _arg_4[5].addChild(_arg_4[18]);
            _arg_4[5].addChild(_arg_4[10]);
            _arg_4[5].addChild(_arg_4[20]);
            _arg_4[5].addChild(_arg_4[6]);
        }


    }
}//package 

