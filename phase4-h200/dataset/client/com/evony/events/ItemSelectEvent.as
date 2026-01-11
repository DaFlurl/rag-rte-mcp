// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.ItemSelectEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.eum.ItemEum;

    public class ItemSelectEvent extends Event 
    {

        public static const NAME:String = "ItemSelectEvent";

        public var item:ItemEum;

        public function ItemSelectEvent(_arg_1:ItemEum, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(NAME, _arg_2, _arg_3);
            this.item = _arg_1;
        }

    }
}//package com.evony.events

