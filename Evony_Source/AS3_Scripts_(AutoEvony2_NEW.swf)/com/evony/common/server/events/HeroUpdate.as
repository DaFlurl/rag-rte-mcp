// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.HeroUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.HeroBean;

    public class HeroUpdate extends BaseBean 
    {

        public var updateType:int;
        public var castleId:int;
        public var hero:HeroBean;

        public function HeroUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
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
            if (this.hero != null)
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
            return ({
                "castleId":this.castleId,
                "hero":this.hero.toObject(),
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- HeroUpdate ----\n" + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + ((this.hero != null) ? this.hero.toDebugString((_arg_1 + "hero.")) : (_arg_1 + "hero = null\n"))) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

