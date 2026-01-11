// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.BindabilityInfo

package mx.binding
{
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BindabilityInfo 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const BINDABLE:String = "Bindable";
        public static const MANAGED:String = "Managed";
        public static const CHANGE_EVENT:String = "ChangeEvent";
        public static const NON_COMMITTING_CHANGE_EVENT:String = "NonCommittingChangeEvent";
        public static const ACCESSOR:String = "accessor";
        public static const METHOD:String = "method";

        private var classChangeEvents:Object;
        private var typeDescription:XML;
        private var childChangeEvents:Object = {};

        public function BindabilityInfo(_arg_1:XML)
        {
            this.typeDescription = _arg_1;
        }

        private function addChangeEvents(_arg_1:XMLList, _arg_2:Object, _arg_3:Boolean):void
        {
            var _local_4:XML;
            var _local_5:XMLList;
            var _local_6:String;
            for each (_local_4 in _arg_1)
            {
                _local_5 = _local_4.arg;
                if (_local_5.length() > 0)
                {
                    _local_6 = _local_5[0].@value;
                    _arg_2[_local_6] = _arg_3;
                }
                else
                {
                    trace((("warning: unconverted Bindable metadata in class '" + typeDescription.@name) + "'"));
                };
            };
        }

        private function getClassChangeEvents():Object
        {
            if (!classChangeEvents)
            {
                classChangeEvents = {};
                addBindabilityEvents(typeDescription.metadata, classChangeEvents);
                if (typeDescription.metadata.(@name == MANAGED).length() > 0)
                {
                    classChangeEvents[PropertyChangeEvent.PROPERTY_CHANGE] = true;
                };
            };
            return (classChangeEvents);
        }

        private function addBindabilityEvents(metadata:XMLList, eventListObj:Object):void
        {
            addChangeEvents(metadata.(@name == BINDABLE), eventListObj, true);
            addChangeEvents(metadata.(@name == CHANGE_EVENT), eventListObj, true);
            addChangeEvents(metadata.(@name == NON_COMMITTING_CHANGE_EVENT), eventListObj, false);
        }

        private function copyProps(_arg_1:Object, _arg_2:Object):Object
        {
            var _local_3:String;
            for (_local_3 in _arg_1)
            {
                _arg_2[_local_3] = _arg_1[_local_3];
            };
            return (_arg_2);
        }

        public function getChangeEvents(childName:String):Object
        {
            var childDesc:XMLList;
            var numChildren:int;
            var changeEvents:Object = childChangeEvents[childName];
            if (!changeEvents)
            {
                changeEvents = copyProps(getClassChangeEvents(), {});
                childDesc = (typeDescription.accessor.(@name == childName) + typeDescription.method.(@name == childName));
                numChildren = childDesc.length();
                if (numChildren == 0)
                {
                    if (!typeDescription.@dynamic)
                    {
                        trace((((("warning: no describeType entry for '" + childName) + "' on non-dynamic type '") + typeDescription.@name) + "'"));
                    };
                }
                else
                {
                    if (numChildren > 1)
                    {
                        trace(((((("warning: multiple describeType entries for '" + childName) + "' on type '") + typeDescription.@name) + "':\n") + childDesc));
                    };
                    addBindabilityEvents(childDesc.metadata, changeEvents);
                };
                childChangeEvents[childName] = changeEvents;
            };
            return (changeEvents);
        }


    }
}//package mx.binding

