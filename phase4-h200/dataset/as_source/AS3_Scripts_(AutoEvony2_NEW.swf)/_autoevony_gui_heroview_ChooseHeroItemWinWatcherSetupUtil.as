// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_heroview_ChooseHeroItemWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.heroview.ChooseHeroItemWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import autoevony.common.Items;

    public class _autoevony_gui_heroview_ChooseHeroItemWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ChooseHeroItemWin.watcherSetupUtil = new (_autoevony_gui_heroview_ChooseHeroItemWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[9] = new PropertyWatcher("itemSelectInfo", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[3] = new FunctionReturnWatcher("getItemEumById", target, function ():Array
            {
                return ([target._itemSelect.selectedItem.data]);
            }, null, [bindings[0]], null);
            watchers[4] = new PropertyWatcher("desc", {"propertyChange":true}, [bindings[0]], null);
            watchers[5] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[0] = new PropertyWatcher("_itemSelect", {"propertyChange":true}, [bindings[0], bindings[1], bindings[2], bindings[4]], propertyGetter);
            watchers[1] = new PropertyWatcher("selectedItem", {
                "valueCommit":true,
                "collectionChange":true,
                "change":true
            }, [bindings[0], bindings[1], bindings[2], bindings[4]], null);
            watchers[2] = new PropertyWatcher("data", null, [bindings[0], bindings[1], bindings[2], bindings[4]], null);
            watchers[6] = new FunctionReturnWatcher("getItemEumById", target, function ():Array
            {
                return ([target._itemSelect.selectedItem.data]);
            }, null, [bindings[1]], null);
            watchers[7] = new PropertyWatcher("itemDesc", {"propertyChange":true}, [bindings[1]], null);
            watchers[9].updateParent(target);
            watchers[3].updateParent(Items);
            watchers[3].addChild(watchers[4]);
            watchers[5].updateParent(target);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[1]);
            watchers[1].addChild(watchers[2]);
            watchers[6].updateParent(Items);
            watchers[6].addChild(watchers[7]);
        }


    }
}//package 

