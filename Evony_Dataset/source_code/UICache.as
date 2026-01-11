// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.UICache

package com.evony.util
{
    import flash.display.DisplayObject;

    public class UICache 
    {

        private var point:int = 0;
        private var size:int;
        private var cacheArray:Array;

        public function UICache(_arg_1:int)
        {
            this.size = _arg_1;
            this.cacheArray = new Array();
        }

        public function deleteAllChildren():void
        {
            this.cacheArray = new Array();
        }

        public function reset():void
        {
            this.point = 0;
        }

        public function getUI(_arg_1:Class):DisplayObject
        {
            point++;
            if (point > size)
            {
                point = 0;
            };
            if (this.cacheArray[point] == null)
            {
                this.cacheArray[point] = new (_arg_1)();
            };
            return (this.cacheArray[point]);
        }


    }
}//package com.evony.util

