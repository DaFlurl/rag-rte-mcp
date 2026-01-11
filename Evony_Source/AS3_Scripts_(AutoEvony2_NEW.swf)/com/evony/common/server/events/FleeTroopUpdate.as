// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.FleeTroopUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TroopBean;

    public class FleeTroopUpdate extends BaseBean 
    {

        public var troop:TroopBean;
        public var castleId:int;
        public var goldNeed:int;

        public function FleeTroopUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
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
            if (this.troop != null)
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
            return ({
                "castleId":this.castleId,
                "goldNeed":this.goldNeed,
                "troop":this.troop.toObject()
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- FleeTroopUpdate ----\n" + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + (((_arg_1 + "goldNeed = ") + this.goldNeed) + "\n")) + ((this.troop != null) ? this.troop.toDebugString((_arg_1 + "troop.")) : (_arg_1 + "troop = null\n")));
        }


    }
}//package com.evony.common.server.events

