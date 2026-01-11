// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.CastleTooltip

package view.castleList
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Image;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.util.EvonyImage;
    import com.evony.common.beans.BuildingBean;
    import view.ui.FieldPositionLabel;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.MsgDispacther;
    import view.castle._BottomToolBar;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.util.UIUtil;
    import com.evony.Lang;
    import com.evony.events.BuildingChangeEvent;
    import mx.binding.Binding;
    import com.evony.common.beans.ArmyBean;
    import com.evony.Context;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.BuildingConstants;
    import flash.utils.getDefinitionByName;
    import com.evony.common.constants.ColonyConstants;
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

    public class CastleTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:CastleTooltip = new (CastleTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CastleTooltip_HBox7:HBox;
        private var _696937552hasTech:Boolean = false;
        public var _CastleTooltip_HBox8:HBox;
        private var _1421682026cityName:Label;
        private var _1403061077complaint:Label;
        public var _CastleTooltip_Image1:Image;
        public var _CastleTooltip_Image5:Image;
        public var _CastleTooltip_Image6:Image;
        public var _CastleTooltip_Image7:Image;
        private var _735092684hasColony:Boolean = false;
        private var _113836232castleBean:CastleBean;
        public var _CastleTooltip_BuildingSituation1:BuildingSituation;
        private var _1224441362hasWar:Boolean = false;
        private var _1616474266techBean:AvailableResearchListBean;
        public var _CastleTooltip_ResearchSituation1:ResearchSituation;
        private var _137644508populationValue:Label;
        private var _1443811182hasBuilding:Boolean = false;
        private var _139836828populationStyle:String;
        public var _CastleTooltip_Label10:Label;
        private var _1119313997foodValue:Label;
        private var _530787428icon_renkou:EvonyImage;
        public var _CastleTooltip_Label1:Label;
        public var _CastleTooltip_Label8:Label;
        public var _CastleTooltip_Label9:Label;
        private var _1197902024colonyInfo:String;
        private var _1946383072surportValue:Label;
        private var _982966140buildingBean:BuildingBean;
        public var _CastleTooltip_FieldPositionLabel1:FieldPositionLabel;
        private var _1121506317foodStyle:String;
        public var _CastleTooltip_HBox1:HBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.left = "5";
                            this.top = "5";
                            this.bottom = "5";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_CastleTooltip_HBox1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleTooltip_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_CastleTooltip_Image1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"cityName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":FieldPositionLabel,
                                                "id":"_CastleTooltip_FieldPositionLabel1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "mouseChildren":false,
                                                        "styleName":"contentheader1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":EvonyImage,
                                                "id":"icon_renkou",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"fla/dynamic/ui234.swf@population.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"populationValue"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":EvonyImage,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "source":"fla/dynamic/ui234.swf@food.png",
                                                        "width":32,
                                                        "height":32
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"foodValue"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":EvonyImage,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"fla/dynamic/ui234.swf@surport.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"surportValue",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tooltipsValue1"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"/",
                                                                    "styleName":"tooltipsValue1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"complaint",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tooltipsValue1"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_CastleTooltip_Image5",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_CastleTooltip_HBox7",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleTooltip_Label8",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":140});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":BuildingSituation,
                                                "id":"_CastleTooltip_BuildingSituation1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_CastleTooltip_Image6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_CastleTooltip_HBox8",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleTooltip_Label9",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":140});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResearchSituation,
                                                "id":"_CastleTooltip_ResearchSituation1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_CastleTooltip_Image7",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleTooltip_Label10",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tooltipsValue3"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
            this.addEventListener("creationComplete", ___CastleTooltip_BaseTooltip1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():CastleTooltip
        {
            return (instance);
        }


        private function set buildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._982966140buildingBean;
            if (_local_2 !== _arg_1)
            {
                this._982966140buildingBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingBean", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            MsgDispacther.getInstance().addEventListener(_BottomToolBar.EVENT_BUILDING_UPDATE, onBuildingUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, onGetResearchList);
        }

        [Bindable(event="propertyChange")]
        public function get surportValue():Label
        {
            return (this._1946383072surportValue);
        }

        [Bindable(event="propertyChange")]
        public function get populationValue():Label
        {
            return (this._137644508populationValue);
        }

        private function _CastleTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = hasColony;
            _local_1 = hasColony;
            _local_1 = colonyInfo;
            _local_1 = hasColony;
            _local_1 = hasColony;
            _local_1 = this.castleBean.name;
            _local_1 = this.castleBean.fieldId;
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.curPopulation);
            _local_1 = populationStyle;
            _local_1 = UIUtil.FormatInt(Math.ceil(this.castleBean.resource.food.amount));
            _local_1 = foodStyle;
            _local_1 = this.castleBean.resource.support;
            _local_1 = this.castleBean.resource.complaint;
            _local_1 = hasBuilding;
            _local_1 = hasBuilding;
            _local_1 = hasBuilding;
            _local_1 = hasBuilding;
            _local_1 = Lang.msg("当前建筑");
            _local_1 = this.buildingBean;
            _local_1 = hasTech;
            _local_1 = hasTech;
            _local_1 = hasTech;
            _local_1 = hasTech;
            _local_1 = Lang.msg("当前研究科技");
            _local_1 = this.techBean;
            _local_1 = hasWar;
            _local_1 = hasWar;
            _local_1 = Lang.msg("警报");
            _local_1 = hasWar;
            _local_1 = hasWar;
        }

        [Bindable(event="propertyChange")]
        private function get hasColony():Boolean
        {
            return (this._735092684hasColony);
        }

        public function set icon_renkou(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._530787428icon_renkou;
            if (_local_2 !== _arg_1)
            {
                this._530787428icon_renkou = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon_renkou", _local_2, _arg_1));
            };
        }

        public function set surportValue(_arg_1:Label):void
        {
            var _local_2:Object = this._1946383072surportValue;
            if (_local_2 !== _arg_1)
            {
                this._1946383072surportValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "surportValue", _local_2, _arg_1));
            };
        }

        public function set cityName(_arg_1:Label):void
        {
            var _local_2:Object = this._1421682026cityName;
            if (_local_2 !== _arg_1)
            {
                this._1421682026cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityName", _local_2, _arg_1));
            };
        }

        public function set populationValue(_arg_1:Label):void
        {
            var _local_2:Object = this._137644508populationValue;
            if (_local_2 !== _arg_1)
            {
                this._137644508populationValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populationValue", _local_2, _arg_1));
            };
        }

        public function set complaint(_arg_1:Label):void
        {
            var _local_2:Object = this._1403061077complaint;
            if (_local_2 !== _arg_1)
            {
                this._1403061077complaint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "complaint", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasTech():Boolean
        {
            return (this._696937552hasTech);
        }

        private function onBuildingUpdate(_arg_1:BuildingChangeEvent):void
        {
            if (_arg_1.castleId == this.castleBean.id)
            {
                this.hasBuilding = false;
            };
        }

        public function set foodValue(_arg_1:Label):void
        {
            var _local_2:Object = this._1119313997foodValue;
            if (_local_2 !== _arg_1)
            {
                this._1119313997foodValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodValue", _local_2, _arg_1));
            };
        }

        private function set hasColony(_arg_1:Boolean):void
        {
            var _local_2:Object = this._735092684hasColony;
            if (_local_2 !== _arg_1)
            {
                this._735092684hasColony = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasColony", _local_2, _arg_1));
            };
        }

        private function _CastleTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (hasColony);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox1.visible = _arg_1;
            }, "_CastleTooltip_HBox1.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasColony);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox1.includeInLayout = _arg_1;
            }, "_CastleTooltip_HBox1.includeInLayout");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = colonyInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleTooltip_Label1.text = _arg_1;
            }, "_CastleTooltip_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasColony);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image1.visible = _arg_1;
            }, "_CastleTooltip_Image1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasColony);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image1.includeInLayout = _arg_1;
            }, "_CastleTooltip_Image1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleBean.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityName.text = _arg_1;
            }, "cityName.text");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.castleBean.fieldId);
            }, function (_arg_1:int):void
            {
                _CastleTooltip_FieldPositionLabel1.fieldId = _arg_1;
            }, "_CastleTooltip_FieldPositionLabel1.fieldId");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.curPopulation);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                populationValue.text = _arg_1;
            }, "populationValue.text");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (populationStyle);
            }, function (_arg_1:Object):void
            {
                populationValue.styleName = _arg_1;
            }, "populationValue.styleName");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(Math.ceil(this.castleBean.resource.food.amount));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                foodValue.text = _arg_1;
            }, "foodValue.text");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (foodStyle);
            }, function (_arg_1:Object):void
            {
                foodValue.styleName = _arg_1;
            }, "foodValue.styleName");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleBean.resource.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                surportValue.text = _arg_1;
            }, "surportValue.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleBean.resource.complaint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                complaint.text = _arg_1;
            }, "complaint.text");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image5.visible = _arg_1;
            }, "_CastleTooltip_Image5.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image5.includeInLayout = _arg_1;
            }, "_CastleTooltip_Image5.includeInLayout");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox7.visible = _arg_1;
            }, "_CastleTooltip_HBox7.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox7.includeInLayout = _arg_1;
            }, "_CastleTooltip_HBox7.includeInLayout");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前建筑");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleTooltip_Label8.text = _arg_1;
            }, "_CastleTooltip_Label8.text");
            result[17] = binding;
            binding = new Binding(this, function ():BuildingBean
            {
                return (this.buildingBean);
            }, function (_arg_1:BuildingBean):void
            {
                _CastleTooltip_BuildingSituation1.myBuilding = _arg_1;
            }, "_CastleTooltip_BuildingSituation1.myBuilding");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image6.visible = _arg_1;
            }, "_CastleTooltip_Image6.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image6.includeInLayout = _arg_1;
            }, "_CastleTooltip_Image6.includeInLayout");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox8.visible = _arg_1;
            }, "_CastleTooltip_HBox8.visible");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_HBox8.includeInLayout = _arg_1;
            }, "_CastleTooltip_HBox8.includeInLayout");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前研究科技");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleTooltip_Label9.text = _arg_1;
            }, "_CastleTooltip_Label9.text");
            result[23] = binding;
            binding = new Binding(this, function ():AvailableResearchListBean
            {
                return (this.techBean);
            }, function (_arg_1:AvailableResearchListBean):void
            {
                _CastleTooltip_ResearchSituation1.myTechBean = _arg_1;
            }, "_CastleTooltip_ResearchSituation1.myTechBean");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasWar);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image7.visible = _arg_1;
            }, "_CastleTooltip_Image7.visible");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasWar);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Image7.includeInLayout = _arg_1;
            }, "_CastleTooltip_Image7.includeInLayout");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("警报");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleTooltip_Label10.text = _arg_1;
            }, "_CastleTooltip_Label10.text");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasWar);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Label10.visible = _arg_1;
            }, "_CastleTooltip_Label10.visible");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasWar);
            }, function (_arg_1:Boolean):void
            {
                _CastleTooltip_Label10.includeInLayout = _arg_1;
            }, "_CastleTooltip_Label10.includeInLayout");
            result[29] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get techBean():AvailableResearchListBean
        {
            return (this._1616474266techBean);
        }

        private function peace():void
        {
            var _local_1:int;
            var _local_2:ArmyBean;
            this.hasWar = false;
            if (Context.getInstance().getPlayerBean().enemyArmysArray.length > 0)
            {
                _local_1 = 0;
                while (_local_1 < Context.getInstance().getPlayerBean().enemyArmysArray.length)
                {
                    _local_2 = Context.getInstance().getPlayerBean().getEnemyArmys(_local_1);
                    if (_local_2.targetFieldId == this.castleBean.fieldId)
                    {
                        this.hasWar = true;
                        return;
                    };
                    _local_1++;
                };
            };
        }

        private function onGetResearchList(_arg_1:AvailableResearchListResponse):void
        {
            var _local_2:int;
            var _local_3:AvailableResearchListBean;
            this.hasTech = false;
            if (_arg_1.ok)
            {
                _local_2 = 0;
                while (_local_2 < _arg_1.acailableResearchBeansArray.length)
                {
                    _local_3 = (_arg_1.acailableResearchBeansArray.getItemAt(_local_2) as AvailableResearchListBean);
                    if (_local_3.upgradeing)
                    {
                        if (_local_3.castleId == this.castleBean.id)
                        {
                            this.techBean = _local_3;
                            this.hasTech = true;
                            break;
                        };
                    };
                    _local_2++;
                };
            }
            else
            {
                trace(((this.className + "onGetResearchList error: ") + _arg_1.errorMsg));
            };
        }

        [Bindable(event="propertyChange")]
        private function get populationStyle():String
        {
            return (this._139836828populationStyle);
        }

        [Bindable(event="propertyChange")]
        private function get hasBuilding():Boolean
        {
            return (this._1443811182hasBuilding);
        }

        [Bindable(event="propertyChange")]
        private function get buildingBean():BuildingBean
        {
            return (this._982966140buildingBean);
        }

        public function ___CastleTooltip_BaseTooltip1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function canResearch():void
        {
            ActionFactory.getInstance().getTechCommand().getResearchList(Context.getInstance().getCurCastle().id, onGetResearchList);
        }

        private function canBuilt():void
        {
            var _local_1:BuildingBean;
            this.hasBuilding = false;
            for each (_local_1 in this.castleBean.buildingsArray)
            {
                if (_local_1.status != BuildingConstants.STATUS_NORMAL)
                {
                    this.buildingBean = _local_1;
                    this.hasBuilding = true;
                    break;
                };
            };
        }

        override public function initialize():void
        {
            var target:CastleTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_CastleTooltipWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get cityName():Label
        {
            return (this._1421682026cityName);
        }

        private function setPopulationStyle():void
        {
            if (this.castleBean.resource.curPopulation < 1)
            {
                this.populationStyle = "tooltipsValue3";
                return;
            };
            if (int(((this.castleBean.resource.curPopulation - this.castleBean.resource.buildPeople) - this.castleBean.resource.workPeople)) > 0)
            {
                this.populationStyle = "tooltipsValue2";
            }
            else
            {
                this.populationStyle = "tooltipsValue3";
            };
        }

        [Bindable(event="propertyChange")]
        public function get icon_renkou():EvonyImage
        {
            return (this._530787428icon_renkou);
        }

        private function set hasTech(_arg_1:Boolean):void
        {
            var _local_2:Object = this._696937552hasTech;
            if (_local_2 !== _arg_1)
            {
                this._696937552hasTech = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTech", _local_2, _arg_1));
            };
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get complaint():Label
        {
            return (this._1403061077complaint);
        }

        private function showColonyInfo():void
        {
            if (this.castleBean.colonization == ColonyConstants.CASTLE_COLONIZATION_FREE)
            {
                hasColony = false;
            }
            else
            {
                if (this.castleBean.colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN)
                {
                    hasColony = true;
                    colonyInfo = "Suzerain";
                }
                else
                {
                    if (this.castleBean.colonization == ColonyConstants.CASTLE_COLONIZATION_COLONY)
                    {
                        hasColony = true;
                        colonyInfo = "Colony";
                    };
                };
            };
        }

        private function setFoodStyle():void
        {
            this.foodStyle = ((Math.floor((this.castleBean.resource.food.increaseRate - this.castleBean.resource.troopCostFood)) > 0) ? "tooltipsValue1" : "tooltipsValue3");
        }

        private function set colonyInfo(_arg_1:String):void
        {
            var _local_2:Object = this._1197902024colonyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1197902024colonyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get foodValue():Label
        {
            return (this._1119313997foodValue);
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        public function setCastleBean(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
            trace(("this.castleBean.hasEnemy:" + this.castleBean.hasEnemy));
            showColonyInfo();
            peace();
            canBuilt();
            setPopulationStyle();
            setFoodStyle();
        }

        private function set populationStyle(_arg_1:String):void
        {
            var _local_2:Object = this._139836828populationStyle;
            if (_local_2 !== _arg_1)
            {
                this._139836828populationStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populationStyle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyInfo():String
        {
            return (this._1197902024colonyInfo);
        }

        private function set techBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1616474266techBean;
            if (_local_2 !== _arg_1)
            {
                this._1616474266techBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techBean", _local_2, _arg_1));
            };
        }

        private function set hasBuilding(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1443811182hasBuilding;
            if (_local_2 !== _arg_1)
            {
                this._1443811182hasBuilding = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasBuilding", _local_2, _arg_1));
            };
        }

        private function set hasWar(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1224441362hasWar;
            if (_local_2 !== _arg_1)
            {
                this._1224441362hasWar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasWar", _local_2, _arg_1));
            };
        }

        private function set foodStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1121506317foodStyle;
            if (_local_2 !== _arg_1)
            {
                this._1121506317foodStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodStyle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get foodStyle():String
        {
            return (this._1121506317foodStyle);
        }

        [Bindable(event="propertyChange")]
        private function get hasWar():Boolean
        {
            return (this._1224441362hasWar);
        }


    }
}//package view.castleList

