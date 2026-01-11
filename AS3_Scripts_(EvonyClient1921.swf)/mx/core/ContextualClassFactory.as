// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ContextualClassFactory

package mx.core
{
    import flash.utils.getQualifiedClassName;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ContextualClassFactory extends ClassFactory 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var moduleFactory:IFlexModuleFactory;

        public function ContextualClassFactory(_arg_1:Class=null, _arg_2:IFlexModuleFactory=null)
        {
            super(_arg_1);
            this.moduleFactory = _arg_2;
        }

        override public function newInstance():*
        {
            var _local_2:String;
            var _local_1:Object;
            if (moduleFactory)
            {
                _local_1 = moduleFactory.create(getQualifiedClassName(generator));
            };
            if (!_local_1)
            {
                _local_1 = super.newInstance();
            };
            if (properties)
            {
                for (_local_2 in properties)
                {
                    _local_1[_local_2] = properties[_local_2];
                };
            };
            return (_local_1);
        }


    }
}//package mx.core

