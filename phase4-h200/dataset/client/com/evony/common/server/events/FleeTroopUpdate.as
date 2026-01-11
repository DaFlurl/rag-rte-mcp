// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.FleeTroopUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.*;

    public class FleeTroopUpdate extends BaseBean 
    {

        public var troop:TroopBean;
        public var castleId:int;
        public var goldNeed:int;

        public function FleeTroopUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.goldNeed != null)
            {
                this.goldNeed = _arg_2.goldNeed;
            };
            if (_arg_2.troop != null)
            {
                this.troop = new TroopBean(_arg_2.troop);
            };
        }

        public function copyTo(_arg_1:FleeTroopUpdate):void
        {
            _arg_1.castleId = this.castleId;
            _arg_1.goldNeed = this.goldNeed;
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
            _local_1.castleId = this.castleId;
            _local_1.goldNeed = this.goldNeed;
            _local_1.troop = this.troop.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- FleeTroopUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "goldNeed = ") + this.goldNeed) + "\n"));
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

