// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.ImageSmooth

package com.evony.util
{
    import mx.core.BitmapAsset;
    import flash.display.Bitmap;
    import flash.events.Event;
    import mx.events.FlexEvent;

    public class ImageSmooth 
    {


        public static function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                if ((_arg_1.currentTarget.content is BitmapAsset))
                {
                    BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
                }
                else
                {
                    Bitmap(_arg_1.currentTarget.content).smoothing = true;
                };
            };
        }

        public static function onCreationComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                if ((_arg_1.currentTarget.content is BitmapAsset))
                {
                    BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
                }
                else
                {
                    if ((_arg_1.currentTarget.content is Bitmap))
                    {
                        Bitmap(_arg_1.currentTarget.content).smoothing = true;
                    };
                };
            };
        }


    }
}//package com.evony.util

