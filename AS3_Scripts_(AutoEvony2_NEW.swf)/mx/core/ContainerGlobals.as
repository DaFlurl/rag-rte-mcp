// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ContainerGlobals

package mx.core
{
    import flash.display.InteractiveObject;
    import mx.managers.IFocusManager;

    public class ContainerGlobals 
    {

        public static var focusedContainer:InteractiveObject;


        public static function checkFocus(_arg_1:InteractiveObject, _arg_2:InteractiveObject):void
        {
            var _local_6:IFocusManager;
            var _local_7:IButton;
            var _local_3:InteractiveObject = _arg_2;
            var _local_4:InteractiveObject = _arg_2;
            var _local_5:IUIComponent;
            if (((!(_arg_2 == null)) && (_arg_1 == _arg_2)))
            {
                return;
            };
            while (_local_4)
            {
                if (_local_4.parent)
                {
                    _local_3 = _local_4.parent;
                }
                else
                {
                    _local_3 = null;
                };
                if ((_local_4 is IUIComponent))
                {
                    _local_5 = IUIComponent(_local_4);
                };
                _local_4 = _local_3;
                if ((((_local_4) && (_local_4 is IContainer)) && (IContainer(_local_4).defaultButton))) break;
            };
            if (((!(ContainerGlobals.focusedContainer == _local_4)) || ((ContainerGlobals.focusedContainer == null) && (_local_4 == null))))
            {
                if (!_local_4)
                {
                    _local_4 = InteractiveObject(_local_5);
                };
                if (((_local_4) && (_local_4 is IContainer)))
                {
                    _local_6 = IContainer(_local_4).focusManager;
                    if (!_local_6)
                    {
                        return;
                    };
                    _local_7 = (IContainer(_local_4).defaultButton as IButton);
                    if (_local_7)
                    {
                        ContainerGlobals.focusedContainer = InteractiveObject(_local_4);
                        _local_6.defaultButton = (_local_7 as IButton);
                    }
                    else
                    {
                        ContainerGlobals.focusedContainer = InteractiveObject(_local_4);
                        _local_6.defaultButton = null;
                    };
                };
            };
        }


    }
}//package mx.core

