// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.TransingTradeUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TransingTradeBean;

    public class TransingTradeUpdate extends BaseBean 
    {

        public var bean:TransingTradeBean;
        public var updateType:int;
        public var castleId:int;

        public function TransingTradeUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.bean != null)
            {
                this.bean = new TransingTradeBean(_arg_2.bean);
            };
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function toObject():Object
        {
            return ({
                "bean":this.bean.toObject(),
                "castleId":this.castleId,
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- TransingTradeUpdate ----\n" + ((this.bean != null) ? this.bean.toDebugString((_arg_1 + "bean.")) : (_arg_1 + "bean = null\n"))) + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }

        public function copyTo(_arg_1:TransingTradeUpdate):void
        {
            if (this.bean != null)
            {
                this.bean.copyTo(_arg_1.bean);
            }
            else
            {
                _arg_1.bean = null;
            };
            _arg_1.castleId = this.castleId;
            _arg_1.updateType = this.updateType;
        }


    }
}//package com.evony.common.server.events

