// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Items.ItemViewWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ItemViewWin.watcherSetupUtil = new (_autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("itemData", {"propertyChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2], _arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[12], _arg_3[14], _arg_3[15], _arg_3[17], _arg_3[16], _arg_3[19], _arg_3[21], _arg_3[23], _arg_3[22], _arg_3[25], _arg_3[24]], _arg_2);
            _arg_4[6] = new PropertyWatcher("id", {"propertyChange":true}, [_arg_3[17], _arg_3[16], _arg_3[19], _arg_3[2], _arg_3[21], _arg_3[23], _arg_3[8], _arg_3[12], _arg_3[15]], null);
            _arg_4[11] = new PropertyWatcher("desc", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[8] = new PropertyWatcher("price", {"propertyChange":true}, [_arg_3[3], _arg_3[4], _arg_3[5]], null);
            _arg_4[10] = new PropertyWatcher("count", {"propertyChange":true}, [_arg_3[3], _arg_3[22], _arg_3[25], _arg_3[24], _arg_3[14]], null);
            _arg_4[5] = new PropertyWatcher("itemType", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[3] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[2] = new PropertyWatcher("iconUrl", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[12] = new PropertyWatcher("itemDesc", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[26] = new PropertyWatcher("zoneInfo", {"propertyChange":true}, [_arg_3[18]], _arg_2);
            _arg_4[28] = new PropertyWatcher("disappearHeros", {"propertyChange":true}, [_arg_3[20], _arg_3[22]], _arg_2);
            _arg_4[31] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[22]], null);
            _arg_4[14] = new PropertyWatcher("_zone_Select", {"propertyChange":true}, [_arg_3[8], _arg_3[9], _arg_3[10], _arg_3[11]], _arg_2);
            _arg_4[15] = new PropertyWatcher("selectedIndex", {
                "valueCommit":true,
                "collectionChange":true,
                "change":true
            }, [_arg_3[8], _arg_3[9], _arg_3[10], _arg_3[11]], null);
            _arg_4[16] = new PropertyWatcher("selectedItem", {
                "valueCommit":true,
                "collectionChange":true,
                "change":true
            }, [_arg_3[9], _arg_3[10], _arg_3[11]], null);
            _arg_4[17] = new PropertyWatcher("data", null, [_arg_3[9], _arg_3[10], _arg_3[11]], null);
            _arg_4[20] = new PropertyWatcher("rate", null, [_arg_3[11]], null);
            _arg_4[19] = new PropertyWatcher("castleCount", null, [_arg_3[10]], null);
            _arg_4[18] = new PropertyWatcher("playerCount", null, [_arg_3[9]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[6]);
            _arg_4[1].addChild(_arg_4[11]);
            _arg_4[1].addChild(_arg_4[8]);
            _arg_4[1].addChild(_arg_4[10]);
            _arg_4[1].addChild(_arg_4[5]);
            _arg_4[1].addChild(_arg_4[3]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[12]);
            _arg_4[26].updateParent(_arg_1);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[28].addChild(_arg_4[31]);
            _arg_4[14].updateParent(_arg_1);
            _arg_4[14].addChild(_arg_4[15]);
            _arg_4[14].addChild(_arg_4[16]);
            _arg_4[16].addChild(_arg_4[17]);
            _arg_4[17].addChild(_arg_4[20]);
            _arg_4[17].addChild(_arg_4[19]);
            _arg_4[17].addChild(_arg_4[18]);
        }


    }
}//package 

