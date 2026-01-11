// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.ButtonWithIcon

package view.castle.world
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
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

    public class ButtonWithIcon extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ButtonWithIcon_Image1:Image;
        private var _1060163599myPath:String;
        private var _1060223401myName:String;
        private var _1292292098myButton:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":95,
                    "height":25,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"myButton",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "styleName":"b95",
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_ButtonWithIcon_Image1",
                        "events":{"complete":"___ButtonWithIcon_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.left = "2";
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ButtonWithIcon()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.disabledOverlayAlpha = 0.2;
            };
            this.width = 95;
            this.height = 25;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ButtonWithIcon._watcherSetupUtil = _arg_1;
        }


        private function _ButtonWithIcon_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.myName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myButton.label = _arg_1;
            }, "myButton.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.enabled);
            }, function (_arg_1:Boolean):void
            {
                myButton.enabled = _arg_1;
            }, "myButton.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.myPath);
            }, function (_arg_1:Object):void
            {
                _ButtonWithIcon_Image1.source = _arg_1;
            }, "_ButtonWithIcon_Image1.source");
            result[2] = binding;
            return (result);
        }

        private function _ButtonWithIcon_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.myName;
            _local_1 = this.enabled;
            _local_1 = this.myPath;
        }

        public function set myLabel(_arg_1:String):void
        {
            this.myName = _arg_1;
        }

        public function ___ButtonWithIcon_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        override public function initialize():void
        {
            var target:ButtonWithIcon;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ButtonWithIcon_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_world_ButtonWithIconWatcherSetupUtil");
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

        public function set MyIcon(_arg_1:String):void
        {
            this.myPath = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get myName():String
        {
            return (this._1060223401myName);
        }

        private function set myPath(_arg_1:String):void
        {
            var _local_2:Object = this._1060163599myPath;
            if (_local_2 !== _arg_1)
            {
                this._1060163599myPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPath", _local_2, _arg_1));
            };
        }

        private function set myName(_arg_1:String):void
        {
            var _local_2:Object = this._1060223401myName;
            if (_local_2 !== _arg_1)
            {
                this._1060223401myName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myPath():String
        {
            return (this._1060163599myPath);
        }

        public function set myButton(_arg_1:Button):void
        {
            var _local_2:Object = this._1292292098myButton;
            if (_local_2 !== _arg_1)
            {
                this._1292292098myButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myButton", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myButton():Button
        {
            return (this._1292292098myButton);
        }


    }
}//package view.castle.world

