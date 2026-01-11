// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.Wallet

package view.module.market
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.util.EvonyImage;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
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

    public class Wallet extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1491999915myMedal:int;
        public var _Wallet_EvonyImage1:EvonyImage;
        public var _Wallet_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.horizontalGap = 0;
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_Wallet_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "styleName":"PropertyValue2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_Wallet_EvonyImage1",
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

        public function Wallet()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Wallet._watcherSetupUtil = _arg_1;
        }


        private function _Wallet_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = int(myMedal);
            _local_1 = (int(myMedal) > 0);
            _local_1 = (int(myMedal) > 0);
            _local_1 = Lang.msg("铜币");
            _local_1 = (int(myMedal) > 0);
            _local_1 = (int(myMedal) > 0);
        }

        private function _Wallet_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(myMedal);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wallet_Text1.text = _arg_1;
            }, "_Wallet_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(myMedal) > 0);
            }, function (_arg_1:Boolean):void
            {
                _Wallet_Text1.visible = _arg_1;
            }, "_Wallet_Text1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(myMedal) > 0);
            }, function (_arg_1:Boolean):void
            {
                _Wallet_Text1.includeInLayout = _arg_1;
            }, "_Wallet_Text1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wallet_EvonyImage1.toolTip = _arg_1;
            }, "_Wallet_EvonyImage1.toolTip");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(myMedal) > 0);
            }, function (_arg_1:Boolean):void
            {
                _Wallet_EvonyImage1.visible = _arg_1;
            }, "_Wallet_EvonyImage1.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(myMedal) > 0);
            }, function (_arg_1:Boolean):void
            {
                _Wallet_EvonyImage1.includeInLayout = _arg_1;
            }, "_Wallet_EvonyImage1.includeInLayout");
            result[5] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get myMedal():int
        {
            return (this._1491999915myMedal);
        }

        public function set medal(_arg_1:int):void
        {
            this.myMedal = _arg_1;
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

        override public function initialize():void
        {
            var target:Wallet;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Wallet_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_WalletWatcherSetupUtil");
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


    }
}//package view.module.market

