// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_friendList_FriendListWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.friendList.FriendList;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_friendList_FriendListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            FriendList.watcherSetupUtil = new (_view_module_friendList_FriendListWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[12] = new PropertyWatcher("eachPageBlockArr", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[5] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[6], _arg_3[5]], _arg_2);
            _arg_4[7] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[8] = new PropertyWatcher("eachPageFriendArr", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[6] = new PropertyWatcher("curPage", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
        }


    }
}//package 

