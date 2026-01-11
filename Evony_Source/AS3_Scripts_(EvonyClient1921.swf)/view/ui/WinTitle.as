// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.WinTitle

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.filters.GlowFilter;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
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

    public class WinTitle extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _WinTitle_Label1:Label;
        public var onClose:Function;
        private var _110371416title:String = "";

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":169,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":819,
                                "height":169,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.verticalAlign = "middle";
                                        this.top = "4";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":30,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_WinTitle_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "y":1,
                                                        "styleName":"winTitleFont",
                                                        "filters":[_WinTitle_GlowFilter1_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___WinTitle_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "40";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"close"});
                                    }
                                })]
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

        public function WinTitle()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 169;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WinTitle._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:WinTitle;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WinTitle_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_WinTitleWatcherSetupUtil");
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

        private function _WinTitle_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 3417374;
            _local_1.blurX = 5;
            _local_1.blurY = 5;
            _local_1.alpha = 0.7;
            _local_1.strength = 5;
            _local_1.quality = 1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get title():String
        {
            return (this._110371416title);
        }

        public function ___WinTitle_Button1_click(_arg_1:MouseEvent):void
        {
            onCloseClick();
        }

        private function _WinTitle_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WinTitle_Label1.text = _arg_1;
            }, "_WinTitle_Label1.text");
            result[0] = binding;
            return (result);
        }

        private function onCloseClick():void
        {
            if (this.onClose == null)
            {
                this.dispatchEvent(new Event("onClose"));
            }
            else
            {
                this.onClose.apply(this);
            };
        }

        public function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        private function _WinTitle_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = title;
        }


    }
}//package view.ui

