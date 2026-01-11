// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.controls.popup.PopUpWinBase

package autoevony.gui.controls.popup
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class PopUpWinBase extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1904299080windowTitle:String = "";
        public var _PopUpWinBase_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "5";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"REpopupWinBase"});
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "0";
                            this.horizontalAlign = "center";
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":220,
                                "height":40,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "styleName":"REmainScreenTopNamePopupTitleContainer"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_PopUpWinBase_Label1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":27,
                                "styleName":"REpopupWinTitleText"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "events":{
                            "mouseDown":"___PopUpWinBase_VBox3_mouseDown",
                            "mouseUp":"___PopUpWinBase_VBox3_mouseUp"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "0";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":220,
                                "height":40,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off"
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PopUpWinBase()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PopUpWinBase._watcherSetupUtil = _arg_1;
        }


        public function ___PopUpWinBase_VBox3_mouseUp(_arg_1:MouseEvent):void
        {
            parentDocument.stopDrag();
        }

        [Bindable(event="propertyChange")]
        public function get windowTitle():String
        {
            return (this._1904299080windowTitle);
        }

        public function ___PopUpWinBase_VBox3_mouseDown(_arg_1:MouseEvent):void
        {
            parentDocument.startDrag();
        }

        override public function initialize():void
        {
            var target:PopUpWinBase;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._PopUpWinBase_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil");
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

        public function set windowTitle(_arg_1:String):void
        {
            var _local_2:Object = this._1904299080windowTitle;
            if (_local_2 !== _arg_1)
            {
                this._1904299080windowTitle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "windowTitle", _local_2, _arg_1));
            };
        }

        private function _PopUpWinBase_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.windowTitle;
        }

        private function _PopUpWinBase_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.windowTitle;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PopUpWinBase_Label1.text = _arg_1;
            }, "_PopUpWinBase_Label1.text");
            result[0] = binding;
            return (result);
        }


    }
}//package autoevony.gui.controls.popup

