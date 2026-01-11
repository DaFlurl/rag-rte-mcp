// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.serialization.json.JSON

package com.adobe.serialization.json
{
    public class JSON 
    {


        public static function decode(_arg_1:String, _arg_2:Boolean=true):*
        {
            return (new JSONDecoder(_arg_1, _arg_2).getValue());
        }

        public static function encode(_arg_1:Object):String
        {
            return (new JSONEncoder(_arg_1).getString());
        }


    }
}//package com.adobe.serialization.json

