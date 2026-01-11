// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CastleSignCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.castle.CastleSignResponse;

    public class CastleSignCommand 
    {

        internal var sender:Sender;
        public var _saveCastleSignList_callback:Function;
        public var _deleteCastleSign_callback:Function;


        public function deleteCastleSign(_arg_1:int, _arg_2:Function=null):CastleSignResponse
        {
            this._deleteCastleSign_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.deleteCastleSign", {"id":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function saveCastleSignList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CastleSignResponse
        {
            this._saveCastleSignList_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.saveCastleSignList", {
                    "id":_arg_1,
                    "x":_arg_2,
                    "y":_arg_3
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

