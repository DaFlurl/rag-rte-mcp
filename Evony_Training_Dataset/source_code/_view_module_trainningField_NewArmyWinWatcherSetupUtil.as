// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_trainningField_NewArmyWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.trainningField.NewArmyWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_trainningField_NewArmyWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            NewArmyWin.watcherSetupUtil = new (_view_module_trainningField_NewArmyWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[61] = new PropertyWatcher("setTroopArray", {"propertyChange":true}, [_arg_3[96]], _arg_2);
            _arg_4[8] = new PropertyWatcher("missionTypeSelectedIndex", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[33] = new PropertyWatcher("troops", {"propertyChange":true}, [_arg_3[41], _arg_3[51], _arg_3[36], _arg_3[61], _arg_3[46], _arg_3[91], _arg_3[66], _arg_3[81], _arg_3[76], _arg_3[56], _arg_3[86], _arg_3[71]], _arg_2);
            _arg_4[41] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[46]], null);
            _arg_4[51] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[71]], null);
            _arg_4[45] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[56]], null);
            _arg_4[55] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[81]], null);
            _arg_4[57] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[86]], null);
            _arg_4[43] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[51]], null);
            _arg_4[59] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[91]], null);
            _arg_4[53] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[76]], null);
            _arg_4[47] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[61]], null);
            _arg_4[39] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[41]], null);
            _arg_4[49] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[66]], null);
            _arg_4[34] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[36]], null);
            _arg_4[35] = new PropertyWatcher("troopCanAdd", {"propertyChange":true}, [_arg_3[47], _arg_3[62], _arg_3[82], _arg_3[87], _arg_3[72], _arg_3[67], _arg_3[77], _arg_3[109], _arg_3[92], _arg_3[57], _arg_3[52], _arg_3[37], _arg_3[42]], _arg_2);
            _arg_4[10] = new PropertyWatcher("heros", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[17] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[19], _arg_3[16], _arg_3[25], _arg_3[22]], _arg_2);
            _arg_4[20] = new PropertyWatcher("stone", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[21] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[18] = new PropertyWatcher("wood", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[19] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[22] = new PropertyWatcher("iron", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[23] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[24] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[25]], null);
            _arg_4[15] = new PropertyWatcher("leftSpace", {"propertyChange":true}, [_arg_3[17], _arg_3[26], _arg_3[23], _arg_3[20], _arg_3[14], _arg_3[108]], _arg_2);
            _arg_4[14] = new PropertyWatcher("leftFood", {"propertyChange":true}, [_arg_3[13]], _arg_2);
            _arg_4[71] = new PropertyWatcher("needFood", {"propertyChange":true}, [_arg_3[106]], _arg_2);
            _arg_4[2] = new PropertyWatcher("newArmyData", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("y", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[3] = new PropertyWatcher("x", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[37] = new PropertyWatcher("disCount", {"propertyChange":true}, [_arg_3[64], _arg_3[94], _arg_3[79], _arg_3[89], _arg_3[74], _arg_3[84], _arg_3[39], _arg_3[54], _arg_3[49], _arg_3[69], _arg_3[59], _arg_3[44]], _arg_2);
            _arg_4[68] = new PropertyWatcher("reachTime", {"propertyChange":true}, [_arg_3[103]], _arg_2);
            _arg_4[66] = new PropertyWatcher("needTimeStr", {"propertyChange":true}, [_arg_3[101]], _arg_2);
            _arg_4[62] = new PropertyWatcher("setBtnEnable", {"propertyChange":true}, [_arg_3[97]], _arg_2);
            _arg_4[7] = new PropertyWatcher("missionTypeArray", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[61].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[33].updateParent(_arg_1);
            _arg_4[33].addChild(_arg_4[41]);
            _arg_4[33].addChild(_arg_4[51]);
            _arg_4[33].addChild(_arg_4[45]);
            _arg_4[33].addChild(_arg_4[55]);
            _arg_4[33].addChild(_arg_4[57]);
            _arg_4[33].addChild(_arg_4[43]);
            _arg_4[33].addChild(_arg_4[59]);
            _arg_4[33].addChild(_arg_4[53]);
            _arg_4[33].addChild(_arg_4[47]);
            _arg_4[33].addChild(_arg_4[39]);
            _arg_4[33].addChild(_arg_4[49]);
            _arg_4[33].addChild(_arg_4[34]);
            _arg_4[35].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[17].updateParent(_arg_1);
            _arg_4[17].addChild(_arg_4[20]);
            _arg_4[20].addChild(_arg_4[21]);
            _arg_4[17].addChild(_arg_4[18]);
            _arg_4[18].addChild(_arg_4[19]);
            _arg_4[17].addChild(_arg_4[22]);
            _arg_4[22].addChild(_arg_4[23]);
            _arg_4[17].addChild(_arg_4[24]);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[14].updateParent(_arg_1);
            _arg_4[71].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[4]);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[37].updateParent(_arg_1);
            _arg_4[68].updateParent(_arg_1);
            _arg_4[66].updateParent(_arg_1);
            _arg_4[62].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

