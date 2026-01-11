// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ArrayCollection

package mx.collections
{
    import flash.utils.IExternalizable;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ArrayCollection extends ListCollectionView implements IExternalizable 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function ArrayCollection(_arg_1:Array=null)
        {
            this.source = _arg_1;
        }

        public function set source(_arg_1:Array):void
        {
            list = new ArrayList(_arg_1);
        }

        public function readExternal(_arg_1:IDataInput):void
        {
            if ((list is IExternalizable))
            {
                IExternalizable(list).readExternal(_arg_1);
            }
            else
            {
                source = (_arg_1.readObject() as Array);
            };
        }

        public function writeExternal(_arg_1:IDataOutput):void
        {
            if ((list is IExternalizable))
            {
                IExternalizable(list).writeExternal(_arg_1);
            }
            else
            {
                _arg_1.writeObject(source);
            };
        }

        [Bindable("listChanged")]
        public function get source():Array
        {
            if (((list) && (list is ArrayList)))
            {
                return (ArrayList(list).source);
            };
            return (null);
        }


    }
}//package mx.collections

