// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.buttonBarClasses.ButtonBarButton

package mx.controls.buttonBarClasses
{
    import mx.controls.Button;
    import mx.core.UITextFormat;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ButtonBarButton extends Button 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var inLayoutContents:Boolean = false;


        override mx_internal function layoutContents(_arg_1:Number, _arg_2:Number, _arg_3:Boolean):void
        {
            inLayoutContents = true;
            super.layoutContents(_arg_1, _arg_2, _arg_3);
            inLayoutContents = false;
        }

        override public function determineTextFormatFromStyles():UITextFormat
        {
            if (((inLayoutContents) && (selected)))
            {
                return (textField.getUITextFormat());
            };
            return (super.determineTextFormatFromStyles());
        }


    }
}//package mx.controls.buttonBarClasses

