// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.MouseManager

package com.evony.common
{
    import mx.managers.CursorManager;
    import flash.ui.Mouse;

    public class MouseManager 
    {

        private static var isBusy:Boolean = false;


        public static function setNormal():void
        {
            if (isBusy)
            {
                try
                {
                    isBusy = false;
                    CursorManager.removeBusyCursor();
                }
                catch(e:Error)
                {
                    Mouse.show();
                };
            };
        }

        public static function setBusy():void
        {
            if (!isBusy)
            {
                try
                {
                    isBusy = true;
                    CursorManager.setBusyCursor();
                }
                catch(e:Error)
                {
                    Mouse.show();
                };
            };
        }


    }
}//package com.evony.common

