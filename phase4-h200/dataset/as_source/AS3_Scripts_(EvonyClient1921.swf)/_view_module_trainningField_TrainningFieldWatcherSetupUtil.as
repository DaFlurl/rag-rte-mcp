// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_trainningField_TrainningFieldWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.trainningField.TrainningField;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_trainningField_TrainningFieldWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TrainningField.watcherSetupUtil = new (_view_module_trainningField_TrainningFieldWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[6] = new PropertyWatcher("isGoOut", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[8] = new PropertyWatcher("currentTroop", {"propertyChange":true}, [_arg_3[30], _arg_3[8], _arg_3[26], _arg_3[28], _arg_3[16], _arg_3[18], _arg_3[20], _arg_3[14], _arg_3[24], _arg_3[10], _arg_3[12], _arg_3[22]], _arg_2);
            _arg_4[13] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[23] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[17] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[27] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[26]], null);
            _arg_4[29] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[28]], null);
            _arg_4[15] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[31] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[30]], null);
            _arg_4[25] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[24]], null);
            _arg_4[19] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[18]], null);
            _arg_4[11] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[21] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[20]], null);
            _arg_4[9] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[0] = new PropertyWatcher("heroDataAry", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[8].addChild(_arg_4[13]);
            _arg_4[8].addChild(_arg_4[23]);
            _arg_4[8].addChild(_arg_4[17]);
            _arg_4[8].addChild(_arg_4[27]);
            _arg_4[8].addChild(_arg_4[29]);
            _arg_4[8].addChild(_arg_4[15]);
            _arg_4[8].addChild(_arg_4[31]);
            _arg_4[8].addChild(_arg_4[25]);
            _arg_4[8].addChild(_arg_4[19]);
            _arg_4[8].addChild(_arg_4[11]);
            _arg_4[8].addChild(_arg_4[21]);
            _arg_4[8].addChild(_arg_4[9]);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

