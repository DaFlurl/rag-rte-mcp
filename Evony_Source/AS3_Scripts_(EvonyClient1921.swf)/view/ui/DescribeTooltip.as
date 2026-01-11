// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.DescribeTooltip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import view.module.market.WalletShowAll;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import view.MainWin;
    import com.evony.eum.ItemEum;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
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

    public class DescribeTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:DescribeTooltip = new (DescribeTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _DescribeTooltip_Label1:Label;
        public var _DescribeTooltip_Label2:Label;
        private var _1180509258isFlag:Boolean;
        public var _DescribeTooltip_WalletShowAll1:WalletShowAll;
        public var _DescribeTooltip_Text1:Text;
        private var _3079825desc:String;
        private var _110371416title:String;
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
                                    "id":"_DescribeTooltip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_DescribeTooltip_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.kerning = true;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "percentWidth":100
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "15";
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DescribeTooltip_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WalletShowAll,
                                    "id":"_DescribeTooltip_WalletShowAll1"
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

        public function DescribeTooltip()
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
            DescribeTooltip._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:String, _arg_2:String, _arg_3:MouseEvent, _arg_4:int=0, _arg_5:ItemEum=null):void
        {
            if (_arg_4 == 0)
            {
                instance.isFlag = false;
            }
            else
            {
                instance.isFlag = true;
                if (_arg_5 != null)
                {
                    instance.value = (_arg_5.price * _arg_4);
                };
            };
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


        override public function initialize():void
        {
            var target:DescribeTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DescribeTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_DescribeTooltipWatcherSetupUtil");
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
        private function get desc():String
        {
            return (this._3079825desc);
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
        private function get isFlag():Boolean
        {
            return (this._1180509258isFlag);
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
        private function get title():String
        {
            return (this._110371416title);
        }

        private function _DescribeTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DescribeTooltip_Label1.htmlText = _arg_1;
            }, "_DescribeTooltip_Label1.htmlText");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DescribeTooltip_Text1.htmlText = _arg_1;
            }, "_DescribeTooltip_Text1.htmlText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("价格") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DescribeTooltip_Label2.htmlText = _arg_1;
            }, "_DescribeTooltip_Label2.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.value);
            }, function (_arg_1:int):void
            {
                _DescribeTooltip_WalletShowAll1.medal = _arg_1;
            }, "_DescribeTooltip_WalletShowAll1.medal");
            result[3] = binding;
            return (result);
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

        private function _DescribeTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.title;
            _local_1 = this.desc;
            _local_1 = (Lang.msg("价格") + ":");
            _local_1 = this.value;
        }


    }
}//package view.ui

