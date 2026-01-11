// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ClassFactory

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ClassFactory implements IFactory 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var properties:Object = null;
        public var generator:Class;

        public function ClassFactory(_arg_1:Class=null)
        {
            this.generator = _arg_1;
        }

        public function newInstance():*
        {
            var _local_2:String;
            var _local_1:Object = new generator();
            if (properties != null)
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

