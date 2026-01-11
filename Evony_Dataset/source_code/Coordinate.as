// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.Coordinate

package com.evony
{
    public class Coordinate 
    {

        public var x:int;
        public var y:int;

        public function Coordinate(_arg_1:int)
        {
            this.x = (_arg_1 % Context.mapSizeX);
            this.y = (_arg_1 / Context.mapSizeX);
        }

    }
}//package com.evony

