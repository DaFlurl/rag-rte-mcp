// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.workshop.Workshop

package view.module.workshop
{
    import view.ui.BaseBuildingWindow;
    import mx.containers.Tile;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.EquipTechEumDefine;
    import view.MainWin;
    import view.ChatFrame;
    import com.evony.common.server.events.EquipmentResearchCompleteUpdate;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import flash.events.Event;
    import com.evony.common.module.tech.AvailableResearchListResponse;
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

    public class Workshop extends BaseBuildingWindow 
    {

        public static const EVENT_SHOW:String = "Workshop.show";

        private var _817714405productContain:Tile;
        private var _632506591workShopAmount:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Tile,
                        "id":"productContain",
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.horizontalGap = 5;
                            this.top = "5";
                            this.bottom = "5";
                            this.paddingLeft = 5;
                            this.paddingTop = 5;
                            this.paddingBottom = 5;
                            this.verticalGap = 5;
                            this.left = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"auto"
                            });
                        }
                    })]});
            }
        });
        private var equipListArr:ArrayCollection = new ArrayCollection();
        private var equipListUIArr:Array = [];
        private var uiCache:UICache = new UICache(20);

        public function Workshop()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Workshop_BaseBuildingWindow1_creationComplete);
        }

        public function ___Workshop_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set workShopAmount(_arg_1:int):void
        {
            var _local_2:Object = this._632506591workShopAmount;
            if (_local_2 !== _arg_1)
            {
                this._632506591workShopAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "workShopAmount", _local_2, _arg_1));
            };
        }

        private function onEquipmentComplete(_arg_1:EquipmentResearchCompleteUpdate):void
        {
            refresh();
            var _local_2:String = String(_arg_1.typeId);
            var _local_3:String = String(_arg_1.level);
            var _local_4:* = ((((((("<FONT COLOR='#F7B70B'>" + EquipTechEumDefine.getEquipTechEum(((_local_2 + "_") + _local_3)).name) + "</FONT>") + "<FONT COLOR='#FF0000'>") + " LV ") + _local_3) + "</FONT>") + " research successfully！");
            var _local_5:* = ((((((("<FONT COLOR='#0066FF'>" + EquipTechEumDefine.getEquipTechEum(((_local_2 + "_") + _local_3)).name) + "</FONT>") + "<FONT COLOR='#FF0000'>") + " LV ") + _local_3) + "</FONT>") + " research successfully！");
            MainWin.instance.onFinishInfoMsg(_local_4);
            ChatFrame.instance.onFinishInfoMSg(_local_5);
        }

        public function set productContain(_arg_1:Tile):void
        {
            var _local_2:Object = this._817714405productContain;
            if (_local_2 !== _arg_1)
            {
                this._817714405productContain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productContain", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.EQUIPMENTTECH_CANCEL_RESEARCH, onCancelEquipment);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.EQUIPMENTTECH_RESEARCH, onResearchEquipment);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.EQUIPMENTTECH_SPEED_UP_RESEARCH, onSpeedUpEquipment);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_EQUIPMENT_RESEARCH_COMPLETE_UPDATE, onEquipmentComplete);
        }

        private function onResearchEquipment(_arg_1:ResearchResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onCancelEquipment(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refresh();
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        override public function refresh():void
        {
            ActionFactory.getInstance().getEquipmenttechCommands().getResearchList(Context.getInstance().getCurCastle().id, getListResponse);
        }

        private function setItem():void
        {
            var _local_2:EquipmentTechItemUI;
            this.productContain.removeAllChildren();
            var _local_1:int;
            while (_local_1 < equipListArr.length)
            {
                _local_2 = new EquipmentTechItemUI();
                _local_2.setTech(equipListArr[_local_1]);
                equipListUIArr.push(_local_2);
                this.productContain.addChild(_local_2);
                _local_1++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get productContain():Tile
        {
            return (this._817714405productContain);
        }

        private function onRefreshWorkshop(_arg_1:Event):void
        {
            refresh();
        }

        private function onSpeedUpEquipment(_arg_1:ResearchResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get workShopAmount():int
        {
            return (this._632506591workShopAmount);
        }

        private function refreshItem():void
        {
            var _local_1:int;
            while (_local_1 < equipListArr.length)
            {
                equipListUIArr[_local_1].setTech(equipListArr[_local_1]);
                _local_1++;
            };
        }

        private function getListResponse(_arg_1:AvailableResearchListResponse):void
        {
            this.uiCache.reset();
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                equipListArr = _arg_1.acailableResearchBeansArray;
                Context.getInstance().equipTechArr = equipListArr;
                if (equipListUIArr.length == 0)
                {
                    setItem();
                };
                refreshItem();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.module.workshop

