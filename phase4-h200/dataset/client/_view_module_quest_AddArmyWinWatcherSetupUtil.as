// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_quest_AddArmyWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.quest.AddArmyWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_quest_AddArmyWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AddArmyWin.watcherSetupUtil = new (_view_module_quest_AddArmyWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[4] = new PropertyWatcher("missionTypeSelectedIndex", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[26] = new PropertyWatcher("troops", {"propertyChange":true}, [_arg_3[45], _arg_3[51], _arg_3[36], _arg_3[30], _arg_3[33], _arg_3[21], _arg_3[48], _arg_3[42], _arg_3[24], _arg_3[39], _arg_3[54], _arg_3[27]], _arg_2);
            _arg_4[32] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[27]], null);
            _arg_4[42] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[42]], null);
            _arg_4[36] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[33]], null);
            _arg_4[46] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[48]], null);
            _arg_4[48] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[51]], null);
            _arg_4[34] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[30]], null);
            _arg_4[50] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[54]], null);
            _arg_4[44] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[38] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[36]], null);
            _arg_4[30] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[24]], null);
            _arg_4[40] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[39]], null);
            _arg_4[27] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[21]], null);
            _arg_4[6] = new PropertyWatcher("heros", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[10] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[13], _arg_3[11], _arg_3[14], _arg_3[10], _arg_3[12]], _arg_2);
            _arg_4[15] = new PropertyWatcher("stone", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[16] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[13] = new PropertyWatcher("wood", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[14] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[11] = new PropertyWatcher("food", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[12] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[17] = new PropertyWatcher("iron", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[18] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[19] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[28] = new PropertyWatcher("disCount", {"propertyChange":true}, [_arg_3[34], _arg_3[55], _arg_3[40], _arg_3[28], _arg_3[43], _arg_3[31], _arg_3[46], _arg_3[52], _arg_3[37], _arg_3[25], _arg_3[49], _arg_3[22]], _arg_2);
            _arg_4[3] = new PropertyWatcher("missionTypeArray", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[26].updateParent(_arg_1);
            _arg_4[26].addChild(_arg_4[32]);
            _arg_4[26].addChild(_arg_4[42]);
            _arg_4[26].addChild(_arg_4[36]);
            _arg_4[26].addChild(_arg_4[46]);
            _arg_4[26].addChild(_arg_4[48]);
            _arg_4[26].addChild(_arg_4[34]);
            _arg_4[26].addChild(_arg_4[50]);
            _arg_4[26].addChild(_arg_4[44]);
            _arg_4[26].addChild(_arg_4[38]);
            _arg_4[26].addChild(_arg_4[30]);
            _arg_4[26].addChild(_arg_4[40]);
            _arg_4[26].addChild(_arg_4[27]);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[10].addChild(_arg_4[15]);
            _arg_4[15].addChild(_arg_4[16]);
            _arg_4[10].addChild(_arg_4[13]);
            _arg_4[13].addChild(_arg_4[14]);
            _arg_4[10].addChild(_arg_4[11]);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[10].addChild(_arg_4[17]);
            _arg_4[17].addChild(_arg_4[18]);
            _arg_4[10].addChild(_arg_4[19]);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
        }


    }
}//package 

