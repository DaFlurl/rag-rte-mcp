// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.workshop.Stars

package view.module.workshop
{
    import flash.utils.Dictionary;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.evony.util.ResourceLoader;

    public class Stars 
    {

        private static var instance:Stars;
        private static var items:Dictionary = new Dictionary();

        private var _loader:Loader;
        public var ready:Boolean = false;
        public var funArray:Array;
        private var flag:Boolean;

        public function Stars()
        {
            funArray = new Array();
        }

        public static function getClass(_arg_1:String):Class
        {
            if (items[_arg_1] == null)
            {
                items[_arg_1] = (instance._loader.contentLoaderInfo.applicationDomain.getDefinition(_arg_1) as Class);
            };
            return (items[_arg_1] as Class);
        }

        public static function getInstance():Stars
        {
            if (instance == null)
            {
                instance = new (Stars)();
            };
            if (instance.flag == false)
            {
                instance.createObject();
            };
            return (instance);
        }


        private function init(_arg_1:Event):void
        {
            var _local_2:Function;
            ready = true;
            for each (_local_2 in funArray)
            {
                _local_2.apply();
            };
            funArray = null;
        }

        private function createObject():void
        {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, init);
            _loader.load(new URLRequest(ResourceLoader.getNormalUrl("fla/dynamic/starLevs.swf")));
            flag = true;
        }


    }
}//package view.module.workshop

