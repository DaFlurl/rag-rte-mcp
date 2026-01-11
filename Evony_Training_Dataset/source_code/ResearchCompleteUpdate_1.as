// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.ResearchCompleteUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class ResearchCompleteUpdate extends BaseBean 
    {

        public var castleId:int;
        public var level:int;
        public var typeId:int;

        public function ResearchCompleteUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.level != null)
            {
                this.level = _arg_2.level;
            };
            if (_arg_2.typeId != null)
            {
                this.typeId = _arg_2.typeId;
            };
        }

        public function copyTo(_arg_1:ResearchCompleteUpdate):void
        {
            _arg_1.castleId = this.castleId;
            _arg_1.level = this.level;
            _arg_1.typeId = this.typeId;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleId = this.castleId;
            _local_1.level = this.level;
            _local_1.typeId = this.typeId;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- ResearchCompleteUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            return (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
        }


    }
}//package com.evony.common.server.events

