// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ServerItem

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ItemBean;
    import com.evony.eum.ItemEum;
    import mx.controls.RadioButton;
    import view.module.shop.TreasureTooltip;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.Context;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
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

    public class ServerItem extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var dataObject:ItemBean;
        private var _2007535601itemServerId:String;
        private var itemEum:ItemEum;
        public var _ServerItem_RadioButton1:RadioButton;
        private var tips:TreasureTooltip;
        private var _1177518208itemTime:String;
        private var _801546209itemServerName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":235,
                    "height":30,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":RadioButton,
                        "id":"_ServerItem_RadioButton1",
                        "events":{"click":"___ServerItem_RadioButton1_click"}
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ServerItem()
        {
            mx_internal::_document = this;
            this.width = 235;
            this.height = 30;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ServerItem._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get itemServerId():String
        {
            return (this._2007535601itemServerId);
        }

        private function set itemServerName(_arg_1:String):void
        {
            var _local_2:Object = this._801546209itemServerName;
            if (_local_2 !== _arg_1)
            {
                this._801546209itemServerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemServerName", _local_2, _arg_1));
            };
        }

        private function _ServerItem_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((itemServerName + "  ") + itemTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ServerItem_RadioButton1.label = _arg_1;
            }, "_ServerItem_RadioButton1.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().selectServerId == itemServerId) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ServerItem_RadioButton1.selected = _arg_1;
            }, "_ServerItem_RadioButton1.selected");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get itemTime():String
        {
            return (this._1177518208itemTime);
        }

        private function set itemTime(_arg_1:String):void
        {
            var _local_2:Object = this._1177518208itemTime;
            if (_local_2 !== _arg_1)
            {
                this._1177518208itemTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemTime", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ServerItem;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ServerItem_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ServerItemWatcherSetupUtil");
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

        public function ___ServerItem_RadioButton1_click(_arg_1:MouseEvent):void
        {
            setSelectServer();
        }

        public function set Time(_arg_1:String):void
        {
            this.itemTime = _arg_1;
        }

        public function set ServerName(_arg_1:String):void
        {
            this.itemServerName = _arg_1;
        }

        private function setSelectServer():void
        {
            Context.getInstance().selectServerId = itemServerId;
        }

        private function set itemServerId(_arg_1:String):void
        {
            var _local_2:Object = this._2007535601itemServerId;
            if (_local_2 !== _arg_1)
            {
                this._2007535601itemServerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemServerId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemServerName():String
        {
            return (this._801546209itemServerName);
        }

        private function _ServerItem_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((itemServerName + "  ") + itemTime);
            _local_1 = ((Context.getInstance().selectServerId == itemServerId) ? true : false);
        }

        public function set ServerId(_arg_1:String):void
        {
            this.itemServerId = _arg_1;
        }


    }
}//package view

