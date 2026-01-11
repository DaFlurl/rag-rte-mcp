// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.BattleBackTroop

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.utils.ObjectProxy;
    import mx.containers.VBox;
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

    public class BattleBackTroop extends Canvas 
    {

        private var _787840825_backTroops:ObjectProxy;
        private var _1600496763bakTroopContainer:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"bakTroopContainer",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"percentWidth":100});
                        }
                    })]});
            }
        });
        private var bakTpAc:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(50);

        public function BattleBackTroop()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___BattleBackTroop_Canvas1_creationComplete);
        }

        [Bindable(event="propertyChange")]
        public function get bakTroopContainer():VBox
        {
            return (this._1600496763bakTroopContainer);
        }

        private function refresh():void
        {
            var _local_1:TroopInfoUi;
            this.bakTroopContainer.removeAllChildren();
            for each (_local_1 in this.bakTpAc)
            {
                this.bakTroopContainer.addChild(_local_1);
            };
        }

        public function set backTroops(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.bakTpAc.removeAll();
            this.uiCache.reset();
            this._backTroops = _arg_1;
            if ((_arg_1.troops is ArrayCollection))
            {
                _local_2 = (_arg_1.troops as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.bakTpAc.addItem(this.getTroopUI(_local_2[_local_3]));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.troops != null)
                {
                    this.bakTpAc.addItem(this.getTroopUI(_arg_1.troops));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        public function set bakTroopContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1600496763bakTroopContainer;
            if (_local_2 !== _arg_1)
            {
                this._1600496763bakTroopContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bakTroopContainer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _backTroops():ObjectProxy
        {
            return (this._787840825_backTroops);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function set _backTroops(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._787840825_backTroops;
            if (_local_2 !== _arg_1)
            {
                this._787840825_backTroops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_backTroops", _local_2, _arg_1));
            };
        }

        public function ___BattleBackTroop_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function init():void
        {
            this.refresh();
        }

        private function getTroopUI(_arg_1:Object):TroopInfoUi
        {
            var _local_2:TroopInfoUi = (uiCache.getUI(TroopInfoUi) as TroopInfoUi);
            _local_2.troopsObj = _arg_1;
            return (_local_2);
        }


    }
}//package view.module.info.reports.ReportUi

