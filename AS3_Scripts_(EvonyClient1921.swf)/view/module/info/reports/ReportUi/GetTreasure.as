// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.GetTreasure

package view.module.info.reports.ReportUi
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.ItemEumDefine;
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

    public class GetTreasure extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var itemAry:Array;
        private var _990511157myContainer:HBox;
        private var itemSubAry:Array;
        public var _GetTreasure_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_GetTreasure_Label1"
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"myContainer"
                    })]});
            }
        });
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function GetTreasure()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GetTreasure._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:GetTreasure;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GetTreasure_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_GetTreasureWatcherSetupUtil");
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

        private function _GetTreasure_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("获得宝物") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GetTreasure_Label1.text = _arg_1;
            }, "_GetTreasure_Label1.text");
            result[0] = binding;
            return (result);
        }

        public function set myContainer(_arg_1:HBox):void
        {
            var _local_2:Object = this._990511157myContainer;
            if (_local_2 !== _arg_1)
            {
                this._990511157myContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myContainer", _local_2, _arg_1));
            };
        }

        private function _GetTreasure_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (Lang.msg("获得宝物") + ":");
        }

        [Bindable(event="propertyChange")]
        public function get myContainer():HBox
        {
            return (this._990511157myContainer);
        }

        public function set myItem(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:BattleTreasureConteiner;
            this.uiCache.reset();
            this.myContainer.removeAllChildren();
            this.itemAry = _arg_1.split(",");
            if (this.itemAry.length > 0)
            {
                _local_2 = 0;
                while (_local_2 < this.itemAry.length)
                {
                    itemSubAry = this.itemAry[_local_2].split("=");
                    _local_3 = (this.uiCache.getUI(BattleTreasureConteiner) as BattleTreasureConteiner);
                    _local_3.myItemEum = ItemEumDefine.getItemEum(this.itemSubAry[0]);
                    if (itemSubAry.length > 1)
                    {
                        _local_3.myItemNum = int(itemSubAry[1]);
                    };
                    this.myContainer.addChild(_local_3);
                    _local_2++;
                };
            };
        }


    }
}//package view.module.info.reports.ReportUi

