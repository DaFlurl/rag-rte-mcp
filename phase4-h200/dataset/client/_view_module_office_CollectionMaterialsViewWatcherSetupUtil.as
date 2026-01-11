// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_CollectionMaterialsViewWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.CollectionMaterialsView;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_office_CollectionMaterialsViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CollectionMaterialsView.watcherSetupUtil = new (_view_module_office_CollectionMaterialsViewWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[7] = new PropertyWatcher("comData", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[3] = new PropertyWatcher("curCastle", {"propertyChange":true}, [_arg_3[4], _arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[4], _arg_3[3]], null);
            _arg_4[5] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[6] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[4].addChild(_arg_4[6]);
        }


    }
}//package 

