// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_CurFieldViewWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.CurFieldView;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_office_CurFieldViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CurFieldView.watcherSetupUtil = new (_view_module_office_CurFieldViewWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("armyArr", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[13] = new PropertyWatcher("hasTrainingField", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[2] = new PropertyWatcher("fieldL", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[12] = new PropertyWatcher("isCanSend", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[0] = new PropertyWatcher("fieldBean", {"propertyChange":true}, [_arg_3[8], _arg_3[0]], _arg_2);
            _arg_4[10] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[1] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[14] = new PropertyWatcher("hasTrainingFieldTooltip", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[10]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[14].updateParent(_arg_1);
        }


    }
}//package 

