// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScBuildingUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.containers.VBox;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
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

    public class ScBuildingUi extends Canvas 
    {

        private var _1019543987buildContainer:VBox;
        private var _1430671447buildObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"buildContainer"
                    })]});
            }
        });
        private var buildingAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);

        public function ScBuildingUi()
        {
            mx_internal::_document = this;
        }

        private function getScBuilding(_arg_1:int, _arg_2:*):ScBuilding
        {
            var _local_3:ScBuilding = (uiCache.getUI(ScBuilding) as ScBuilding);
            _local_3.buildType = _arg_1;
            _local_3.num = _arg_2;
            return (_local_3);
        }

        private function refresh():void
        {
            var _local_1:ScBuilding;
            this.buildContainer.removeAllChildren();
            for each (_local_1 in this.buildingAc)
            {
                this.buildContainer.addChild(_local_1);
            };
        }

        public function set buildContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1019543987buildContainer;
            if (_local_2 !== _arg_1)
            {
                this._1019543987buildContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildContainer", _local_2, _arg_1));
            };
        }

        public function set building(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.buildObj = _arg_1;
            this.buildingAc.removeAll();
            this.uiCache.reset();
            if ((_arg_1.buildingType is ArrayCollection))
            {
                _local_2 = (_arg_1.buildingType as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.buildingAc.addItem(this.getScBuilding(_local_2[_local_3].type, _local_2[_local_3].levels));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.buildingType != null)
                {
                    this.buildingAc.addItem(this.getScBuilding(_arg_1.buildingType.type, _arg_1.buildingType.levels));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get buildObj():ObjectProxy
        {
            return (this._1430671447buildObj);
        }

        [Bindable(event="propertyChange")]
        public function get buildContainer():VBox
        {
            return (this._1019543987buildContainer);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function set buildObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1430671447buildObj;
            if (_local_2 !== _arg_1)
            {
                this._1430671447buildObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildObj", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.refresh();
        }


    }
}//package view.module.info.reports.ReportUi

