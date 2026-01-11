// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.NewWallBuilding

package view.castle
{
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.response.ResponseDispatcher;

    public class NewWallBuilding extends BaseNewBuildingWin 
    {

        public static const EVENT_SHOW:String = "NewWallBuilding.open";

        public function NewWallBuilding()
        {
            this.title = Lang.msg("新建城墙");
        }

        override public function sendCommand():void
        {
            ActionFactory.getInstance().getCastleCommands().getAvailableBuildingBean(Context.getInstance().getCurCastle().id, BuildingConstants.TYPE_WALL);
        }

        override public function getListeEventName():String
        {
            return (ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_BEAN);
        }


    }
}//package view.castle

