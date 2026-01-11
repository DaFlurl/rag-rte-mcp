// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FacebookToolBar_inlineComponent1

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import flash.system.LoaderContext;
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

    public class FacebookToolBar_inlineComponent1 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _104387img:Image;
        private var _88844982outerDocument:FacebookToolBar;
        public var _FacebookToolBar_inlineComponent1_Image4:Image;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":53,
                    "height":53,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"images/friendsFaceBg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"img",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":43,
                                "height":43
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"images/friendsFaceGg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_FacebookToolBar_inlineComponent1_Image4",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"images/neighborhelp.png"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FacebookToolBar_inlineComponent1()
        {
            mx_internal::_document = this;
            this.width = 53;
            this.height = 53;
            this.addEventListener("click", ___FacebookToolBar_inlineComponent1_Canvas1_click);
            this.addEventListener("mouseOver", ___FacebookToolBar_inlineComponent1_Canvas1_mouseOver);
            this.addEventListener("mouseOut", ___FacebookToolBar_inlineComponent1_Canvas1_mouseOut);
            this.addEventListener("mouseDown", ___FacebookToolBar_inlineComponent1_Canvas1_mouseDown);
            this.addEventListener("mouseUp", ___FacebookToolBar_inlineComponent1_Canvas1_mouseUp);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FacebookToolBar_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get img():Image
        {
            return (this._104387img);
        }

        public function set img(_arg_1:Image):void
        {
            var _local_2:Object = this._104387img;
            if (_local_2 !== _arg_1)
            {
                this._104387img = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "img", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:FacebookToolBar_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FacebookToolBar_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_FacebookToolBar_inlineComponent1WatcherSetupUtil");
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

        public function ___FacebookToolBar_inlineComponent1_Canvas1_mouseOver(_arg_1:MouseEvent):void
        {
            parentDocument.onMouseOver(_arg_1, data, img);
        }

        public function ___FacebookToolBar_inlineComponent1_Canvas1_mouseUp(_arg_1:MouseEvent):void
        {
            parentDocument.onMouseOut(_arg_1, data, img);
        }

        public function set outerDocument(_arg_1:FacebookToolBar):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        public function ___FacebookToolBar_inlineComponent1_Canvas1_mouseDown(_arg_1:MouseEvent):void
        {
            parentDocument.onMouseDown(_arg_1, data, img);
        }

        private function _FacebookToolBar_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (data.image);
            }, function (_arg_1:Object):void
            {
                img.source = _arg_1;
            }, "img.source");
            result[0] = binding;
            binding = new Binding(this, function ():LoaderContext
            {
                return (FacebookToolBar.ldrc);
            }, function (_arg_1:LoaderContext):void
            {
                img.loaderContext = _arg_1;
            }, "img.loaderContext");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.count == 1) ? false : false);
            }, function (_arg_1:Boolean):void
            {
                _FacebookToolBar_inlineComponent1_Image4.visible = _arg_1;
            }, "_FacebookToolBar_inlineComponent1_Image4.visible");
            result[2] = binding;
            return (result);
        }

        public function ___FacebookToolBar_inlineComponent1_Canvas1_mouseOut(_arg_1:MouseEvent):void
        {
            parentDocument.onMouseOut(_arg_1, data, img);
        }

        private function _FacebookToolBar_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.image;
            _local_1 = FacebookToolBar.ldrc;
            _local_1 = ((data.count == 1) ? false : false);
        }

        public function ___FacebookToolBar_inlineComponent1_Canvas1_click(_arg_1:MouseEvent):void
        {
            parentDocument.onClick(_arg_1, data);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():FacebookToolBar
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.ui

