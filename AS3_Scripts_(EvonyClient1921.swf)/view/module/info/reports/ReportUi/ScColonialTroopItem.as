// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScColonialTroopItem

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.VBox;
    import mx.containers.FormHeading;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import view.ui.MyHRule;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
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

    public class ScColonialTroopItem extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1289920177troopContainer:VBox;
        public var _ScColonialTroopItem_FormHeading1:FormHeading;
        private var _103145323local:String;
        private var _1682502725troopObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":FormHeading,
                                    "id":"_ScColonialTroopItem_FormHeading1"
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"troopContainer"
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var troopAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ScColonialTroopItem()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___ScColonialTroopItem_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScColonialTroopItem._watcherSetupUtil = _arg_1;
        }


        public function ___ScColonialTroopItem_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get troopObj():ObjectProxy
        {
            return (this._1682502725troopObj);
        }

        [Bindable(event="propertyChange")]
        public function get troopContainer():VBox
        {
            return (this._1289920177troopContainer);
        }

        override public function initialize():void
        {
            var target:ScColonialTroopItem;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScColonialTroopItem_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_ScColonialTroopItemWatcherSetupUtil");
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

        private function getDifferentTypeUi(_arg_1:*, _arg_2:*):DifferentTypeUi
        {
            var _local_3:DifferentTypeUi = (uiCache.getUI(DifferentTypeUi) as DifferentTypeUi);
            _local_3.troopType = int(_arg_1);
            _local_3.num = _arg_2;
            return (_local_3);
        }

        private function set local(_arg_1:String):void
        {
            var _local_2:Object = this._103145323local;
            if (_local_2 !== _arg_1)
            {
                this._103145323local = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "local", _local_2, _arg_1));
            };
        }

        public function set troopContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1289920177troopContainer;
            if (_local_2 !== _arg_1)
            {
                this._1289920177troopContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopContainer", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.refresh();
        }

        public function set troop(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.troopObj = _arg_1;
            this.troopAc.removeAll();
            this.uiCache.reset();
            if ((_arg_1.troopStrType is ArrayCollection))
            {
                _local_2 = (_arg_1.troopStrType as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.troopAc.addItem(this.getDifferentTypeUi(_local_2[_local_3].typeId, _local_2[_local_3].count));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.troopStrType != null)
                {
                    this.troopAc.addItem(this.getDifferentTypeUi(_arg_1.troopStrType.typeId, _arg_1.troopStrType.count));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function refresh():void
        {
            var _local_1:DifferentTypeUi;
            this.troopContainer.removeAllChildren();
            for each (_local_1 in this.troopAc)
            {
                this.troopContainer.addChild(_local_1);
            };
        }

        [Bindable(event="propertyChange")]
        private function get local():String
        {
            return (this._103145323local);
        }

        private function _ScColonialTroopItem_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = local;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScColonialTroopItem_FormHeading1.label = _arg_1;
            }, "_ScColonialTroopItem_FormHeading1.label");
            result[0] = binding;
            return (result);
        }

        private function _ScColonialTroopItem_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = local;
        }

        public function set locatioin(_arg_1:String):void
        {
            this.local = _arg_1;
        }

        private function set troopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1682502725troopObj;
            if (_local_2 !== _arg_1)
            {
                this._1682502725troopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopObj", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

