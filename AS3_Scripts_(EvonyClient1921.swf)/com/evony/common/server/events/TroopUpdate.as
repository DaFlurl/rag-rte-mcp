// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.TroopUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.*;

    public class TroopUpdate extends BaseBean 
    {

        public var troop:TroopBean;
        public var caslteId:int;

        public function TroopUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.caslteId != null)
            {
                this.caslteId = _arg_2.caslteId;
            };
            if (_arg_2.troop != null)
            {
                this.troop = new TroopBean(_arg_2.troop);
            };
        }

        public function copyTo(_arg_1:TroopUpdate):void
        {
            _arg_1.caslteId = this.caslteId;
            if (troop != null)
            {
                this.troop.copyTo(_arg_1.troop);
            }
            else
            {
                _arg_1.troop = null;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.caslteId = this.caslteId;
            _local_1.troop = this.troop.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- TroopUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "caslteId = ") + this.caslteId) + "\n"));
            if (troop != null)
            {
                _local_2 = (_local_2 + this.troop.toDebugString((_arg_1 + "troop.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "troop = null\n"));
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

