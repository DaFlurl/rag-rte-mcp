// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.EmbeddedFont

package mx.core
{
    public class EmbeddedFont 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _fontName:String;
        private var _fontStyle:String;

        public function EmbeddedFont(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean)
        {
            _fontName = _arg_1;
            _fontStyle = EmbeddedFontRegistry.getFontStyle(_arg_2, _arg_3);
        }

        public function get fontStyle():String
        {
            return (_fontStyle);
        }

        public function get fontName():String
        {
            return (_fontName);
        }


    }
}//package mx.core

