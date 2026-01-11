// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.HeroUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.beans.*;

    public class HeroUpdate extends BaseBean 
    {

        public var castleId:int;
        public var hero:HeroBean;
        public var updateType:int;

        public function HeroUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.hero != null)
            {
                this.hero = new HeroBean(_arg_2.hero);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:HeroUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (hero != null)
            {
                this.hero.copyTo(_arg_1.hero);
            }
            else
            {
                _arg_1.hero = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleId = this.castleId;
            _local_1.hero = this.hero.toObject();
            _local_1.updateType = this.updateType;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- HeroUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            if (hero != null)
            {
                _local_2 = (_local_2 + this.hero.toDebugString((_arg_1 + "hero.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "hero = null\n"));
            };
            return (_local_2 + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

