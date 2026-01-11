// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingDescribeTooltip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import view.MainWin;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class BuildingDescribeTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:BuildingDescribeTooltip = new (BuildingDescribeTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _110371416title:String;
        private var _1180509258isFlag:Boolean;
        public var _BuildingDescribeTooltip_Text1:Text;
        public var _BuildingDescribeTooltip_Label1:Label;
        private var _3079825desc:String;
        private var _111972721value:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "8";
                            this.right = "8";
                            this.verticalGap = 6;
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingDescribeTooltip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BuildingDescribeTooltip_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.kerning = true;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName1",
                                            "percentWidth":100
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuildingDescribeTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
            this.width = 400;
        }

        public static function move2Mouse(_arg_1:MouseEvent):void
        {
            instance.moveToMouse(_arg_1);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuildingDescribeTooltip._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:String, _arg_2:String, _arg_3:MouseEvent):void
        {
            instance.title = _arg_1;
            instance.desc = _arg_2;
            instance.moveToMouse(_arg_3);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainWin.instance);
            }
            else
            {
                PopUpManager.bringToFront(instance);
            };
        }


        [Bindable(event="propertyChange")]
        private function get isFlag():Boolean
        {
            return (this._1180509258isFlag);
        }

        override public function initialize():void
        {
            var target:BuildingDescribeTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuildingDescribeTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_BuildingDescribeTooltipWatcherSetupUtil");
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

        private function _BuildingDescribeTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.title;
            _local_1 = this.desc;
        }

        private function _BuildingDescribeTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingDescribeTooltip_Label1.htmlText = _arg_1;
            }, "_BuildingDescribeTooltip_Label1.htmlText");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingDescribeTooltip_Text1.htmlText = _arg_1;
            }, "_BuildingDescribeTooltip_Text1.htmlText");
            result[1] = binding;
            return (result);
        }

        private function set isFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180509258isFlag;
            if (_local_2 !== _arg_1)
            {
                this._1180509258isFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get desc():String
        {
            return (this._3079825desc);
        }

        private function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get title():String
        {
            return (this._110371416title);
        }

        private function set value(_arg_1:int):void
        {
            var _local_2:Object = this._111972721value;
            if (_local_2 !== _arg_1)
            {
                this._111972721value = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "value", _local_2, _arg_1));
            };
        }

        private function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get value():int
        {
            return (this._111972721value);
        }


    }
}//package view.ui

