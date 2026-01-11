// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.WorldEvent

package view.castle.world
{
    import flash.events.Event;

    public class WorldEvent extends Event 
    {

        public static const EVENT_MSG:String = "event.msg";

        public var mapTile:Tile;

        public function WorldEvent(_arg_1:String, _arg_2:Tile)
        {
            super(_arg_1, false, false);
            this.mapTile = _arg_2;
        }

    }
}//package view.castle.world

