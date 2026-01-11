// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.netmon.NetworkMonitor

package mx.netmon
{
    import flash.net.URLRequest;
    import flash.events.Event;

    public class NetworkMonitor 
    {

        public static var isMonitoringImpl:Function;
        public static var adjustURLRequestImpl:Function;
        public static var adjustNetConnectionURLImpl:Function;
        public static var monitorEventImpl:Function;
        public static var monitorInvocationImpl:Function;
        public static var monitorResultImpl:Function;
        public static var monitorFaultImpl:Function;


        public static function monitorInvocation(_arg_1:String, _arg_2:Object, _arg_3:Object):void
        {
            if (monitorInvocationImpl != null)
            {
                monitorInvocationImpl(_arg_1, _arg_2, _arg_3);
            };
        }

        public static function monitorFault(_arg_1:Object, _arg_2:Object):void
        {
            if (monitorFaultImpl != null)
            {
                monitorFaultImpl(_arg_1, _arg_2);
            };
        }

        public static function adjustURLRequest(_arg_1:URLRequest, _arg_2:String, _arg_3:String):void
        {
            if (adjustURLRequestImpl != null)
            {
                adjustURLRequestImpl(_arg_1, _arg_2, _arg_3);
            };
        }

        public static function monitorEvent(_arg_1:Event, _arg_2:String):void
        {
            if (monitorEventImpl != null)
            {
                monitorEventImpl(_arg_1, _arg_2);
            };
        }

        public static function isMonitoring():Boolean
        {
            return ((isMonitoringImpl != null) ? isMonitoringImpl() : false);
        }

        public static function adjustNetConnectionURL(_arg_1:String, _arg_2:String):String
        {
            if (adjustNetConnectionURLImpl != null)
            {
                return (adjustNetConnectionURLImpl(_arg_1, _arg_2));
            };
            return (null);
        }

        public static function monitorResult(_arg_1:Object, _arg_2:Object):void
        {
            if (monitorResultImpl != null)
            {
                monitorResultImpl(_arg_1, _arg_2);
            };
        }


    }
}//package mx.netmon

