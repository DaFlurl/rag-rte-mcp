// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.hero.HeroResponse

package com.evony.common.module.hero
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.beans.*;

    public class HeroResponse extends BaseBean 
    {

        public static const NO_CASTLE_FOUND:int = -1;
        public static const NO_HERO_FOUND:int = -2;
        public static const HERO_IN_USE:int = -3;
        public static const INVALID_NAME:int = -4;
        public static const NO_HERO_MANSION:int = -5;
        public static const NO_POSITION_FOR_HERO_:int = -6;
        public static const NO_TAVERN:int = -7;
        public static const NOT_ENOUGH_GOLD_HIRE_HERO:int = -8;
        public static const NOT_ENOUGH_GOLD_AWARD_HERO:int = -9;
        public static const INVALID_ADD_POINT:int = -10;
        public static const FREE_HERO_STATUS:int = 0;
        public static const CHIEF_HERO_STATUS:int = 1;
        public static const GUARD_HERO_STATUS:int = 2;

        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var hero:HeroBean;
        public var ok:int;

        public function HeroResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.hero != null)
            {
                this.hero = new HeroBean(_arg_2.hero);
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.hero = this.hero.toObject();
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- HeroResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            if (hero != null)
            {
                _local_2 = (_local_2 + this.hero.toDebugString((_arg_1 + "hero.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "hero = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            return (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:HeroResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            if (hero != null)
            {
                this.hero.copyTo(_arg_1.hero);
            }
            else
            {
                _arg_1.hero = null;
            };
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }


    }
}//package com.evony.common.module.hero

