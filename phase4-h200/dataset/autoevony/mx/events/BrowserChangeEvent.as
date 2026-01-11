// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.BrowserChangeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BrowserChangeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const APPLICATION_URL_CHANGE:String = "applicationURLChange";
        public static const BROWSER_URL_CHANGE:String = "browserURLChange";
        public static const URL_CHANGE:String = "urlChange";

        public var lastURL:String;
        public var url:String;

        public function BrowserChangeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:String=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.url = _arg_4;
            this.lastURL = _arg_5;
        }

        override public function clone():Event
        {
            return (new BrowserChangeEvent(type, bubbles, cancelable, url, lastURL));
        }


    }
}//package mx.events

