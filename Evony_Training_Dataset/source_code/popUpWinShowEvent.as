// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.popUpWinShowEvent

package autoevony.event
{
    import flash.events.Event;
    import mx.collections.ArrayCollection;

    public class popUpWinShowEvent extends Event 
    {

        public static const POP_UP_WIN_SHOW:String = "popUpWin.show";
        public static const ALERT_WIN:int = 0;
        public static const ARMY_DETAILS_WIN:int = 1;
        public static const TRAINING_FIELD_WIN:int = 2;
        public static const HERO_MANAGEMENT_WIN:int = 10;
        public static const HERO_DESC_WIN:int = 11;
        public static const HERO_APPLY_ITEM_WIN:int = 12;
        public static const ALLIANCE_INFO_WIN:int = 20;
        public static const ALLIANCE_MEMBER_INFO:int = 21;
        public static const ALLIANCE_CHANGE_HOST:int = 22;
        public static const ALLIANCE_EXPEL_MEMBER:int = 23;
        public static const ALLIANCE_INVITE_MEMBER:int = 24;
        public static const ALLIANCE_PENDING_APPLICATIONS:int = 25;
        public static const ALLIANCE_EDIT_INTRO:int = 26;
        public static const VIEW_ITEM_INFO_WIN:int = 30;
        public static const BUY_ITEM_WIN:int = 31;

        public var yesBtnName:String = null;
        public var msg:String = null;
        public var callBack:Function = null;
        public var popUpType:int;
        public var noBtnName:String = null;
        public var membersArray:ArrayCollection = null;
        public var parentObj:* = null;
        public var objParam:Object = null;
        public var winTitle:String = null;
        public var args:Array = null;

        public function popUpWinShowEvent(_arg_1:int=0, _arg_2:String="", _arg_3:Function=null, _arg_4:String="OK", _arg_5:String="Cancel", _arg_6:Array=null, _arg_7:String=null)
        {
            super(POP_UP_WIN_SHOW, true);
            this.popUpType = _arg_1;
            this.winTitle = _arg_7;
            this.msg = _arg_2;
            this.yesBtnName = _arg_4;
            this.noBtnName = _arg_5;
            this.callBack = _arg_3;
            this.args = _arg_6;
        }

    }
}//package autoevony.event

