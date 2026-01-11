// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CoordinatesUI

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.EvonyImage;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class CoordinatesUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1360136788cityXY:String;
        public var _CoordinatesUI_Label1:Label;
        private var _1420728714cityname:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":154,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":EvonyImage,
                        "events":{"click":"___CoordinatesUI_EvonyImage1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":4,
                                "y":4,
                                "width":17,
                                "height":17,
                                "source":"fla/dynamic/ui234.swf@deletePackAway.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_CoordinatesUI_Label1",
                        "events":{"click":"___CoordinatesUI_Label1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":20,
                                "y":2,
                                "styleName":"funtionWindowTitle",
                                "width":114
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CoordinatesUI()
        {
            mx_internal::_document = this;
            this.width = 154;
            this.addEventListener("rollOver", ___CoordinatesUI_Canvas1_rollOver);
            this.addEventListener("rollOut", ___CoordinatesUI_Canvas1_rollOut);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CoordinatesUI._watcherSetupUtil = _arg_1;
        }


        private function _CoordinatesUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((cityname + "(") + cityXY) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CoordinatesUI_Label1.text = _arg_1;
            }, "_CoordinatesUI_Label1.text");
            result[0] = binding;
            return (result);
        }

        public function set cityname(_arg_1:String):void
        {
            var _local_2:Object = this._1420728714cityname;
            if (_local_2 !== _arg_1)
            {
                this._1420728714cityname = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityname", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cityname():String
        {
            return (this._1420728714cityname);
        }

        public function ___CoordinatesUI_Canvas1_rollOver(_arg_1:MouseEvent):void
        {
            changeBgColor();
        }

        private function _CoordinatesUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((cityname + "(") + cityXY) + ")");
        }

        private function changeBgColor():void
        {
            this.setStyle("backgroundColor", "#974706");
        }

        override public function initialize():void
        {
            var target:CoordinatesUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CoordinatesUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_CoordinatesUIWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get cityXY():String
        {
            return (this._1360136788cityXY);
        }

        private function revertBgColor():void
        {
            this.setStyle("backgroundColor", null);
        }

        public function ___CoordinatesUI_Canvas1_rollOut(_arg_1:MouseEvent):void
        {
            revertBgColor();
        }

        private function ChangeClick():void
        {
            dispatchEvent(new Event("onChangeClick"));
        }

        public function set cityXY(_arg_1:String):void
        {
            var _local_2:Object = this._1360136788cityXY;
            if (_local_2 !== _arg_1)
            {
                this._1360136788cityXY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityXY", _local_2, _arg_1));
            };
        }

        public function ___CoordinatesUI_Label1_click(_arg_1:MouseEvent):void
        {
            ChangeClick();
        }

        public function ___CoordinatesUI_EvonyImage1_click(_arg_1:MouseEvent):void
        {
            DeleteClick();
        }

        private function DeleteClick():void
        {
            dispatchEvent(new Event("onDeleteClick"));
        }


    }
}//package view.ui

