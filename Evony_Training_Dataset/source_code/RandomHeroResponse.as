// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.hero.RandomHeroResponse

package com.evony.common.module.hero
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.RandomHeroBean;

    public class RandomHeroResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var randomherobean:RandomHeroBean;
        public var errorMsg:String;
        public var ok:int;

        public function RandomHeroResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
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
            if (_arg_2.randomherobean != null)
            {
                this.randomherobean = new RandomHeroBean(_arg_2.randomherobean);
            };
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "randomherobean":this.randomherobean.toObject()
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- RandomHeroResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + ((this.randomherobean == null) ? (_arg_1 + "randomherobean = null\n") : this.randomherobean.toDebugString((_arg_1 + "randomherobean."))));
        }

        public function copyTo(_arg_1:RandomHeroResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.randomherobean == null)
            {
                _arg_1.randomherobean = null;
            }
            else
            {
                this.randomherobean.copyTo(_arg_1.randomherobean);
            };
        }


    }
}//package com.evony.common.module.hero

