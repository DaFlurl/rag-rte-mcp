// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.StratagemCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;

    public class StratagemCommands 
    {

        private var sender:Sender;
        public var _useStratagem_callback:Function;


        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function useStratagem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._useStratagem_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("stratagem.useStratagem", {
                    "castleId":_arg_1,
                    "heroId":_arg_2,
                    "straId":_arg_3
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

