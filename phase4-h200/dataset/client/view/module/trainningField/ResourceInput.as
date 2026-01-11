// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.ResourceInput

package view.module.trainningField
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.NumberRegulate;
    import mx.controls.TextArea;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.factory.ImageManager;
    import com.evony.util.ImageSmooth;
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

    public class ResourceInput extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _102976443limit:Number;
        private var _1909260316numInput:NumberRegulate;
        private var _720862347imgClass:Object;
        private var _2113639170leftSource:int;
        public var _ResourceInput_TextArea1:TextArea;
        private var _1515516266onDataFun:Function;
        public var _ResourceInput_Image1:Image;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":320,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_ResourceInput_Image1",
                                    "events":{"added":"___ResourceInput_Image1_added"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":24,
                                            "height":24
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "200";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":NumberRegulate,
                                                "id":"numInput",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.textAlign = "center";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":140});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_ResourceInput_TextArea1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.left = "54";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue2",
                                                        "height":22,
                                                        "width":110,
                                                        "editable":false,
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
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

        public function ResourceInput()
        {
            mx_internal::_document = this;
            this.width = 320;
            this.styleName = "armyTiles";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ResourceInput._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get limit():Number
        {
            return (this._102976443limit);
        }

        public function set onDataFun(_arg_1:Function):void
        {
            var _local_2:Object = this._1515516266onDataFun;
            if (_local_2 !== _arg_1)
            {
                this._1515516266onDataFun = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "onDataFun", _local_2, _arg_1));
            };
        }

        public function set numInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1909260316numInput;
            if (_local_2 !== _arg_1)
            {
                this._1909260316numInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get leftSource():int
        {
            return (this._2113639170leftSource);
        }

        public function set leftSource(_arg_1:int):void
        {
            var _local_2:Object = this._2113639170leftSource;
            if (_local_2 !== _arg_1)
            {
                this._2113639170leftSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftSource", _local_2, _arg_1));
            };
        }

        private function _ResourceInput_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgClass);
            }, function (_arg_1:Object):void
            {
                _ResourceInput_Image1.source = _arg_1;
            }, "_ResourceInput_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (Math.min(this.leftSource, Math.floor(this.limit)));
            }, function (_arg_1:int):void
            {
                numInput.valueMax = _arg_1;
            }, "numInput.valueMax");
            result[1] = binding;
            binding = new Binding(this, function ():Function
            {
                return (this.onDataFun);
            }, function (_arg_1:Function):void
            {
                numInput.onDataChange = _arg_1;
            }, "numInput.onDataChange");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Math.floor(this.limit);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceInput_TextArea1.text = _arg_1;
            }, "_ResourceInput_TextArea1.text");
            result[3] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:ResourceInput;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ResourceInput_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_ResourceInputWatcherSetupUtil");
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

        public function set resourceType(_arg_1:String):void
        {
            this.imgClass = ImageManager.getResourceLogo(_arg_1);
        }

        private function _ResourceInput_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgClass;
            _local_1 = Math.min(this.leftSource, Math.floor(this.limit));
            _local_1 = this.onDataFun;
            _local_1 = Math.floor(this.limit);
        }

        [Bindable(event="propertyChange")]
        public function get onDataFun():Function
        {
            return (this._1515516266onDataFun);
        }

        [Bindable(event="propertyChange")]
        public function get numInput():NumberRegulate
        {
            return (this._1909260316numInput);
        }

        private function set imgClass(_arg_1:Object):void
        {
            var _local_2:Object = this._720862347imgClass;
            if (_local_2 !== _arg_1)
            {
                this._720862347imgClass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgClass", _local_2, _arg_1));
            };
        }

        public function ___ResourceInput_Image1_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get imgClass():Object
        {
            return (this._720862347imgClass);
        }

        public function set limit(_arg_1:Number):void
        {
            var _local_2:Object = this._102976443limit;
            if (_local_2 !== _arg_1)
            {
                this._102976443limit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "limit", _local_2, _arg_1));
            };
        }


    }
}//package view.module.trainningField

