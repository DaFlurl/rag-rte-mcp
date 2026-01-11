// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_workshop_EquipStarWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.workshop.EquipStarWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_workshop_EquipStarWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            EquipStarWin.watcherSetupUtil = new (_view_module_workshop_EquipStarWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("levTxt", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[7] = new PropertyWatcher("width", {"widthChanged":true}, [_arg_3[3]], null);
            _arg_4[6] = new PropertyWatcher("x", {"xChanged":true}, [_arg_3[3]], null);
            _arg_4[16] = new PropertyWatcher("autoStarShow", {"propertyChange":true}, [_arg_3[18]], _arg_2);
            _arg_4[11] = new PropertyWatcher("starNumArr", {"propertyChange":true}, [_arg_3[13]], _arg_2);
            _arg_4[19] = new PropertyWatcher("equipImg", {"propertyChange":true}, [_arg_3[21]], _arg_2);
            _arg_4[15] = new PropertyWatcher("autoStarLevShow", {"propertyChange":true}, [_arg_3[17]], _arg_2);
            _arg_4[1] = new PropertyWatcher("equipTechBean", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[9], _arg_3[8], _arg_3[6], _arg_3[10], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("enhancedstarlv", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[9], _arg_3[8], _arg_3[6], _arg_3[10], _arg_3[7], _arg_3[5]], null);
            _arg_4[2] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[12] = new PropertyWatcher("starRateArr", {"propertyChange":true}, [_arg_3[14]], _arg_2);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[7]);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[19].updateParent(_arg_1);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[12].updateParent(_arg_1);
        }


    }
}//package 

