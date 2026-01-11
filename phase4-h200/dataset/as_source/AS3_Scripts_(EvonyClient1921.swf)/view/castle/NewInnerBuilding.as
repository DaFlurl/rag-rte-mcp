// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.NewInnerBuilding

package view.castle
{
    import com.evony.Lang;
    import com.evony.MsgDispacther;
    import flash.events.Event;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import com.evony.client.response.ResponseDispatcher;

    public class NewInnerBuilding extends BaseNewBuildingWin 
    {

        public static const EVENT_SHOW:String = "NewInnerBuilding.show";

        public function NewInnerBuilding()
        {
            this.title = Lang.msg("建筑建造（城内）");
        }

        override protected function checkGuideText():void
        {
            MsgDispacther.getInstance().dispatchEvent(new Event("cityInNewBuilding"));
        }

        override public function sendCommand():void
        {
            ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(Context.getInstance().getCurCastle().id);
        }

        override public function getListeEventName():String
        {
            return (ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE);
        }


    }
}//package view.castle

