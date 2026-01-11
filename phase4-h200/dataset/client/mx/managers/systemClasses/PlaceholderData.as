// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.systemClasses.PlaceholderData

package mx.managers.systemClasses
{
    import flash.events.IEventDispatcher;

    public class PlaceholderData 
    {

        public var bridge:IEventDispatcher;
        public var data:Object;
        public var id:String;

        public function PlaceholderData(_arg_1:String, _arg_2:IEventDispatcher, _arg_3:Object)
        {
            this.id = _arg_1;
            this.bridge = _arg_2;
            this.data = _arg_3;
        }

    }
}//package mx.managers.systemClasses

