// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.ArrayElementWatcher

package mx.binding
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ArrayElementWatcher extends Watcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var accessorFunc:Function;
        public var arrayWatcher:Watcher;
        private var document:Object;

        public function ArrayElementWatcher(_arg_1:Object, _arg_2:Function, _arg_3:Array)
        {
            super(_arg_3);
            this.document = _arg_1;
            this.accessorFunc = _arg_2;
        }

        override public function updateParent(parent:Object):void
        {
            if (arrayWatcher.value != null)
            {
                wrapUpdate(function ():void
                {
                    value = arrayWatcher.value[accessorFunc.apply(document)];
                    updateChildren();
                });
            };
        }

        override protected function shallowClone():Watcher
        {
            return (new ArrayElementWatcher(document, accessorFunc, listeners));
        }


    }
}//package mx.binding

