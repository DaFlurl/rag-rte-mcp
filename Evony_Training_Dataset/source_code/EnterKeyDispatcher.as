// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.EnterKeyDispatcher

package com.evony.util
{
    public class EnterKeyDispatcher 
    {

        public static var instance:EnterKeyDispatcher = new (EnterKeyDispatcher)();

        public var isEnterKey:Boolean = true;


        public function onEnterKeyEvent():void
        {
            instance.isEnterKey = true;
        }

        public function offEnterKeyEvent():void
        {
            instance.isEnterKey = false;
        }


    }
}//package com.evony.util

