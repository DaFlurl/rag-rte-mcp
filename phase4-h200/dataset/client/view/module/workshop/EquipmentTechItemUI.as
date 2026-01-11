// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.workshop.EquipmentTechItemUI

package view.module.workshop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.RemainTimeLabel;
    import mx.controls.Label;
    import view.ui.EquipConditionTooltip;
    import mx.controls.Button;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.controls.Image;
    import com.evony.eum.EquipTechEum;
    import mx.core.UIComponent;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.common.beans.ItemBean;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import com.evony.eum.EquipTechEumDefine;
    import com.evony.factory.UIFactory;
    import com.evony.Lang;
    import com.evony.util.UIUtil;
    import view.ui.AlertWin;
    import view.ui.DescribeTooltip;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.ItemEum;
    import com.evony.eum.ItemEumDefine;
    import flash.display.MovieClip;
    import com.evony.common.constants.EquipmentTech;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import view.ui.AddFundWin;
    import com.evony.util.ConditionItem;
    import com.evony.client.response.ResponseDispatcher;
    import mx.managers.PopUpManager;
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

    public class EquipmentTechItemUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1392317494updateBtnEnable:Boolean = true;
        public var _EquipmentTechItemUI_RemainTimeLabel1:RemainTimeLabel;
        private var updataItemFlag:Boolean;
        private var _1438160526techLevel:Label;
        private var _676507419typeName:Label;
        private var _2048960604researchBtnEnable:Boolean = true;
        private var itemFlag:Boolean;
        private var _410464834imgSource:String;
        private var buyFlag:Boolean;
        private var _1312137351researchBtnVisable:Boolean = true;
        private var tips:EquipConditionTooltip;
        private var buildingFlag:Boolean;
        private var _2116187592itemMes:String;
        public var _EquipmentTechItemUI_Button2:Button;
        private var itemNeedArr:Array;
        private var _1264110255isCanUpdate:Boolean = false;
        private var _416160449researchBtn:Button;
        private var _107037lev:int;
        private var _1525956411_techBean:AvailableResearchListBean;
        public var _EquipmentTechItemUI_Image1:Image;
        private var equipTechEumTem:EquipTechEum;
        private var _3732ui:UIComponent;
        private var _id:int;
        private var _1177331774itemName:String;
        private var _1075075072equipBean:AvailableResearchListBean;
        private var _techTypeId:int;
        private var equipTechEum:EquipTechEum;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":350,
                    "height":130,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_EquipmentTechItemUI_Image1",
                        "events":{
                            "complete":"___EquipmentTechItemUI_Image1_complete",
                            "mouseMove":"___EquipmentTechItemUI_Image1_mouseMove",
                            "mouseOver":"___EquipmentTechItemUI_Image1_mouseOver",
                            "mouseOut":"___EquipmentTechItemUI_Image1_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.left = "13";
                            this.bottom = "13";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":70,
                                "height":70,
                                "scaleContent":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"researchBtn",
                        "events":{
                            "click":"__researchBtn_click",
                            "mouseOver":"__researchBtn_mouseOver",
                            "mouseOut":"__researchBtn_mouseOut",
                            "mouseMove":"__researchBtn_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.bottom = "60";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "9";
                            this.bottom = "38";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"text":"Cooldown:"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RemainTimeLabel,
                                    "id":"_EquipmentTechItemUI_RemainTimeLabel1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":60,
                                            "callBack":endTime()
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":UIComponent,
                        "id":"ui",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseChildren":false,
                                "width":178,
                                "height":43,
                                "x":85,
                                "y":47
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_EquipmentTechItemUI_Button2",
                        "events":{"click":"___EquipmentTechItemUI_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "13";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Star",
                                "styleName":"b75",
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"typeName",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "13";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "styleName":"fontTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"techLevel",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "13";
                            this.textAlign = "left";
                            this.left = "90";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":100});
                        }
                    })]
                });
            }
        });
        private var _607881404conditionItemsArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EquipmentTechItemUI()
        {
            mx_internal::_document = this;
            this.width = 350;
            this.height = 130;
            this.styleName = "textBackgroundShopTiles";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___EquipmentTechItemUI_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EquipmentTechItemUI._watcherSetupUtil = _arg_1;
        }


        public function ___EquipmentTechItemUI_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        public function ___EquipmentTechItemUI_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        public function __researchBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut(_arg_1);
        }

        public function ___EquipmentTechItemUI_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function init():void
        {
        }

        private function shopBuyResponse(_arg_1:CommandResponse):void
        {
            var _local_3:Object;
            var _local_4:int;
            var _local_5:ItemBean;
            var _local_2:Boolean = true;
            for each (_local_3 in itemNeedArr)
            {
                _local_4 = 0;
                for each (_local_5 in Context.getInstance().getPlayerBean().itemsArray)
                {
                    if (_local_3.id == _local_5.id)
                    {
                        _local_4 = _local_5.count;
                        break;
                    };
                };
                if (_local_4 < _local_3.num)
                {
                    _local_2 = false;
                    break;
                };
            };
            if (((_local_2) && (buyFlag)))
            {
                ActionFactory.getInstance().getEquipmenttechCommands().research(Context.getInstance().getCurCastle().id, _techTypeId);
                buyFlag = false;
            };
        }

        public function setTech(_arg_1:AvailableResearchListBean):void
        {
            this._techTypeId = _arg_1.typeId;
            this.lev = _arg_1.level;
            equipBean = _arg_1;
            this.equipTechEum = EquipTechEumDefine.getEquipTechEum(((_techTypeId + "_") + lev));
            this.imgSource = equipTechEum.iconURL;
            itemName = equipTechEum.name;
            countCondition();
            setStarMc();
        }

        [Bindable(event="propertyChange")]
        private function get lev():int
        {
            return (this._107037lev);
        }

        [Bindable(event="propertyChange")]
        private function get equipBean():AvailableResearchListBean
        {
            return (this._1075075072equipBean);
        }

        private function setToolTip():void
        {
            var _local_1:String;
            var _local_2:EquipTechEum;
            var _local_3:String;
            tips = UIFactory.getInstance().getEquipConditionTooltip();
            tips.setBeanArr(conditionItemsArr);
            if (this.lev == 10)
            {
                _local_1 = ((equipTechEum.name + " ") + Lang.msg("到等级10（最高）"));
                tips.setDetail(null, _local_1, null);
            }
            else
            {
                _local_2 = EquipTechEumDefine.getEquipTechEum(((_techTypeId + "_") + (lev + 1)));
                _local_3 = (((((Lang.msg("升级") + " ") + _local_2.name) + " ") + "to lv.") + (lev + 1));
                tips.setDetail(_local_2.desc, _local_3, UIUtil.timeToString(equipBean.conditionBean.time));
            };
        }

        private function onStudy():void
        {
            AlertWin.show(Lang.msg("升级星降级提示"), sureFun);
        }

        private function onPicMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function set equipBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1075075072equipBean;
            if (_local_2 !== _arg_1)
            {
                this._1075075072equipBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipBean", _local_2, _arg_1));
            };
        }

        private function onPicMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:Object = EquipTechEumDefine.getEquipTechWiki(_techTypeId);
            DescribeTooltip.show(_local_2.name, _local_2.wikiDesc, _arg_1);
        }

        public function set ui(_arg_1:UIComponent):void
        {
            var _local_2:Object = this._3732ui;
            if (_local_2 !== _arg_1)
            {
                this._3732ui = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ui", _local_2, _arg_1));
            };
        }

        private function reSetStar(_arg_1:int):Boolean
        {
            setStarMc();
            return (false);
        }

        public function sureFun(_arg_1:Boolean):void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:int;
            var _local_5:Object;
            var _local_6:ItemEum;
            var _local_7:Object;
            var _local_8:ItemBean;
            if (_arg_1)
            {
                if (((buildingFlag) && ((!(updataItemFlag)) || (!(itemFlag)))))
                {
                    itemNeedArr = new Array();
                    if (!updataItemFlag)
                    {
                        _local_5 = new Object();
                        _local_6 = ItemEumDefine.getItemEum("equipment.tech.upgrade.book1");
                        _local_5.name = _local_6.name;
                        _local_5.id = "equipment.tech.upgrade.book1";
                        _local_5.price = _local_6.price;
                        _local_5.needNum = 1;
                        _local_5.totalPrice = _local_5.price;
                        itemNeedArr.push(_local_5);
                    };
                    for each (_local_2 in equipTechEumTem.itemArr)
                    {
                        _local_7 = new Object();
                        _local_7.current = 0;
                        _local_7.name = _local_2.name;
                        _local_7.id = _local_2.id;
                        _local_7.num = _local_2.num;
                        _local_7.price = ItemEumDefine.getItemEum(_local_7.id).price;
                        for each (_local_8 in Context.getInstance().getPlayerBean().itemsArray)
                        {
                            if (_local_8.id == _local_2.id)
                            {
                                _local_7.current = _local_8.count;
                            };
                        };
                        _local_7.needNum = (_local_7.num - _local_7.current);
                        _local_7.totalPrice = (_local_7.needNum * _local_7.price);
                        if (_local_7.needNum > 0)
                        {
                            itemNeedArr.push(_local_7);
                        };
                    };
                    _local_3 = "";
                    _local_4 = 0;
                    while (_local_4 < itemNeedArr.length)
                    {
                        _local_3 = (_local_3 + (((((itemNeedArr[_local_4].needNum + " ") + itemNeedArr[_local_4].name) + "(") + itemNeedArr[_local_4].totalPrice) + " cents) "));
                        _local_4++;
                    };
                    AlertWin.show((_local_3 + Lang.msg("购买所需物品提示")), onSure);
                }
                else
                {
                    ActionFactory.getInstance().getEquipmenttechCommands().research(Context.getInstance().getCurCastle().id, _techTypeId);
                };
            };
        }

        private function set lev(_arg_1:int):void
        {
            var _local_2:Object = this._107037lev;
            if (_local_2 !== _arg_1)
            {
                this._107037lev = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lev", _local_2, _arg_1));
            };
        }

        public function __researchBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        private function resourceReady():void
        {
            var _local_1:MovieClip = (new (Stars.getClass(("LV" + equipBean.enhancedstarlv)))() as MovieClip);
            ui.addChild(_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get updateBtnEnable():Boolean
        {
            return (this._1392317494updateBtnEnable);
        }

        [Bindable(event="propertyChange")]
        private function get itemName():String
        {
            return (this._1177331774itemName);
        }

        private function endTime():void
        {
            researchBtnEnable = true;
        }

        public function set techLevel(_arg_1:Label):void
        {
            var _local_2:Object = this._1438160526techLevel;
            if (_local_2 !== _arg_1)
            {
                this._1438160526techLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techLevel", _local_2, _arg_1));
            };
        }

        public function ___EquipmentTechItemUI_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        public function set researchBtnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2048960604researchBtnEnable;
            if (_local_2 !== _arg_1)
            {
                this._2048960604researchBtnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "researchBtnEnable", _local_2, _arg_1));
            };
        }

        public function __researchBtn_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function set isCanUpdate(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1264110255isCanUpdate;
            if (_local_2 !== _arg_1)
            {
                this._1264110255isCanUpdate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanUpdate", _local_2, _arg_1));
            };
        }

        private function onMouseOut(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.destroy();
            };
            tips = null;
        }

        private function set updateBtnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1392317494updateBtnEnable;
            if (_local_2 !== _arg_1)
            {
                this._1392317494updateBtnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBtnEnable", _local_2, _arg_1));
            };
        }

        private function set conditionItemsArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._607881404conditionItemsArr;
            if (_local_2 !== _arg_1)
            {
                this._607881404conditionItemsArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "conditionItemsArr", _local_2, _arg_1));
            };
        }

        private function set imgSource(_arg_1:String):void
        {
            var _local_2:Object = this._410464834imgSource;
            if (_local_2 !== _arg_1)
            {
                this._410464834imgSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSource", _local_2, _arg_1));
            };
        }

        private function set itemName(_arg_1:String):void
        {
            var _local_2:Object = this._1177331774itemName;
            if (_local_2 !== _arg_1)
            {
                this._1177331774itemName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get researchBtnVisable():Boolean
        {
            return (this._1312137351researchBtnVisable);
        }

        private function setStarMc():void
        {
            if (ui == null)
            {
                return;
            };
            while (ui.numChildren > 0)
            {
                ui.removeChildAt(0);
            };
            if (equipBean.enhancedstarlv != 0)
            {
                if (Stars.getInstance().ready == false)
                {
                    Stars.getInstance().funArray.push(resourceReady);
                }
                else
                {
                    resourceReady();
                };
            };
        }

        private function _EquipmentTechItemUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSource;
            _local_1 = Lang.msg("研究");
            _local_1 = this.researchBtnVisable;
            _local_1 = researchBtnEnable;
            _local_1 = this.equipBean.endTime;
            _local_1 = reSetStar(equipBean.enhancedstarlv);
            _local_1 = ((equipBean.level > 0) && (!(equipBean.typeId == EquipmentTech.MOUNTS_TECH)));
            _local_1 = itemName;
            _local_1 = ((("Lv." + equipBean.level) + "/Ct.") + equipBean.avalevel);
        }

        override public function initialize():void
        {
            var target:EquipmentTechItemUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EquipmentTechItemUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_workshop_EquipmentTechItemUIWatcherSetupUtil");
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

        public function ___EquipmentTechItemUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set _techBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1525956411_techBean;
            if (_local_2 !== _arg_1)
            {
                this._1525956411_techBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_techBean", _local_2, _arg_1));
            };
        }

        private function onSure(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:Object;
            if (_arg_1)
            {
                _local_2 = 0;
                for each (_local_3 in itemNeedArr)
                {
                    _local_2 = (_local_2 + _local_3.totalPrice);
                };
                if (_local_2 <= Context.getInstance().getPlayerBean().playerInfo.medal)
                {
                    buyItems();
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get techLevel():Label
        {
            return (this._1438160526techLevel);
        }

        private function set itemMes(_arg_1:String):void
        {
            var _local_2:Object = this._2116187592itemMes;
            if (_local_2 !== _arg_1)
            {
                this._2116187592itemMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemMes", _local_2, _arg_1));
            };
        }

        private function equipStar():void
        {
            EquipStarWin.getInstance().show(equipBean);
        }

        public function set researchBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._416160449researchBtn;
            if (_local_2 !== _arg_1)
            {
                this._416160449researchBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "researchBtn", _local_2, _arg_1));
            };
        }

        public function __researchBtn_click(_arg_1:MouseEvent):void
        {
            onStudy();
        }

        [Bindable(event="propertyChange")]
        public function get researchBtnEnable():Boolean
        {
            return (this._2048960604researchBtnEnable);
        }

        [Bindable(event="propertyChange")]
        public function get ui():UIComponent
        {
            return (this._3732ui);
        }

        [Bindable(event="propertyChange")]
        public function get isCanUpdate():Boolean
        {
            return (this._1264110255isCanUpdate);
        }

        private function onPicMouseOut():void
        {
            DescribeTooltip.hide();
        }

        [Bindable(event="propertyChange")]
        private function get conditionItemsArr():ArrayCollection
        {
            return (this._607881404conditionItemsArr);
        }

        [Bindable(event="propertyChange")]
        private function get imgSource():String
        {
            return (this._410464834imgSource);
        }

        [Bindable(event="propertyChange")]
        public function get researchBtn():Button
        {
            return (this._416160449researchBtn);
        }

        [Bindable(event="propertyChange")]
        private function get _techBean():AvailableResearchListBean
        {
            return (this._1525956411_techBean);
        }

        [Bindable(event="propertyChange")]
        private function get itemMes():String
        {
            return (this._2116187592itemMes);
        }

        private function countCondition():void
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:ConditionItem;
            var _local_5:ConditionItem;
            var _local_6:ConditionItem;
            if (equipBean.endTime == 0)
            {
                researchBtnEnable = true;
            }
            else
            {
                researchBtnEnable = false;
            };
            conditionItemsArr.removeAll();
            buildingFlag = true;
            itemFlag = true;
            updataItemFlag = true;
            if (lev == 10)
            {
                updateBtnEnable = false;
                if (((!(tips == null)) && (tips.visible == true)))
                {
                    setToolTip();
                };
                return;
            };
            this.imgSource = EquipTechEumDefine.getEquipTechEum(((_techTypeId + "_") + lev)).iconURL;
            equipTechEumTem = EquipTechEumDefine.getEquipTechEum(((_techTypeId + "_") + (lev + 1)));
            updateBtnEnable = true;
            for each (_local_1 in equipTechEumTem.buildArr)
            {
                _local_4 = ConditionItem.equipTechBuild(_local_1);
                conditionItemsArr.addItem(_local_4);
                if (((_local_4.styleName == ConditionItem.MATCH_FONT_COLOR) && (updateBtnEnable)))
                {
                    updateBtnEnable = false;
                    buildingFlag = false;
                };
            };
            for each (_local_2 in equipTechEumTem.treasureArr)
            {
                _local_5 = ConditionItem.equipTechTreasure(_local_2);
                conditionItemsArr.addItem(_local_5);
                if (((_local_5.styleName == ConditionItem.MATCH_FONT_COLOR) && (updateBtnEnable)))
                {
                    updateBtnEnable = false;
                    updataItemFlag = false;
                };
            };
            for each (_local_3 in equipTechEumTem.itemArr)
            {
                _local_6 = ConditionItem.equipTechItem(_local_3);
                conditionItemsArr.addItem(_local_6);
                if (((_local_6.styleName == ConditionItem.MATCH_FONT_COLOR) && (updateBtnEnable)))
                {
                    updateBtnEnable = false;
                    itemFlag = false;
                };
            };
            if (((!(tips == null)) && (tips.visible == true)))
            {
                setToolTip();
            };
            if (!equipBean.permition)
            {
                updateBtnEnable = false;
            };
        }

        public function set typeName(_arg_1:Label):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        private function buyItems():void
        {
            var _local_1:Object;
            buyFlag = true;
            for each (_local_1 in itemNeedArr)
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SHOP_BUY, shopBuyResponse, false, 0, true);
                ActionFactory.getInstance().getShopCommands().buy(_local_1.id, _local_1.needNum);
            };
        }

        [Bindable(event="propertyChange")]
        public function get typeName():Label
        {
            return (this._676507419typeName);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.moveToMouse(_arg_1);
            };
        }

        public function set researchBtnVisable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1312137351researchBtnVisable;
            if (_local_2 !== _arg_1)
            {
                this._1312137351researchBtnVisable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "researchBtnVisable", _local_2, _arg_1));
            };
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            setToolTip();
            tips.moveToMouse(_arg_1);
            if (tips.parent == null)
            {
                PopUpManager.addPopUp(tips, this);
            }
            else
            {
                PopUpManager.bringToFront(tips);
            };
        }

        private function _EquipmentTechItemUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSource);
            }, function (_arg_1:Object):void
            {
                _EquipmentTechItemUI_Image1.source = _arg_1;
            }, "_EquipmentTechItemUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("研究");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                researchBtn.label = _arg_1;
            }, "researchBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.researchBtnVisable);
            }, function (_arg_1:Boolean):void
            {
                researchBtn.visible = _arg_1;
            }, "researchBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (researchBtnEnable);
            }, function (_arg_1:Boolean):void
            {
                researchBtn.enabled = _arg_1;
            }, "researchBtn.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.equipBean.endTime);
            }, function (_arg_1:Number):void
            {
                _EquipmentTechItemUI_RemainTimeLabel1.remainTime = _arg_1;
            }, "_EquipmentTechItemUI_RemainTimeLabel1.remainTime");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (reSetStar(equipBean.enhancedstarlv));
            }, function (_arg_1:Boolean):void
            {
                ui.mouseEnabled = _arg_1;
            }, "ui.mouseEnabled");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((equipBean.level > 0) && (!(equipBean.typeId == EquipmentTech.MOUNTS_TECH)));
            }, function (_arg_1:Boolean):void
            {
                _EquipmentTechItemUI_Button2.enabled = _arg_1;
            }, "_EquipmentTechItemUI_Button2.enabled");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                typeName.text = _arg_1;
            }, "typeName.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((("Lv." + equipBean.level) + "/Ct.") + equipBean.avalevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                techLevel.text = _arg_1;
            }, "techLevel.text");
            result[8] = binding;
            return (result);
        }

        public function ___EquipmentTechItemUI_Button2_click(_arg_1:MouseEvent):void
        {
            equipStar();
        }


    }
}//package view.module.workshop

