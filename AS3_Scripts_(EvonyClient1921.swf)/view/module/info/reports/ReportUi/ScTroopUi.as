// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScTroopUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.utils.ObjectProxy;
    import mx.containers.VBox;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
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

    public class ScTroopUi extends Canvas 
    {

        private var _1682502725troopObj:ObjectProxy;
        private var _1289920177troopContainer:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"troopContainer"
                    })]});
            }
        });
        private var troopAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);

        public function ScTroopUi()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___ScTroopUi_Canvas1_creationComplete);
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
        private function get troopObj():ObjectProxy
        {
            return (this._1682502725troopObj);
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

        public function ___ScTroopUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get troopContainer():VBox
        {
            return (this._1289920177troopContainer);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function getDifferentTypeUi(_arg_1:*, _arg_2:*):DifferentTypeUi
        {
            var _local_3:DifferentTypeUi = (uiCache.getUI(DifferentTypeUi) as DifferentTypeUi);
            _local_3.troopType = int(_arg_1);
            _local_3.num = _arg_2;
            return (_local_3);
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


    }
}//package view.module.info.reports.ReportUi

