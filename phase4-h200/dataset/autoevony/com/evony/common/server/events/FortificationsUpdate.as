// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.FortificationsUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.FortificationsBean;

    public class FortificationsUpdate extends BaseBean 
    {

        public var fortification:FortificationsBean;
        public var castleId:int;

        public function FortificationsUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.fortification != null)
            {
                this.fortification = new FortificationsBean(_arg_2.fortification);
            };
        }

        public function copyTo(_arg_1:FortificationsUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (this.fortification != null)
            {
                this.fortification.copyTo(_arg_1.fortification);
            }
            else
            {
                _arg_1.fortification = null;
            };
        }

        public function toObject():Object
        {
            return ({
                "castleId":this.castleId,
                "fortification":this.fortification.toObject()
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (("---- FortificationsUpdate ----\n" + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + ((this.fortification != null) ? this.fortification.toDebugString((_arg_1 + "fortification.")) : (_arg_1 + "fortification = null\n")));
        }


    }
}//package com.evony.common.server.events

