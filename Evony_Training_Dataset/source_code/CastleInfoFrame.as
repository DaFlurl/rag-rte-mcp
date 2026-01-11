// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.CastleInfoFrame

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.castleInfo.HeroIconFile;
    import view.castleInfo.CastleColorLabel;
    import mx.controls.ToggleButtonBar;
    import mx.controls.Label;
    import mx.containers.ViewStack;
    import view.castleInfo.CityDefence;
    import mx.controls.Image;
    import view.ui.BaseTooltip;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import view.ui.FieldPositionLabel;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import com.evony.MsgDispacther;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.Context;
    import com.evony.common.beans.FortificationsBean;
    import com.evony.common.beans.TroopBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.PlayerBean;
    import view.module.herosMansion.HeroProperties;
    import view.module.playerInfo.SupportTooltip;
    import view.module.playerInfo.GoldTooltip;
    import view.module.playerInfo.PopulationTooltip;
    import view.module.playerInfo.FoodTooltip;
    import view.module.playerInfo.ResourceTooltip;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import flash.utils.setTimeout;
    import view.castle.MainFramePlayerBuff;
    import com.evony.common.beans.BuffBean;
    import mx.core.IToolTip;
    import mx.managers.ToolTipManager;
    import com.evony.Lang;
    import mx.core.Application;
    import mx.events.ToolTipEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import mx.events.FlexEvent;
    import mx.core.ClassFactory;
    import mx.binding.BindingManager;
    import mx.events.ItemClickEvent;
    import com.evony.Coordinate;
    import view.castleInfo.GoldBuyResourceWin;
    import com.evony.client.response.ResponseDispatcher;
    import flash.filters.GlowFilter;
    import mx.binding.Binding;
    import com.evony.common.constants.TFConstants;
    import com.evony.util.UIUtil;
    import flash.utils.getDefinitionByName;
    import mx.core.BitmapAsset;
    import view.castle.MainFrame;
    import com.evony.common.beans.HeroBean;
    import com.evony.util.MinePopupManager;
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

    public class CastleInfoFrame extends Canvas implements IBindingClient 
    {

        public static const onOfficeClickEvent:String = "of.onOfficeClickEvent";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1935380093mingfuIcon:HeroIconFile;
        private var _2014616922resoursePanel:Canvas;
        private var _2129441769yibingIcon:HeroIconFile;
        private var _878426819txtWood:CastleColorLabel;
        private var _910461663toushicheIcon:HeroIconFile;
        private var _1875632742changqiangbingIcon:HeroIconFile;
        private var _1464972331txtStone:CastleColorLabel;
        public var _CastleInfoFrame_Object1:Object;
        public var _CastleInfoFrame_Object2:Object;
        public var _CastleInfoFrame_Object3:Object;
        public var _CastleInfoFrame_Object4:Object;
        private var _1470228876infoTypeTbb:ToggleButtonBar;
        private var _1262035331shuilvTxt:Label;
        private var _153085257myViewstack:ViewStack;
        private var _651848398jiantaIcon:CityDefence;
        private var _342116439qingjibingIcon:HeroIconFile;
        private var _1711658824icon_huangjin:Image;
        private var _530787428icon_renkou:Image;
        private var _1661777023gunmuIcon:CityDefence;
        private var _2010565078heroPanel:Canvas;
        private var _141886224icon_mingxin2:Image;
        private var _1659295827nuzhongbinIcon:HeroIconFile;
        private var _861389505cihouIcon:HeroIconFile;
        private var _1553645460defencePanel:Canvas;
        private var _2056496550gongjianbingIcon:HeroIconFile;
        private var _1541021891leishiIcon:CityDefence;
        public var _CastleInfoFrame_Label1:Label;
        public var _CastleInfoFrame_Label3:Label;
        public var _CastleInfoFrame_Label5:Label;
        public var _CastleInfoFrame_CastleColorLabel10:CastleColorLabel;
        private var curTooltips:BaseTooltip;
        public var _CastleInfoFrame_CastleColorLabel1:CastleColorLabel;
        public var _CastleInfoFrame_CastleColorLabel3:CastleColorLabel;
        public var _CastleInfoFrame_CastleColorLabel5:CastleColorLabel;
        public var _CastleInfoFrame_CastleColorLabel7:CastleColorLabel;
        public var _CastleInfoFrame_CastleColorLabel9:CastleColorLabel;
        private var _878933266txtFood:CastleColorLabel;
        private var _1377586698buyBtn:Button;
        public var _CastleInfoFrame_DataGrid1:DataGrid;
        private var _1396581628daodunbingIcon:HeroIconFile;
        private var _878841000txtIron:CastleColorLabel;
        private var _269517512jumaIcon:CityDefence;
        private var _1085929675castleViewStack:Canvas;
        private var _917847449armyPanel:Canvas;
        private var _138021238chuangnuIcon:HeroIconFile;
        private var _672489384tiejibingIcon:HeroIconFile;
        private var _1857336202xianjinIcon:CityDefence;
        private var _1854256600mingxinTxt:Label;
        private var _114190243castleName:String = "";
        public var _CastleInfoFrame_FieldPositionLabel1:FieldPositionLabel;
        public var _CastleInfoFrame_DataGridColumn1:DataGridColumn;
        private var _262619126chongcheIcon:HeroIconFile;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":225,
                    "height":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"infoTypeTbb",
                        "events":{
                            "itemClick":"__infoTypeTbb_itemClick",
                            "toolTipShown":"__infoTypeTbb_toolTipShown"
                        },
                        "stylesFactory":function ():void
                        {
                            this.top = "174";
                            this.left = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "toolTip":"tooltip",
                                "styleName":"castleInfoToggleButtonBar",
                                "dataProvider":[_CastleInfoFrame_Object1_i(), _CastleInfoFrame_Object2_i(), _CastleInfoFrame_Object3_i(), _CastleInfoFrame_Object4_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"myViewstack",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":214,
                                "width":225,
                                "height":280,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"castleViewStack",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"castleViewStack",
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"resoursePanel",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"resoursePanel",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                    this.top = "3";
                                                    this.verticalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "x":0,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "events":{
                                                                "mouseOut":"___CastleInfoFrame_Canvas4_mouseOut",
                                                                "mouseMove":"___CastleInfoFrame_Canvas4_mouseMove",
                                                                "mouseOver":"___CastleInfoFrame_Canvas4_mouseOver"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":35,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "events":{"added":"___CastleInfoFrame_Image1_added"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalCenter = "0";
                                                                            this.left = "10";
                                                                            this.top = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"images/Controls/tab/icon_t1_1.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"_CastleInfoFrame_CastleColorLabel1",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.top = "0";
                                                                            this.left = "40";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":0});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"txtFood",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "0";
                                                                            this.right = "40";
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":1});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CastleInfoFrame_Button1_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "10";
                                                                            this.bottom = "10";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"AddProperty"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/line.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "events":{
                                                                "mouseOut":"___CastleInfoFrame_Canvas5_mouseOut",
                                                                "mouseMove":"___CastleInfoFrame_Canvas5_mouseMove",
                                                                "mouseOver":"___CastleInfoFrame_Canvas5_mouseOver"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":35,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "events":{"added":"___CastleInfoFrame_Image3_added"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalCenter = "0";
                                                                            this.left = "10";
                                                                            this.top = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"images/Controls/tab/icon_t1_2.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"_CastleInfoFrame_CastleColorLabel3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.top = "0";
                                                                            this.left = "40";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":0});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"txtWood",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "0";
                                                                            this.right = "40";
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":1});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CastleInfoFrame_Button2_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "10";
                                                                            this.bottom = "10";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"AddProperty"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/line.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "events":{
                                                                "mouseOut":"___CastleInfoFrame_Canvas6_mouseOut",
                                                                "mouseMove":"___CastleInfoFrame_Canvas6_mouseMove",
                                                                "mouseOver":"___CastleInfoFrame_Canvas6_mouseOver"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":35,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "events":{"added":"___CastleInfoFrame_Image5_added"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalCenter = "0";
                                                                            this.left = "10";
                                                                            this.top = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"images/Controls/tab/icon_t1_3.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"_CastleInfoFrame_CastleColorLabel5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.top = "0";
                                                                            this.left = "40";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":0});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"txtStone",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "0";
                                                                            this.right = "40";
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":1});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CastleInfoFrame_Button3_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "10";
                                                                            this.bottom = "10";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"AddProperty"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/line.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "events":{
                                                                "mouseOut":"___CastleInfoFrame_Canvas7_mouseOut",
                                                                "mouseMove":"___CastleInfoFrame_Canvas7_mouseMove",
                                                                "mouseOver":"___CastleInfoFrame_Canvas7_mouseOver"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":35,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "events":{"added":"___CastleInfoFrame_Image7_added"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalCenter = "0";
                                                                            this.left = "10";
                                                                            this.top = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"images/Controls/tab/icon_t1_4.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"_CastleInfoFrame_CastleColorLabel7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.top = "0";
                                                                            this.left = "40";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":0});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CastleColorLabel,
                                                                        "id":"txtIron",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "0";
                                                                            this.right = "40";
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"_type":1});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CastleInfoFrame_Button4_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "10";
                                                                            this.bottom = "10";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"AddProperty"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 2;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":40,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"buyBtn",
                                                                        "events":{
                                                                            "toolTipShown":"__buyBtn_toolTipShown",
                                                                            "click":"__buyBtn_click"
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":150,
                                                                                "styleName":"tab1but"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"armyPanel",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"armyPanel",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "36";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "64";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "92";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "120";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "148";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                    this.horizontalGap = 1;
                                                    this.top = "8";
                                                    this.left = "2";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.horizontalAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"mingfuIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"cihouIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"daodunbingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"qingjibingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"nuzhongbinIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"chongcheIcon"
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.horizontalAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"yibingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"changqiangbingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"gongjianbingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"tiejibingIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"chuangnuIcon"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HeroIconFile,
                                                                        "id":"toushicheIcon"
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"defencePanel",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"defencePanel",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "39";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "75";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "111";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.top = "147";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/Controls/tab/line.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.horizontalAlign = "center";
                                                    this.top = "0";
                                                    this.left = "1";
                                                    this.verticalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":CityDefence,
                                                            "id":"xianjinIcon"
                                                        }), new UIComponentDescriptor({
                                                            "type":CityDefence,
                                                            "id":"jumaIcon"
                                                        }), new UIComponentDescriptor({
                                                            "type":CityDefence,
                                                            "id":"jiantaIcon"
                                                        }), new UIComponentDescriptor({
                                                            "type":CityDefence,
                                                            "id":"gunmuIcon"
                                                        }), new UIComponentDescriptor({
                                                            "type":CityDefence,
                                                            "id":"leishiIcon"
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"heroPanel",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"heroPanel",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_CastleInfoFrame_DataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.fontSize = 12;
                                                    this.borderStyle = "none";
                                                    this.backgroundAlpha = 0;
                                                    this.left = "7";
                                                    this.right = "10";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "showHeaders":false,
                                                        "mouseEnabled":false,
                                                        "variableRowHeight":true,
                                                        "styleName":"castleHero",
                                                        "rowHeight":32,
                                                        "height":180,
                                                        "columns":[_CastleInfoFrame_DataGridColumn1_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":25,
                                "y":18,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleInfoFrame_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"CityName",
                                                        "filters":[_CastleInfoFrame_GlowFilter1_c()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":FieldPositionLabel,
                                                "id":"_CastleInfoFrame_FieldPositionLabel1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "mouseChildren":false,
                                                        "styleName":"CityName"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "events":{
                            "mouseOut":"___CastleInfoFrame_HBox4_mouseOut",
                            "mouseMove":"___CastleInfoFrame_HBox4_mouseMove",
                            "mouseOver":"___CastleInfoFrame_HBox4_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":15,
                                "y":60,
                                "width":120,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "events":{"added":"___CastleInfoFrame_Image17_added"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/Icon/CityInfo/icon_06.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":10});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"mingxinTxt",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CastleInfoFrame_Button6_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"AddProperty"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "events":{
                            "mouseOut":"___CastleInfoFrame_HBox5_mouseOut",
                            "mouseMove":"___CastleInfoFrame_HBox5_mouseMove",
                            "mouseOver":"___CastleInfoFrame_HBox5_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":15,
                                "y":137,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"icon_renkou",
                                    "events":{"added":"__icon_renkou_added"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/Icon/CityInfo/icon_18.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":10});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleInfoFrame_Label3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyValue1",
                                            "width":70
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CastleColorLabel,
                                    "id":"_CastleInfoFrame_CastleColorLabel9",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "_type":1,
                                            "width":70
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CastleInfoFrame_Button7_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"AddProperty"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":123,
                                "y":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"icon_mingxin2",
                                    "events":{
                                        "toolTipShown":"__icon_mingxin2_toolTipShown",
                                        "complete":"__icon_mingxin2_complete"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/Icon/CityInfo/icon_08.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":10});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"shuilvTxt",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "events":{
                            "mouseOut":"___CastleInfoFrame_Canvas12_mouseOut",
                            "mouseMove":"___CastleInfoFrame_Canvas12_mouseMove",
                            "mouseOver":"___CastleInfoFrame_Canvas12_mouseOver"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":15,
                                "y":97,
                                "width":220,
                                "height":35,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"icon_huangjin",
                                    "events":{"added":"__icon_huangjin_added"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/Icon/CityInfo/icon_16.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleInfoFrame_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "42";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CastleColorLabel,
                                    "id":"_CastleInfoFrame_CastleColorLabel10",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.bottom = "0";
                                        this.right = "47";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "_type":1,
                                            "width":60
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CastleInfoFrame_Button8_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "22";
                                        this.top = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"AddProperty"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.top = "95";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/sepLine.png",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.top = "135";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/sepLine.png",
                                "percentWidth":100
                            });
                        }
                    })]
                });
            }
        });
        private var dispatcher:MsgDispacther = MsgDispacther.getInstance();
        private var _250546835_resource:CastleResourceBean = Context.getInstance().getCurCastle().resource;
        private var _1472639233_fortifications:FortificationsBean = Context.getInstance().getCurCastle().fortification;
        private var _1843183744_troops:TroopBean = Context.getInstance().getCurCastle().troop;
        private var _137063489_herosArray:ArrayCollection = new ArrayCollection();
        private var _691506344curCastle:CastleBean = Context.getInstance().getCurCastle();
        private var _1722718208_player:PlayerBean = Context.getInstance().getPlayerBean();
        private var heroProperty:HeroProperties = new HeroProperties();
        private var supportTooltip:SupportTooltip = new SupportTooltip();
        private var goldTooltip:GoldTooltip = new GoldTooltip();
        private var populationTooltip:PopulationTooltip = new PopulationTooltip();
        private var foodTooltip:FoodTooltip = new FoodTooltip();
        private var woodTooltip:ResourceTooltip = new ResourceTooltip();
        private var stoneTooltip:ResourceTooltip = new ResourceTooltip();
        private var ironTooltip:ResourceTooltip = new ResourceTooltip();
        private var _embed_mxml_images_Controls_tab_icon_fort_png_820877980:Class = CastleInfoFrame__embed_mxml_images_Controls_tab_icon_fort_png_820877980;
        private var _embed_mxml_images_Controls_tab_icon_hero_png_940671558:Class = CastleInfoFrame__embed_mxml_images_Controls_tab_icon_hero_png_940671558;
        private var _embed_mxml_images_Controls_tab_icon_resource_png_169565306:Class = CastleInfoFrame__embed_mxml_images_Controls_tab_icon_resource_png_169565306;
        private var _embed_mxml_images_Controls_tab_icon_troops_png_541442296:Class = CastleInfoFrame__embed_mxml_images_Controls_tab_icon_troops_png_541442296;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleInfoFrame()
        {
            mx_internal::_document = this;
            this.width = 225;
            this.height = 500;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___CastleInfoFrame_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleInfoFrame._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get _player():PlayerBean
        {
            return (this._1722718208_player);
        }

        [Bindable(event="propertyChange")]
        public function get yibingIcon():HeroIconFile
        {
            return (this._2129441769yibingIcon);
        }

        public function set chongcheIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._262619126chongcheIcon;
            if (_local_2 !== _arg_1)
            {
                this._262619126chongcheIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chongcheIcon", _local_2, _arg_1));
            };
        }

        private function set _player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._1722718208_player;
            if (_local_2 !== _arg_1)
            {
                this._1722718208_player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_player", _local_2, _arg_1));
            };
        }

        public function set daodunbingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._1396581628daodunbingIcon;
            if (_local_2 !== _arg_1)
            {
                this._1396581628daodunbingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "daodunbingIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buyBtn():Button
        {
            return (this._1377586698buyBtn);
        }

        public function ___CastleInfoFrame_HBox4_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get chongcheIcon():HeroIconFile
        {
            return (this._262619126chongcheIcon);
        }

        public function set icon_mingxin2(_arg_1:Image):void
        {
            var _local_2:Object = this._141886224icon_mingxin2;
            if (_local_2 !== _arg_1)
            {
                this._141886224icon_mingxin2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon_mingxin2", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas6_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.stoneTooltip);
        }

        public function ___CastleInfoFrame_Canvas4_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        [Bindable(event="propertyChange")]
        public function get heroPanel():Canvas
        {
            return (this._2010565078heroPanel);
        }

        public function ___CastleInfoFrame_HBox5_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        [Bindable(event="propertyChange")]
        public function get mingxinTxt():Label
        {
            return (this._1854256600mingxinTxt);
        }

        private function showTooltip(_arg_1:MouseEvent, _arg_2:BaseTooltip):void
        {
            this.curTooltips = _arg_2;
            this.curTooltips.moveToMouse(_arg_1);
            this.curTooltips.refresh();
            if (!curTooltips.isPopUp)
            {
                PopUpManager.addPopUp(this.curTooltips, this);
            };
        }

        public function set heroPanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2010565078heroPanel;
            if (_local_2 !== _arg_1)
            {
                this._2010565078heroPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPanel", _local_2, _arg_1));
            };
        }

        public function set mingxinTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1854256600mingxinTxt;
            if (_local_2 !== _arg_1)
            {
                this._1854256600mingxinTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mingxinTxt", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas5_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get armyPanel():Canvas
        {
            return (this._917847449armyPanel);
        }

        public function set jiantaIcon(_arg_1:CityDefence):void
        {
            var _local_2:Object = this._651848398jiantaIcon;
            if (_local_2 !== _arg_1)
            {
                this._651848398jiantaIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jiantaIcon", _local_2, _arg_1));
            };
        }

        private function onDelayCal():void
        {
            var _local_1:ArrayCollection;
            if (this.txtFood == null)
            {
                setTimeout(onDelayCal, 200);
                return;
            };
            _local_1 = MainFramePlayerBuff.instance.bar.buffsArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (((BuffBean(_local_1[_local_2]).typeId == "HauntedCastleBuf") || (BuffBean(_local_1[_local_2]).typeId == "HauntedCastleAdvBuf")))
                {
                    this.txtFood.myText = Math.floor(((((_resource.food.increaseRate * 1.1) - _resource.troopCostFood) + Context.getInstance().getCurCastle().resource.colonyFood) + Context.getInstance().getCurCastle().resource.supplyFood));
                    this.txtWood.myText = Math.floor(((_resource.wood.increaseRate * 1.1) + Context.getInstance().getCurCastle().resource.colonyWood));
                    this.txtStone.myText = Math.floor(((_resource.stone.increaseRate * 1.1) + Context.getInstance().getCurCastle().resource.colonyStone));
                    this.txtIron.myText = Math.floor(((_resource.iron.increaseRate * 1.1) + Context.getInstance().getCurCastle().resource.colonyIron));
                    return;
                };
                _local_2++;
            };
        }

        private function onToolTipShown(_arg_1:ToolTipEvent):void
        {
            var _local_2:IToolTip;
            var _local_3:int;
            var _local_4:int;
            if (ToolTipManager.currentToolTip)
            {
                _local_2 = ToolTipManager.currentToolTip;
                if (_arg_1.currentTarget == this.infoTypeTbb)
                {
                    if (this.infoTypeTbb.contentMouseX < (this.infoTypeTbb.width * 0.25))
                    {
                        _local_2.text = Lang.msg("资源");
                    }
                    else
                    {
                        if (((this.infoTypeTbb.contentMouseX < (this.infoTypeTbb.width * 0.5)) && (this.infoTypeTbb.contentMouseX > (this.infoTypeTbb.width * 0.25))))
                        {
                            _local_2.text = Lang.msg("英雄");
                        }
                        else
                        {
                            if (((this.infoTypeTbb.contentMouseX < (this.infoTypeTbb.width * 0.75)) && (this.infoTypeTbb.contentMouseX > (this.infoTypeTbb.width * 0.5))))
                            {
                                _local_2.text = Lang.msg("军队");
                            }
                            else
                            {
                                _local_2.text = Lang.msg("城防");
                            };
                        };
                    };
                };
                _local_3 = Application.application.width;
                _local_4 = Application.application.height;
                if ((_local_2.x + _local_2.width) > _local_3)
                {
                    _local_2.x = (_local_3 - _local_2.width);
                };
                if ((_local_2.y + _local_2.height) > _local_4)
                {
                    _local_2.y = (_local_4 - _local_2.height);
                };
            };
        }

        private function hideTooltip():void
        {
            PopUpManager.removePopUp(this.curTooltips);
        }

        public function ___CastleInfoFrame_Image3_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___CastleInfoFrame_Button2_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.incWoodItemArray);
        }

        public function set leishiIcon(_arg_1:CityDefence):void
        {
            var _local_2:Object = this._1541021891leishiIcon;
            if (_local_2 !== _arg_1)
            {
                this._1541021891leishiIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leishiIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get changqiangbingIcon():HeroIconFile
        {
            return (this._1875632742changqiangbingIcon);
        }

        public function set txtWood(_arg_1:CastleColorLabel):void
        {
            var _local_2:Object = this._878426819txtWood;
            if (_local_2 !== _arg_1)
            {
                this._878426819txtWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtWood", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas6_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        [Bindable(event="propertyChange")]
        public function get _troops():TroopBean
        {
            return (this._1843183744_troops);
        }

        public function set jumaIcon(_arg_1:CityDefence):void
        {
            var _local_2:Object = this._269517512jumaIcon;
            if (_local_2 !== _arg_1)
            {
                this._269517512jumaIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jumaIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get chuangnuIcon():HeroIconFile
        {
            return (this._138021238chuangnuIcon);
        }

        public function ___CastleInfoFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set icon_huangjin(_arg_1:Image):void
        {
            var _local_2:Object = this._1711658824icon_huangjin;
            if (_local_2 !== _arg_1)
            {
                this._1711658824icon_huangjin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon_huangjin", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas12_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        public function __infoTypeTbb_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function ___CastleInfoFrame_Canvas4_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.foodTooltip);
        }

        [Bindable(event="propertyChange")]
        public function get mingfuIcon():HeroIconFile
        {
            return (this._1935380093mingfuIcon);
        }

        private function _CastleInfoFrame_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = CastleInfoFrame_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get resoursePanel():Canvas
        {
            return (this._2014616922resoursePanel);
        }

        public function set txtIron(_arg_1:CastleColorLabel):void
        {
            var _local_2:Object = this._878841000txtIron;
            if (_local_2 !== _arg_1)
            {
                this._878841000txtIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtIron", _local_2, _arg_1));
            };
        }

        public function __buyBtn_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function __icon_renkou_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___CastleInfoFrame_Button7_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.populationItemArray);
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cihouIcon():HeroIconFile
        {
            return (this._861389505cihouIcon);
        }

        [Bindable(event="propertyChange")]
        public function get myViewstack():ViewStack
        {
            return (this._153085257myViewstack);
        }

        private function _CastleInfoFrame_Object4_i():Object
        {
            var _local_1:Object = {
                "icon":_embed_mxml_images_Controls_tab_icon_fort_png_820877980,
                "toolTip":null
            };
            _CastleInfoFrame_Object4 = _local_1;
            BindingManager.executeBindings(this, "_CastleInfoFrame_Object4", _CastleInfoFrame_Object4);
            return (_local_1);
        }

        public function ___CastleInfoFrame_Canvas12_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.goldTooltip);
        }

        public function ___CastleInfoFrame_Image17_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set armyPanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._917847449armyPanel;
            if (_local_2 !== _arg_1)
            {
                this._917847449armyPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyPanel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get shuilvTxt():Label
        {
            return (this._1262035331shuilvTxt);
        }

        private function btnHandel(_arg_1:ItemClickEvent):void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            switch (_arg_1.index)
            {
                case 0:
                    myViewstack.selectedChild = this.resoursePanel;
                    return;
                case 1:
                    myViewstack.selectedChild = this.heroPanel;
                    return;
                case 2:
                    myViewstack.selectedChild = this.armyPanel;
                    return;
                case 3:
                    myViewstack.selectedChild = this.defencePanel;
                    return;
            };
        }

        public function set changqiangbingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._1875632742changqiangbingIcon;
            if (_local_2 !== _arg_1)
            {
                this._1875632742changqiangbingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changqiangbingIcon", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_HBox5_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get castleViewStack():Canvas
        {
            return (this._1085929675castleViewStack);
        }

        private function refresh():void
        {
            this.curCastle = Context.getInstance().getCurCastle();
            var _local_1:Coordinate = new Coordinate(this.curCastle.fieldId);
            castleName = (((((this.curCastle.name + "(") + _local_1.x) + ",") + _local_1.y) + ")");
            this._resource = this.curCastle.resource;
            this._fortifications = this.curCastle.fortification;
            this._troops = this.curCastle.troop;
            this._herosArray = this.curCastle.herosArray;
            this.woodTooltip._typeName = 1;
            this.stoneTooltip._typeName = 2;
            this.ironTooltip._typeName = 3;
            setTimeout(onDelayCal, 200);
        }

        private function _CastleInfoFrame_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleInfoFrame_DataGridColumn1 = _local_1;
            _local_1.itemRenderer = _CastleInfoFrame_ClassFactory1_c();
            BindingManager.executeBindings(this, "_CastleInfoFrame_DataGridColumn1", _CastleInfoFrame_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get toushicheIcon():HeroIconFile
        {
            return (this._910461663toushicheIcon);
        }

        private function set _resource(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._250546835_resource;
            if (_local_2 !== _arg_1)
            {
                this._250546835_resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_resource", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas7_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.ironTooltip);
        }

        private function showGoldBuyResourceWin():void
        {
            GoldBuyResourceWin.show();
        }

        [Bindable(event="propertyChange")]
        public function get txtFood():CastleColorLabel
        {
            return (this._878933266txtFood);
        }

        private function moveTooltip(_arg_1:MouseEvent):void
        {
            if (this.curTooltips != null)
            {
                this.curTooltips.moveToMouse(_arg_1);
            };
        }

        public function ___CastleInfoFrame_Button4_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.incIronItemArray);
        }

        public function ___CastleInfoFrame_Image5_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set mingfuIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._1935380093mingfuIcon;
            if (_local_2 !== _arg_1)
            {
                this._1935380093mingfuIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mingfuIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _fortifications():FortificationsBean
        {
            return (this._1472639233_fortifications);
        }

        public function set shuilvTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1262035331shuilvTxt;
            if (_local_2 !== _arg_1)
            {
                this._1262035331shuilvTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shuilvTxt", _local_2, _arg_1));
            };
        }

        public function set gunmuIcon(_arg_1:CityDefence):void
        {
            var _local_2:Object = this._1661777023gunmuIcon;
            if (_local_2 !== _arg_1)
            {
                this._1661777023gunmuIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gunmuIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get daodunbingIcon():HeroIconFile
        {
            return (this._1396581628daodunbingIcon);
        }

        private function _CastleInfoFrame_Object3_i():Object
        {
            var _local_1:Object = {
                "icon":_embed_mxml_images_Controls_tab_icon_troops_png_541442296,
                "toolTip":null
            };
            _CastleInfoFrame_Object3 = _local_1;
            BindingManager.executeBindings(this, "_CastleInfoFrame_Object3", _CastleInfoFrame_Object3);
            return (_local_1);
        }

        public function ___CastleInfoFrame_HBox4_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        public function set _troops(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._1843183744_troops;
            if (_local_2 !== _arg_1)
            {
                this._1843183744_troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_troops", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            trace((this.className + ".init()"));
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            myViewstack.selectedChild = this.resoursePanel;
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get icon_mingxin2():Image
        {
            return (this._141886224icon_mingxin2);
        }

        private function _CastleInfoFrame_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 0x1E0000;
            _local_1.alpha = 0.9;
            _local_1.strength = 3;
            _local_1.quality = 1;
            return (_local_1);
        }

        public function ___CastleInfoFrame_HBox4_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.supportTooltip);
        }

        public function ___CastleInfoFrame_Canvas6_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        public function set chuangnuIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._138021238chuangnuIcon;
            if (_local_2 !== _arg_1)
            {
                this._138021238chuangnuIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chuangnuIcon", _local_2, _arg_1));
            };
        }

        public function set defencePanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1553645460defencePanel;
            if (_local_2 !== _arg_1)
            {
                this._1553645460defencePanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defencePanel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get jiantaIcon():CityDefence
        {
            return (this._651848398jiantaIcon);
        }

        public function set infoTypeTbb(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._1470228876infoTypeTbb;
            if (_local_2 !== _arg_1)
            {
                this._1470228876infoTypeTbb = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoTypeTbb", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get leishiIcon():CityDefence
        {
            return (this._1541021891leishiIcon);
        }

        public function set icon_renkou(_arg_1:Image):void
        {
            var _local_2:Object = this._530787428icon_renkou;
            if (_local_2 !== _arg_1)
            {
                this._530787428icon_renkou = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon_renkou", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Button1_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.incFoodItemArray);
        }

        public function set xianjinIcon(_arg_1:CityDefence):void
        {
            var _local_2:Object = this._1857336202xianjinIcon;
            if (_local_2 !== _arg_1)
            {
                this._1857336202xianjinIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xianjinIcon", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas5_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        private function _CastleInfoFrame_Object2_i():Object
        {
            var _local_1:Object = {
                "icon":_embed_mxml_images_Controls_tab_icon_hero_png_940671558,
                "toolTip":null
            };
            _CastleInfoFrame_Object2 = _local_1;
            BindingManager.executeBindings(this, "_CastleInfoFrame_Object2", _CastleInfoFrame_Object2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get jumaIcon():CityDefence
        {
            return (this._269517512jumaIcon);
        }

        [Bindable(event="propertyChange")]
        public function get icon_huangjin():Image
        {
            return (this._1711658824icon_huangjin);
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            trace((this.className + ".onCurCastleChange() "));
            this.curCastle = Context.getInstance().getCurCastle();
            this.refresh();
        }

        public function set gongjianbingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._2056496550gongjianbingIcon;
            if (_local_2 !== _arg_1)
            {
                this._2056496550gongjianbingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gongjianbingIcon", _local_2, _arg_1));
            };
        }

        private function set castleName(_arg_1:String):void
        {
            var _local_2:Object = this._114190243castleName;
            if (_local_2 !== _arg_1)
            {
                this._114190243castleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleName", _local_2, _arg_1));
            };
        }

        public function set resoursePanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2014616922resoursePanel;
            if (_local_2 !== _arg_1)
            {
                this._2014616922resoursePanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resoursePanel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get txtWood():CastleColorLabel
        {
            return (this._878426819txtWood);
        }

        public function set tiejibingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._672489384tiejibingIcon;
            if (_local_2 !== _arg_1)
            {
                this._672489384tiejibingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tiejibingIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get txtIron():CastleColorLabel
        {
            return (this._878841000txtIron);
        }

        public function set nuzhongbinIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._1659295827nuzhongbinIcon;
            if (_local_2 !== _arg_1)
            {
                this._1659295827nuzhongbinIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nuzhongbinIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function ___CastleInfoFrame_Canvas5_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.woodTooltip);
        }

        public function __icon_mingxin2_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function __icon_huangjin_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get _resource():CastleResourceBean
        {
            return (this._250546835_resource);
        }

        public function set myViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._153085257myViewstack;
            if (_local_2 !== _arg_1)
            {
                this._153085257myViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myViewstack", _local_2, _arg_1));
            };
        }

        public function __infoTypeTbb_itemClick(_arg_1:ItemClickEvent):void
        {
            btnHandel(_arg_1);
        }

        public function ___CastleInfoFrame_Image7_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___CastleInfoFrame_Button6_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.supportItemArray);
        }

        private function set _herosArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._137063489_herosArray;
            if (_local_2 !== _arg_1)
            {
                this._137063489_herosArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_herosArray", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas7_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        [Bindable(event="propertyChange")]
        public function get gunmuIcon():CityDefence
        {
            return (this._1661777023gunmuIcon);
        }

        private function _CastleInfoFrame_Object1_i():Object
        {
            var _local_1:Object = {
                "icon":_embed_mxml_images_Controls_tab_icon_resource_png_169565306,
                "toolTip":null
            };
            _CastleInfoFrame_Object1 = _local_1;
            BindingManager.executeBindings(this, "_CastleInfoFrame_Object1", _CastleInfoFrame_Object1);
            return (_local_1);
        }

        private function _CastleInfoFrame_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (!(Context.getInstance().bVisitor));
            }, function (_arg_1:Boolean):void
            {
                infoTypeTbb.enabled = _arg_1;
            }, "infoTypeTbb.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("资源"));
            }, function (_arg_1:*):void
            {
                _CastleInfoFrame_Object1.toolTip = _arg_1;
            }, "_CastleInfoFrame_Object1.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("英雄"));
            }, function (_arg_1:*):void
            {
                _CastleInfoFrame_Object2.toolTip = _arg_1;
            }, "_CastleInfoFrame_Object2.toolTip");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("军队"));
            }, function (_arg_1:*):void
            {
                _CastleInfoFrame_Object3.toolTip = _arg_1;
            }, "_CastleInfoFrame_Object3.toolTip");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("城防"));
            }, function (_arg_1:*):void
            {
                _CastleInfoFrame_Object4.toolTip = _arg_1;
            }, "_CastleInfoFrame_Object4.toolTip");
            result[4] = binding;
            binding = new Binding(this, function ():Number
            {
                return (_resource.food.amount);
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel1.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel1.myText");
            result[5] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor((((_resource.food.increaseRate - _resource.troopCostFood) + Context.getInstance().getCurCastle().resource.colonyFood) + Context.getInstance().getCurCastle().resource.supplyFood)));
            }, function (_arg_1:Number):void
            {
                txtFood.myText = _arg_1;
            }, "txtFood.myText");
            result[6] = binding;
            binding = new Binding(this, function ():Number
            {
                return (_resource.wood.amount);
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel3.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel3.myText");
            result[7] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor((_resource.wood.increaseRate + Context.getInstance().getCurCastle().resource.colonyWood)));
            }, function (_arg_1:Number):void
            {
                txtWood.myText = _arg_1;
            }, "txtWood.myText");
            result[8] = binding;
            binding = new Binding(this, function ():Number
            {
                return (_resource.stone.amount);
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel5.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel5.myText");
            result[9] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor((_resource.stone.increaseRate + Context.getInstance().getCurCastle().resource.colonyStone)));
            }, function (_arg_1:Number):void
            {
                txtStone.myText = _arg_1;
            }, "txtStone.myText");
            result[10] = binding;
            binding = new Binding(this, function ():Number
            {
                return (_resource.iron.amount);
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel7.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel7.myText");
            result[11] = binding;
            binding = new Binding(this, function ():Number
            {
                return (Math.floor((_resource.iron.increaseRate + Context.getInstance().getCurCastle().resource.colonyIron)));
            }, function (_arg_1:Number):void
            {
                txtIron.myText = _arg_1;
            }, "txtIron.myText");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("得到更多资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buyBtn.label = _arg_1;
            }, "buyBtn.label");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(Context.getInstance().bVisitor));
            }, function (_arg_1:Boolean):void
            {
                buyBtn.enabled = _arg_1;
            }, "buyBtn.enabled");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布交易的提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buyBtn.toolTip = _arg_1;
            }, "buyBtn.toolTip");
            result[15] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.peasants);
            }, function (_arg_1:int):void
            {
                mingfuIcon.count = _arg_1;
            }, "mingfuIcon.count");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PEASANTS);
            }, function (_arg_1:int):void
            {
                mingfuIcon.soldierId = _arg_1;
            }, "mingfuIcon.soldierId");
            result[17] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.scouter);
            }, function (_arg_1:int):void
            {
                cihouIcon.count = _arg_1;
            }, "cihouIcon.count");
            result[18] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SCOUTER);
            }, function (_arg_1:int):void
            {
                cihouIcon.soldierId = _arg_1;
            }, "cihouIcon.soldierId");
            result[19] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.swordsmen);
            }, function (_arg_1:int):void
            {
                daodunbingIcon.count = _arg_1;
            }, "daodunbingIcon.count");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SWORDSMEN);
            }, function (_arg_1:int):void
            {
                daodunbingIcon.soldierId = _arg_1;
            }, "daodunbingIcon.soldierId");
            result[21] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.lightCavalry);
            }, function (_arg_1:int):void
            {
                qingjibingIcon.count = _arg_1;
            }, "qingjibingIcon.count");
            result[22] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_LIGHTCAVALRY);
            }, function (_arg_1:int):void
            {
                qingjibingIcon.soldierId = _arg_1;
            }, "qingjibingIcon.soldierId");
            result[23] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.carriage);
            }, function (_arg_1:int):void
            {
                nuzhongbinIcon.count = _arg_1;
            }, "nuzhongbinIcon.count");
            result[24] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CARRIAGE);
            }, function (_arg_1:int):void
            {
                nuzhongbinIcon.soldierId = _arg_1;
            }, "nuzhongbinIcon.soldierId");
            result[25] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.batteringRam);
            }, function (_arg_1:int):void
            {
                chongcheIcon.count = _arg_1;
            }, "chongcheIcon.count");
            result[26] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BATTERINGRAM);
            }, function (_arg_1:int):void
            {
                chongcheIcon.soldierId = _arg_1;
            }, "chongcheIcon.soldierId");
            result[27] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.militia);
            }, function (_arg_1:int):void
            {
                yibingIcon.count = _arg_1;
            }, "yibingIcon.count");
            result[28] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_MILITIA);
            }, function (_arg_1:int):void
            {
                yibingIcon.soldierId = _arg_1;
            }, "yibingIcon.soldierId");
            result[29] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.pikemen);
            }, function (_arg_1:int):void
            {
                changqiangbingIcon.count = _arg_1;
            }, "changqiangbingIcon.count");
            result[30] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PIKEMAN);
            }, function (_arg_1:int):void
            {
                changqiangbingIcon.soldierId = _arg_1;
            }, "changqiangbingIcon.soldierId");
            result[31] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.archer);
            }, function (_arg_1:int):void
            {
                gongjianbingIcon.count = _arg_1;
            }, "gongjianbingIcon.count");
            result[32] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_ARCHER);
            }, function (_arg_1:int):void
            {
                gongjianbingIcon.soldierId = _arg_1;
            }, "gongjianbingIcon.soldierId");
            result[33] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.heavyCavalry);
            }, function (_arg_1:int):void
            {
                tiejibingIcon.count = _arg_1;
            }, "tiejibingIcon.count");
            result[34] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_HEAVYCAVALRY);
            }, function (_arg_1:int):void
            {
                tiejibingIcon.soldierId = _arg_1;
            }, "tiejibingIcon.soldierId");
            result[35] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.ballista);
            }, function (_arg_1:int):void
            {
                chuangnuIcon.count = _arg_1;
            }, "chuangnuIcon.count");
            result[36] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BALLISTA);
            }, function (_arg_1:int):void
            {
                chuangnuIcon.soldierId = _arg_1;
            }, "chuangnuIcon.soldierId");
            result[37] = binding;
            binding = new Binding(this, function ():int
            {
                return (_troops.catapult);
            }, function (_arg_1:int):void
            {
                toushicheIcon.count = _arg_1;
            }, "toushicheIcon.count");
            result[38] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CATAPULT);
            }, function (_arg_1:int):void
            {
                toushicheIcon.soldierId = _arg_1;
            }, "toushicheIcon.soldierId");
            result[39] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_TRAP);
            }, function (_arg_1:int):void
            {
                xianjinIcon.defenceId = _arg_1;
            }, "xianjinIcon.defenceId");
            result[40] = binding;
            binding = new Binding(this, function ():int
            {
                return (_fortifications.trap);
            }, function (_arg_1:int):void
            {
                xianjinIcon.count = _arg_1;
            }, "xianjinIcon.count");
            result[41] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ABATIS);
            }, function (_arg_1:int):void
            {
                jumaIcon.defenceId = _arg_1;
            }, "jumaIcon.defenceId");
            result[42] = binding;
            binding = new Binding(this, function ():int
            {
                return (_fortifications.abatis);
            }, function (_arg_1:int):void
            {
                jumaIcon.count = _arg_1;
            }, "jumaIcon.count");
            result[43] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ARROWTOWER);
            }, function (_arg_1:int):void
            {
                jiantaIcon.defenceId = _arg_1;
            }, "jiantaIcon.defenceId");
            result[44] = binding;
            binding = new Binding(this, function ():int
            {
                return (_fortifications.arrowTower);
            }, function (_arg_1:int):void
            {
                jiantaIcon.count = _arg_1;
            }, "jiantaIcon.count");
            result[45] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ROLLINGLOGS);
            }, function (_arg_1:int):void
            {
                gunmuIcon.defenceId = _arg_1;
            }, "gunmuIcon.defenceId");
            result[46] = binding;
            binding = new Binding(this, function ():int
            {
                return (_fortifications.rollingLogs);
            }, function (_arg_1:int):void
            {
                gunmuIcon.count = _arg_1;
            }, "gunmuIcon.count");
            result[47] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ROCKFALL);
            }, function (_arg_1:int):void
            {
                leishiIcon.defenceId = _arg_1;
            }, "leishiIcon.defenceId");
            result[48] = binding;
            binding = new Binding(this, function ():int
            {
                return (_fortifications.rockfall);
            }, function (_arg_1:int):void
            {
                leishiIcon.count = _arg_1;
            }, "leishiIcon.count");
            result[49] = binding;
            binding = new Binding(this, function ():Object
            {
                return (_herosArray);
            }, function (_arg_1:Object):void
            {
                _CastleInfoFrame_DataGrid1.dataProvider = _arg_1;
            }, "_CastleInfoFrame_DataGrid1.dataProvider");
            result[50] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleInfoFrame_DataGridColumn1.headerText = _arg_1;
            }, "_CastleInfoFrame_DataGridColumn1.headerText");
            result[51] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleInfoFrame_Label1.text = _arg_1;
            }, "_CastleInfoFrame_Label1.text");
            result[52] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.curCastle.fieldId);
            }, function (_arg_1:int):void
            {
                _CastleInfoFrame_FieldPositionLabel1.fieldId = _arg_1;
            }, "_CastleInfoFrame_FieldPositionLabel1.fieldId");
            result[53] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((_resource.support + "/") + _resource.complaint);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                mingxinTxt.text = _arg_1;
            }, "mingxinTxt.text");
            result[54] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _resource.curPopulation;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleInfoFrame_Label3.text = _arg_1;
            }, "_CastleInfoFrame_Label3.text");
            result[55] = binding;
            binding = new Binding(this, function ():Number
            {
                return (int(((this._resource.curPopulation - this._resource.buildPeople) - this._resource.workPeople)));
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel9.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel9.myText");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("税率");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                icon_mingxin2.toolTip = _arg_1;
            }, "icon_mingxin2.toolTip");
            result[57] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (_resource.texRate + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                shuilvTxt.text = _arg_1;
            }, "shuilvTxt.text");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.gold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleInfoFrame_Label5.text = _arg_1;
            }, "_CastleInfoFrame_Label5.text");
            result[59] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((this._resource.taxIncome - this._resource.herosSalary) + this._resource.colonyGold);
            }, function (_arg_1:Number):void
            {
                _CastleInfoFrame_CastleColorLabel10.myText = _arg_1;
            }, "_CastleInfoFrame_CastleColorLabel10.myText");
            result[60] = binding;
            return (result);
        }

        public function set qingjibingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._342116439qingjibingIcon;
            if (_local_2 !== _arg_1)
            {
                this._342116439qingjibingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "qingjibingIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get infoTypeTbb():ToggleButtonBar
        {
            return (this._1470228876infoTypeTbb);
        }

        override public function initialize():void
        {
            var target:CastleInfoFrame;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleInfoFrame_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_CastleInfoFrameWatcherSetupUtil");
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
        public function get defencePanel():Canvas
        {
            return (this._1553645460defencePanel);
        }

        [Bindable(event="propertyChange")]
        public function get xianjinIcon():CityDefence
        {
            return (this._1857336202xianjinIcon);
        }

        public function set cihouIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._861389505cihouIcon;
            if (_local_2 !== _arg_1)
            {
                this._861389505cihouIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cihouIcon", _local_2, _arg_1));
            };
        }

        public function __icon_mingxin2_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function ___CastleInfoFrame_Canvas4_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        public function set castleViewStack(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1085929675castleViewStack;
            if (_local_2 !== _arg_1)
            {
                this._1085929675castleViewStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleViewStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get gongjianbingIcon():HeroIconFile
        {
            return (this._2056496550gongjianbingIcon);
        }

        private function _CastleInfoFrame_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (!(Context.getInstance().bVisitor));
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("英雄");
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("城防");
            _local_1 = _resource.food.amount;
            _local_1 = Math.floor((((_resource.food.increaseRate - _resource.troopCostFood) + Context.getInstance().getCurCastle().resource.colonyFood) + Context.getInstance().getCurCastle().resource.supplyFood));
            _local_1 = _resource.wood.amount;
            _local_1 = Math.floor((_resource.wood.increaseRate + Context.getInstance().getCurCastle().resource.colonyWood));
            _local_1 = _resource.stone.amount;
            _local_1 = Math.floor((_resource.stone.increaseRate + Context.getInstance().getCurCastle().resource.colonyStone));
            _local_1 = _resource.iron.amount;
            _local_1 = Math.floor((_resource.iron.increaseRate + Context.getInstance().getCurCastle().resource.colonyIron));
            _local_1 = Lang.msg("得到更多资源");
            _local_1 = (!(Context.getInstance().bVisitor));
            _local_1 = Lang.msg("发布交易的提示");
            _local_1 = _troops.peasants;
            _local_1 = TFConstants.T_PEASANTS;
            _local_1 = _troops.scouter;
            _local_1 = TFConstants.T_SCOUTER;
            _local_1 = _troops.swordsmen;
            _local_1 = TFConstants.T_SWORDSMEN;
            _local_1 = _troops.lightCavalry;
            _local_1 = TFConstants.T_LIGHTCAVALRY;
            _local_1 = _troops.carriage;
            _local_1 = TFConstants.T_CARRIAGE;
            _local_1 = _troops.batteringRam;
            _local_1 = TFConstants.T_BATTERINGRAM;
            _local_1 = _troops.militia;
            _local_1 = TFConstants.T_MILITIA;
            _local_1 = _troops.pikemen;
            _local_1 = TFConstants.T_PIKEMAN;
            _local_1 = _troops.archer;
            _local_1 = TFConstants.T_ARCHER;
            _local_1 = _troops.heavyCavalry;
            _local_1 = TFConstants.T_HEAVYCAVALRY;
            _local_1 = _troops.ballista;
            _local_1 = TFConstants.T_BALLISTA;
            _local_1 = _troops.catapult;
            _local_1 = TFConstants.T_CATAPULT;
            _local_1 = TFConstants.F_TRAP;
            _local_1 = _fortifications.trap;
            _local_1 = TFConstants.F_ABATIS;
            _local_1 = _fortifications.abatis;
            _local_1 = TFConstants.F_ARROWTOWER;
            _local_1 = _fortifications.arrowTower;
            _local_1 = TFConstants.F_ROLLINGLOGS;
            _local_1 = _fortifications.rollingLogs;
            _local_1 = TFConstants.F_ROCKFALL;
            _local_1 = _fortifications.rockfall;
            _local_1 = _herosArray;
            _local_1 = Lang.msg("英雄");
            _local_1 = this.curCastle.name;
            _local_1 = this.curCastle.fieldId;
            _local_1 = ((_resource.support + "/") + _resource.complaint);
            _local_1 = _resource.curPopulation;
            _local_1 = int(((this._resource.curPopulation - this._resource.buildPeople) - this._resource.workPeople));
            _local_1 = Lang.msg("税率");
            _local_1 = (_resource.texRate + "%");
            _local_1 = UIUtil.FormatInt(_resource.gold);
            _local_1 = ((this._resource.taxIncome - this._resource.herosSalary) + this._resource.colonyGold);
        }

        public function set txtStone(_arg_1:CastleColorLabel):void
        {
            var _local_2:Object = this._1464972331txtStone;
            if (_local_2 !== _arg_1)
            {
                this._1464972331txtStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtStone", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get icon_renkou():Image
        {
            return (this._530787428icon_renkou);
        }

        [Bindable(event="propertyChange")]
        public function get nuzhongbinIcon():HeroIconFile
        {
            return (this._1659295827nuzhongbinIcon);
        }

        [Bindable(event="propertyChange")]
        private function get castleName():String
        {
            return (this._114190243castleName);
        }

        public function ___CastleInfoFrame_Button3_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.incStoneItemArray);
        }

        [Bindable(event="propertyChange")]
        public function get tiejibingIcon():HeroIconFile
        {
            return (this._672489384tiejibingIcon);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
            };
        }

        [Bindable(event="propertyChange")]
        private function get _herosArray():ArrayCollection
        {
            return (this._137063489_herosArray);
        }

        public function ___CastleInfoFrame_Canvas12_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        public function set toushicheIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._910461663toushicheIcon;
            if (_local_2 !== _arg_1)
            {
                this._910461663toushicheIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toushicheIcon", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_HBox5_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1, this.populationTooltip);
        }

        [Bindable(event="propertyChange")]
        public function get qingjibingIcon():HeroIconFile
        {
            return (this._342116439qingjibingIcon);
        }

        public function set yibingIcon(_arg_1:HeroIconFile):void
        {
            var _local_2:Object = this._2129441769yibingIcon;
            if (_local_2 !== _arg_1)
            {
                this._2129441769yibingIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yibingIcon", _local_2, _arg_1));
            };
        }

        public function set txtFood(_arg_1:CastleColorLabel):void
        {
            var _local_2:Object = this._878933266txtFood;
            if (_local_2 !== _arg_1)
            {
                this._878933266txtFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtFood", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Canvas7_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get txtStone():CastleColorLabel
        {
            return (this._1464972331txtStone);
        }

        public function showHeroInfo(_arg_1:Object):void
        {
            if (!heroProperty.isPopUp)
            {
                PopUpManager.addPopUp(heroProperty, MainFrame.instance, true);
            }
            else
            {
                PopUpManager.bringToFront(heroProperty);
            };
            heroProperty._heroList = Context.getInstance().getCurCastle().herosArray;
            heroProperty._heroMes = HeroBean(_arg_1);
            MinePopupManager.instance.centerPopUp();
        }

        public function __buyBtn_click(_arg_1:MouseEvent):void
        {
            showGoldBuyResourceWin();
        }

        public function ___CastleInfoFrame_Image1_added(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function destroy():void
        {
            if (GoldBuyResourceWin.instance)
            {
                MinePopupManager.instance.removePopup();
            };
        }

        public function set buyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1377586698buyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1377586698buyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyBtn", _local_2, _arg_1));
            };
        }

        public function set _fortifications(_arg_1:FortificationsBean):void
        {
            var _local_2:Object = this._1472639233_fortifications;
            if (_local_2 !== _arg_1)
            {
                this._1472639233_fortifications = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_fortifications", _local_2, _arg_1));
            };
        }

        public function ___CastleInfoFrame_Button8_click(_arg_1:MouseEvent):void
        {
            SpeedupItemSelector.show(ItemManager.goldItemArray);
        }


    }
}//package view

