// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.TradesUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TradeBean;

    public class TradesUpdate extends BaseBean 
    {

        public var updateType:int;
        public var tradeBean:TradeBean;
        public var castleId:int;

        public function TradesUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.tradeBean != null)
            {
                this.tradeBean = new TradeBean(_arg_2.tradeBean);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:TradesUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (this.tradeBean != null)
            {
                this.tradeBean.copyTo(_arg_1.tradeBean);
            }
            else
            {
                _arg_1.tradeBean = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            return ({
                "castleId":this.castleId,
                "tradeBean":this.tradeBean.toObject(),
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- TradesUpdate ----\n" + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + ((this.tradeBean != null) ? this.tradeBean.toDebugString((_arg_1 + "tradeBean.")) : (_arg_1 + "tradeBean = null\n"))) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

