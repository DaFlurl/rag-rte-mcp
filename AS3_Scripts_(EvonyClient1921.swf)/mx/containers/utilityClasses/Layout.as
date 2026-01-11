// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.Layout

package mx.containers.utilityClasses
{
    import mx.core.Container;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Layout 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _target:Container;
        protected var resourceManager:IResourceManager = ResourceManager.getInstance();


        public function get target():Container
        {
            return (_target);
        }

        public function set target(_arg_1:Container):void
        {
            _target = _arg_1;
        }

        public function measure():void
        {
        }

        public function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
        }


    }
}//package mx.containers.utilityClasses

