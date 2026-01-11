// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.ReScriptObjectProxy

package autoevony.scripts
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public dynamic class ReScriptObjectProxy extends Proxy 
    {

        private var obj:Object = null;
        private var tempObj:Object = null;

        public function ReScriptObjectProxy(_arg_1:Object=null)
        {
            this.obj = ((_arg_1 == null) ? new Object() : _arg_1);
            this.tempObj = new Object();
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            this.obj[_arg_1].apply(this.obj, _args);
        }

        public function clearTempProperties():void
        {
            this.tempObj = new Object();
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            if (this.obj[_arg_1] != undefined)
            {
                this.obj[_arg_1] = _arg_2;
            }
            else
            {
                this.tempObj[_arg_1] = _arg_2;
            };
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            if (this.obj[_arg_1] != undefined)
            {
                return (this.obj[_arg_1]);
            };
            if (((!(this.tempObj == null)) && (!(this.tempObj[_arg_1] == undefined))))
            {
                return (this.tempObj[_arg_1]);
            };
            return (undefined);
        }

        override flash_proxy function hasProperty(_arg_1:*):Boolean
        {
            if (this.obj[_arg_1] != undefined)
            {
                return (true);
            };
            if (((!(this.tempObj == null)) && (!(this.tempObj[_arg_1] == undefined))))
            {
                return (true);
            };
            return (false);
        }


    }
}//package autoevony.scripts

