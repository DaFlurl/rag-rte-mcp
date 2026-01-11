// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_workshop_EquipmentTechItemUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.workshop.EquipmentTechItemUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_workshop_EquipmentTechItemUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            EquipmentTechItemUI.watcherSetupUtil = new (_view_module_workshop_EquipmentTechItemUIWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("researchBtnVisable", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[11] = new PropertyWatcher("itemName", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[4] = new PropertyWatcher("equipBean", {"propertyChange":true}, [_arg_3[4], _arg_3[8], _arg_3[6], _arg_3[5]], _arg_2);
            _arg_4[8] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[8], _arg_3[6]], null);
            _arg_4[7] = new PropertyWatcher("enhancedstarlv", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[9] = new PropertyWatcher("typeId", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[12] = new PropertyWatcher("avalevel", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[5] = new PropertyWatcher("endTime", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[3] = new PropertyWatcher("researchBtnEnable", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[0] = new PropertyWatcher("imgSource", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[8]);
            _arg_4[4].addChild(_arg_4[7]);
            _arg_4[4].addChild(_arg_4[9]);
            _arg_4[4].addChild(_arg_4[12]);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

