// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.TroopDieReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.containers.VBox;
    import mx.core.UIComponentDescriptor;
    import view.ui.MyHRule;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import view.module.trainningField.TroopTypeUI;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.utils.ObjectProxy;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
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

    public class TroopDieReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TroopDieReportDetail_Text1:Text;
        private var _1562008629troopTypeContainer:VBox;
        private var _1112064572castlePos:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_TroopDieReportDetail_Text1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":10
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "styleName":"tooltipsHrule"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "id":"troopTypeContainer",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":38
                            });
                        }
                    })]});
            }
        });
        private var ac:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopDieReportDetail()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___TroopDieReportDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopDieReportDetail._watcherSetupUtil = _arg_1;
        }


        private function getTroopTypeUI(_arg_1:int, _arg_2:int):TroopTypeUI
        {
            var _local_3:TroopTypeUI = (uiCache.getUI(TroopTypeUI) as TroopTypeUI);
            _local_3.imgSrc = _arg_1;
            _local_3.amount = -(_arg_2);
            return (_local_3);
        }

        private function init():void
        {
            this.refresh();
        }

        override public function initialize():void
        {
            var target:TroopDieReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopDieReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_TroopDieReportDetailWatcherSetupUtil");
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

        private function refresh():void
        {
            var _local_1:TroopTypeUI;
            this.troopTypeContainer.removeAllChildren();
            for each (_local_1 in this.ac)
            {
                this.troopTypeContainer.addChild(_local_1);
            };
        }

        private function _TroopDieReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.castlePos + " ") + Lang.msg("库存粮食无法支付部队粮饷"));
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String):void
        {
            var _local_3:ArrayCollection;
            var _local_4:int;
            this.castlePos = _arg_2;
            this.ac.removeAll();
            this.uiCache.reset();
            if ((_arg_1.troopUnit is ArrayCollection))
            {
                _local_3 = (_arg_1.troopUnit as ArrayCollection);
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    this.ac.addItem(this.getTroopTypeUI(_local_3[_local_4].typeId, _local_3[_local_4].count));
                    _local_4++;
                };
            }
            else
            {
                this.ac.addItem(this.getTroopTypeUI(_arg_1.troopUnit.typeId, _arg_1.troopUnit.count));
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        public function set troopTypeContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1562008629troopTypeContainer;
            if (_local_2 !== _arg_1)
            {
                this._1562008629troopTypeContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopTypeContainer", _local_2, _arg_1));
            };
        }

        public function ___TroopDieReportDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _TroopDieReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.castlePos + " ") + Lang.msg("库存粮食无法支付部队粮饷"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopDieReportDetail_Text1.text = _arg_1;
            }, "_TroopDieReportDetail_Text1.text");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get troopTypeContainer():VBox
        {
            return (this._1562008629troopTypeContainer);
        }

        private function set castlePos(_arg_1:String):void
        {
            var _local_2:Object = this._1112064572castlePos;
            if (_local_2 !== _arg_1)
            {
                this._1112064572castlePos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castlePos", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get castlePos():String
        {
            return (this._1112064572castlePos);
        }


    }
}//package view.module.info.reports

