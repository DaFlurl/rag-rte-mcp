// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.palette.PaletteEntry

package com.degrafa.paint.palette
{
    import com.degrafa.core.DegrafaObject;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;

    public class PaletteEntry extends DegrafaObject 
    {

        protected var typeName:String;
        private var _value:Object;
        private var _name:String;
        protected var type:Class;

        public function PaletteEntry(_arg_1:String=undefined, _arg_2:Object=null)
        {
            this.name = _arg_1;
            this.value = _arg_2;
        }

        public function set value(_arg_1:Object):void
        {
            var _local_2:Object;
            if (_value != _arg_1)
            {
                _local_2 = _value;
                _value = _arg_1;
                typeName = getQualifiedClassName(_value);
                typeName = typeName.replace("::", ".");
                type = Class(getDefinitionByName(typeName));
                initChange("value", _local_2, _value, this);
            };
        }

        override public function get name():String
        {
            return (_name);
        }

        public function get value():Object
        {
            return (_value);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }


    }
}//package com.degrafa.paint.palette

