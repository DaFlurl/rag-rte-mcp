// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.WalletShowAll

package view.module.market
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.util.EvonyImage;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class WalletShowAll extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1063571914textColor:uint = 0x652D00;
        private var _3392876num2:Label;
        private var _1491999915myMedal:int;
        public var _WalletShowAll_EvonyImage1:EvonyImage;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "2";
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.horizontalGap = 2;
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"num2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_WalletShowAll_EvonyImage1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function WalletShowAll()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WalletShowAll._watcherSetupUtil = _arg_1;
        }


        private function set textColor(_arg_1:uint):void
        {
            var _local_2:Object = this._1063571914textColor;
            if (_local_2 !== _arg_1)
            {
                this._1063571914textColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textColor", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:WalletShowAll;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WalletShowAll_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_WalletShowAllWatcherSetupUtil");
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
        public function get num2():Label
        {
            return (this._3392876num2);
        }

        private function _WalletShowAll_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(myMedal);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                num2.text = _arg_1;
            }, "num2.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WalletShowAll_EvonyImage1.toolTip = _arg_1;
            }, "_WalletShowAll_EvonyImage1.toolTip");
            result[1] = binding;
            return (result);
        }

        private function set myMedal(_arg_1:int):void
        {
            var _local_2:Object = this._1491999915myMedal;
            if (_local_2 !== _arg_1)
            {
                this._1491999915myMedal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myMedal", _local_2, _arg_1));
            };
        }

        public function set num2(_arg_1:Label):void
        {
            var _local_2:Object = this._3392876num2;
            if (_local_2 !== _arg_1)
            {
                this._3392876num2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num2", _local_2, _arg_1));
            };
        }

        public function set fontColor(_arg_1:uint):void
        {
            this.textColor = _arg_1;
        }

        private function _WalletShowAll_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = int(myMedal);
            _local_1 = Lang.msg("铜币");
        }

        public function set medal(_arg_1:int):void
        {
            this.myMedal = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get myMedal():int
        {
            return (this._1491999915myMedal);
        }

        [Bindable(event="propertyChange")]
        private function get textColor():uint
        {
            return (this._1063571914textColor);
        }


    }
}//package view.module.market

