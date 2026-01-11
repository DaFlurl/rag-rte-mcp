// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CelebRankCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.celeb.CelebResponse;

    public class CelebRankCommands 
    {

        public var _findPlayerByStar_callback:Function;
        public var _findPlayerByPrestige_callback:Function;
        private var sender:Sender;
        public var _findAllianceByPrestige_callback:Function;
        public var _findPlayerByTitle_callback:Function;


        public function findPlayerByStar(_arg_1:int, _arg_2:Function=null):CelebResponse
        {
            this._findPlayerByStar_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("celeb.findPlayerByStar", {"starlv":_arg_1});
            };
            return (null);
        }

        public function findPlayerByTitle(_arg_1:String, _arg_2:Function=null):CelebResponse
        {
            this._findPlayerByTitle_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("celeb.findPlayerByTitle", {"title":_arg_1});
            };
            return (null);
        }

        public function findPlayerByPrestige(_arg_1:String, _arg_2:Function=null):CelebResponse
        {
            this._findPlayerByPrestige_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("celeb.findPlayerByPrestige", {"prestige":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function findAllianceByPrestige(_arg_1:String, _arg_2:Function=null):CelebResponse
        {
            this._findAllianceByPrestige_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("celeb.findAllianceByPrestige", {"prestige":_arg_1});
            };
            return (null);
        }


    }
}//package com.evony.client.action

