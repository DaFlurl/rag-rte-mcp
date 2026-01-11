// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.LogEvent

package mx.logging
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LogEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const LOG:String = "log";

        public var level:int;
        public var message:String;

        public function LogEvent(_arg_1:String="", _arg_2:int=0)
        {
            super(LogEvent.LOG, false, false);
            this.message = _arg_1;
            this.level = _arg_2;
        }

        public static function getLevelString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case LogEventLevel.INFO:
                    return ("INFO");
                case LogEventLevel.DEBUG:
                    return ("DEBUG");
                case LogEventLevel.ERROR:
                    return ("ERROR");
                case LogEventLevel.WARN:
                    return ("WARN");
                case LogEventLevel.FATAL:
                    return ("FATAL");
                case LogEventLevel.ALL:
                    return ("ALL");
            };
            return ("UNKNOWN");
        }


        override public function clone():Event
        {
            return (new LogEvent(message, level));
        }


    }
}//package mx.logging

