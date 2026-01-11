// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.utilities.external.ExternalDataPropertyChangeEvent

package com.degrafa.utilities.external
{
    import mx.events.PropertyChangeEvent;

    public class ExternalDataPropertyChangeEvent extends PropertyChangeEvent 
    {

        public static const EXTERNAL_DATA_PROPERTY_CHANGE:String = "externalDataPropertyChange";

        public function ExternalDataPropertyChangeEvent(_arg_1:String="externalDataPropertyChange", _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String="update", _arg_5:Object=null, _arg_6:Object=null, _arg_7:Object=null, _arg_8:Object=null):void
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
        }

    }
}//package com.degrafa.utilities.external

