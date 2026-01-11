// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScTeachUi

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

    public class ScTeachUi extends Canvas 
    {

        private var _1917118580teachContainer:VBox;
        private var _1677239230teachObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"teachContainer"
                    })]});
            }
        });
        private var teachAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);

        public function ScTeachUi()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___ScTeachUi_Canvas1_creationComplete);
        }

        [Bindable(event="propertyChange")]
        private function get teachObj():ObjectProxy
        {
            return (this._1677239230teachObj);
        }

        [Bindable(event="propertyChange")]
        public function get teachContainer():VBox
        {
            return (this._1917118580teachContainer);
        }

        public function set teach(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.teachObj = _arg_1;
            this.teachAc.removeAll();
            this.uiCache.reset();
            if ((_arg_1.techType is ArrayCollection))
            {
                _local_2 = (_arg_1.techType as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.teachAc.addItem(this.getDifferentTypeUi(_local_2[_local_3].type, _local_2[_local_3].level));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.techType != null)
                {
                    this.teachAc.addItem(this.getDifferentTypeUi(_arg_1.techType.type, _arg_1.techType.level));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function set teachObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1677239230teachObj;
            if (_local_2 !== _arg_1)
            {
                this._1677239230teachObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "teachObj", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function getDifferentTypeUi(_arg_1:int, _arg_2:*):DifferentTypeUi
        {
            var _local_3:DifferentTypeUi = (uiCache.getUI(DifferentTypeUi) as DifferentTypeUi);
            _local_3.teachType = _arg_1;
            _local_3.num = _arg_2;
            return (_local_3);
        }

        public function ___ScTeachUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set teachContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1917118580teachContainer;
            if (_local_2 !== _arg_1)
            {
                this._1917118580teachContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "teachContainer", _local_2, _arg_1));
            };
        }

        private function refresh():void
        {
            var _local_1:DifferentTypeUi;
            this.teachContainer.removeAllChildren();
            for each (_local_1 in this.teachAc)
            {
                this.teachContainer.addChild(_local_1);
            };
        }

        private function init():void
        {
            this.refresh();
        }


    }
}//package view.module.info.reports.ReportUi

