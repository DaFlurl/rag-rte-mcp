// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.EvonyImage

package com.evony.util
{
    import mx.core.UIComponent;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class EvonyImage extends UIComponent 
    {

        public static const LOAD_COMPLETED:String = "LoadCompleted";

        private var _smoothing:Boolean = true;
        private var _bm:Bitmap = null;


        public function set source(_arg_1:Object):void
        {
            var _local_2:Array = _arg_1.split("@");
            var _local_3:int = ((_local_2[2] != null) ? int(_local_2[2]) : 0);
            var _local_4:String = ((_local_2[1] != null) ? _local_2[1] : "");
            var _local_5:String = _local_2[0];
            if (((!(_local_5 == null)) && (!(_local_5 == ""))))
            {
                ResourceLoader.loadResource(_local_5, _local_4, onLoaded, _local_3);
            };
        }

        public function set smoothing(_arg_1:Boolean):void
        {
            _smoothing = _arg_1;
        }

        private function onLoaded(_arg_1:Bitmap):void
        {
            if (_bm != null)
            {
                this.removeChild(_bm);
            };
            _bm = _arg_1;
            if (_bm != null)
            {
                _bm.smoothing = this._smoothing;
                if (((this.width == 0) || (this.height == 0)))
                {
                    this.width = _bm.width;
                    this.height = _bm.height;
                }
                else
                {
                    _bm.width = this.width;
                    _bm.height = this.height;
                };
                _bm.x = 0;
                _bm.y = 0;
                this.addChild(_bm);
            };
            this.dispatchEvent(new Event(EvonyImage.LOAD_COMPLETED));
        }

        public function getBitmap():Bitmap
        {
            return (this._bm);
        }

        public function set imgWidth(_arg_1:Number):void
        {
            _bm.width = _arg_1;
        }


    }
}//package com.evony.util

