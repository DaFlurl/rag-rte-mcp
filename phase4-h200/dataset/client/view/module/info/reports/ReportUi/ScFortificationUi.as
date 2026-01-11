// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScFortificationUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.containers.VBox;
    import mx.utils.ObjectProxy;
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

    public class ScFortificationUi extends Canvas 
    {

        private var _1135766538fortContainer:VBox;
        private var _677253076fortObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"fortContainer"
                    })]});
            }
        });
        private var fortAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);

        public function ScFortificationUi()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___ScFortificationUi_Canvas1_creationComplete);
        }

        [Bindable(event="propertyChange")]
        private function get fortObj():ObjectProxy
        {
            return (this._677253076fortObj);
        }

        private function refresh():void
        {
            var _local_1:DifferentTypeUi;
            this.fortContainer.removeAllChildren();
            for each (_local_1 in this.fortAc)
            {
                this.fortContainer.addChild(_local_1);
            };
        }

        public function ___ScFortificationUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set fortification(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.fortObj = _arg_1;
            this.fortAc.removeAll();
            this.uiCache.reset();
            if ((_arg_1.fortificationsType is ArrayCollection))
            {
                _local_2 = (_arg_1.fortificationsType as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.fortAc.addItem(this.getDifferentTypeUi(_local_2[_local_3].typeId, _local_2[_local_3].count));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.fortificationsType != null)
                {
                    this.fortAc.addItem(this.getDifferentTypeUi(_arg_1.fortificationsType.typeId, _arg_1.fortificationsType.count));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function set fortObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._677253076fortObj;
            if (_local_2 !== _arg_1)
            {
                this._677253076fortObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortObj", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function getDifferentTypeUi(_arg_1:int, _arg_2:int):DifferentTypeUi
        {
            var _local_3:DifferentTypeUi = (uiCache.getUI(DifferentTypeUi) as DifferentTypeUi);
            _local_3.fortType = _arg_1;
            _local_3.num = _arg_2;
            return (_local_3);
        }

        [Bindable(event="propertyChange")]
        public function get fortContainer():VBox
        {
            return (this._1135766538fortContainer);
        }

        public function set fortContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1135766538fortContainer;
            if (_local_2 !== _arg_1)
            {
                this._1135766538fortContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortContainer", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.refresh();
        }


    }
}//package view.module.info.reports.ReportUi

