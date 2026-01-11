// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleInfo.GoldBuyResourceWin

package view.castleInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.NumberRegulate;
    import com.evony.util.EvonyImage;
    import mx.controls.Label;
    import com.evony.common.beans.BuyResourceBean;
    import mx.controls.Button;
    import com.evony.common.beans.PlayerInfoBean;
    import view.module.market.WalletShowAll;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import flash.utils.getDefinitionByName;
    import view.ui.AddFundWin;
    import com.evony.common.module.shop.BuyResourceInfoResponse;
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

    public class GoldBuyResourceWin extends Canvas implements IBindingClient 
    {

        public static var instance:GoldBuyResourceWin = new (GoldBuyResourceWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1792883427woodInput:NumberRegulate;
        public var _GoldBuyResourceWin_EvonyImage1:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage2:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage3:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage4:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage5:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage6:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage7:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage8:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage9:EvonyImage;
        public var _GoldBuyResourceWin_Label5:Label;
        public var _GoldBuyResourceWin_Label7:Label;
        public var _GoldBuyResourceWin_Label9:Label;
        private var _995185281buyStone:int;
        public var _GoldBuyResourceWin_Label1:Label;
        public var _GoldBuyResourceWin_Label3:Label;
        private var _1719988691goldBuyWood:int;
        private var _1130928628foodInput:NumberRegulate;
        private var _1624118951remainStone:int;
        public var _GoldBuyResourceWin_Label10:Label;
        public var _GoldBuyResourceWin_Label11:Label;
        public var _GoldBuyResourceWin_Label12:Label;
        public var _GoldBuyResourceWin_Label14:Label;
        public var _GoldBuyResourceWin_Label15:Label;
        public var _GoldBuyResourceWin_Label16:Label;
        public var _GoldBuyResourceWin_Label18:Label;
        public var _GoldBuyResourceWin_Label19:Label;
        private var _1038569502ironInput:NumberRegulate;
        private var _1327746692buyResourceBean:BuyResourceBean;
        private var _1194142954remainFood:int;
        private var _245106259buyWood:int;
        private var _390907635maxMadel:int;
        public var _GoldBuyResourceWin_Label20:Label;
        public var _GoldBuyResourceWin_Label22:Label;
        public var _GoldBuyResourceWin_Label23:Label;
        public var _GoldBuyResourceWin_Label24:Label;
        private var _1719574510goldBuyIron:int;
        public var _GoldBuyResourceWin_Label26:Label;
        public var _GoldBuyResourceWin_Label27:Label;
        private var _300268368useMadel:int;
        public var _GoldBuyResourceWin_Button1:Button;
        public var _GoldBuyResourceWin_Button2:Button;
        private var _1719482244goldBuyFood:int;
        private var _1646388837stoneInput:NumberRegulate;
        private var iTotalPrice:int;
        private var _244692078buyIron:int;
        private var _1194235220remainIron:int;
        private var _244599812buyFood:int;
        private var _1776497151goldBuyStone:int;
        public var _GoldBuyResourceWin_EvonyImage10:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage11:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage12:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage14:EvonyImage;
        private var _2095520559playerInfo:PlayerInfoBean;
        public var _GoldBuyResourceWin_EvonyImage16:EvonyImage;
        public var _GoldBuyResourceWin_EvonyImage13:EvonyImage;
        private var _1194649401remainWood:int;
        public var _GoldBuyResourceWin_EvonyImage15:EvonyImage;
        public var _GoldBuyResourceWin_WalletShowAll1:WalletShowAll;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":582,
                    "height":0x0200,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_GoldBuyResourceWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "81";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":75,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 50;
                                                    this.horizontalAlign = "center";
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":30,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.color = 270910;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"text":"1"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":EvonyImage,
                                                                                    "id":"_GoldBuyResourceWin_EvonyImage1",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_GoldBuyResourceWin_Label3",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                        this.color = 270910;
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":EvonyImage,
                                                                                    "id":"_GoldBuyResourceWin_EvonyImage2",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "source":"fla/dynamic/ui234.swf@food.png",
                                                                                            "width":30,
                                                                                            "height":30
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
                                                                    "height":30,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.color = 270910;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"text":"1"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":EvonyImage,
                                                                                    "id":"_GoldBuyResourceWin_EvonyImage3",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_GoldBuyResourceWin_Label5",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                        this.color = 270910;
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":EvonyImage,
                                                                                    "id":"_GoldBuyResourceWin_EvonyImage4",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "source":"fla/dynamic/ui234.swf@wood.png",
                                                                                            "width":30,
                                                                                            "height":30
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
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 50;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0.35,
                                            "y":41,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "left";
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 270910;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"text":"1"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage5",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                            this.color = 270910;
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage6",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@stone.png",
                                                                                "width":30,
                                                                                "height":30
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
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "left";
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 270910;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"text":"1"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage7",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label9",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                            this.color = 270910;
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage8",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@iron.png",
                                                                                "width":30,
                                                                                "height":30
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
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "164";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 3;
                                        this.left = "0";
                                        this.top = "0";
                                        this.right = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 3;
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage9",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label10",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "45";
                                                                            this.textAlign = "right";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage10",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "4";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@food.png",
                                                                                "height":30,
                                                                                "width":30
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":NumberRegulate,
                                                                        "id":"foodInput",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "40";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":160});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "right";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label11",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label12",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyValue3",
                                                                                "text":")"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 3;
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage11",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":NumberRegulate,
                                                                        "id":"woodInput",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "40";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":160});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label14",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "45";
                                                                            this.textAlign = "right";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage12",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@wood.png",
                                                                                "width":30,
                                                                                "height":30
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "right";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label15",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label16",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyValue3",
                                                                                "text":")"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 3;
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage13",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":NumberRegulate,
                                                                        "id":"stoneInput",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "40";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":160});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label18",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "45";
                                                                            this.textAlign = "right";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage14",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@stone.png",
                                                                                "width":30,
                                                                                "height":30
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "right";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label19",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label20",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyValue3",
                                                                                "text":")"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 3;
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage15",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":NumberRegulate,
                                                                        "id":"ironInput",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "40";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":160});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label22",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "45";
                                                                            this.textAlign = "right";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_GoldBuyResourceWin_EvonyImage16",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.right = "5";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"fla/dynamic/ui234.swf@iron.png",
                                                                                "width":30,
                                                                                "height":30
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":98});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "right";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label23",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_GoldBuyResourceWin_Label24",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue3"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"PropertyValue3",
                                                                                "text":")"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.horizontalAlign = "right";
                            this.bottom = "20";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":275,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_GoldBuyResourceWin_Button1",
                                    "events":{"click":"___GoldBuyResourceWin_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_GoldBuyResourceWin_Button2",
                                    "events":{"click":"___GoldBuyResourceWin_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_GoldBuyResourceWin_Label26",
                        "stylesFactory":function ():void
                        {
                            this.color = 0xFFFFFF;
                            this.top = "54";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":20,
                                "styleName":"contentHeader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.left = "20";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_GoldBuyResourceWin_Label27",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"winTitleFont"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WalletShowAll,
                                    "id":"_GoldBuyResourceWin_WalletShowAll1"
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___GoldBuyResourceWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "42";
                            this.top = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function GoldBuyResourceWin()
        {
            mx_internal::_document = this;
            this.width = 582;
            this.height = 0x0200;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GoldBuyResourceWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        private function onWoodChange(_arg_1:int):void
        {
            var _local_2:int = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forWood) > this.buyResourceBean.woodRemain) ? int(Math.floor((this.buyResourceBean.woodRemain / this.buyResourceBean.forWood))) : (this.maxMadel - this.useMadel));
            if (_arg_1 > _local_2)
            {
                _arg_1 = _local_2;
                this.woodInput.myText = String(_arg_1);
            };
            this.goldBuyWood = _arg_1;
            this.useMadel = _arg_1;
            this.buyWood = (this.goldBuyWood * this.buyResourceBean.forWood);
            this.remainWood = (this.buyResourceBean.woodRemain - this.buyWood);
        }

        [Bindable(event="propertyChange")]
        private function get buyFood():int
        {
            return (this._244599812buyFood);
        }

        private function set goldBuyIron(_arg_1:int):void
        {
            var _local_2:Object = this._1719574510goldBuyIron;
            if (_local_2 !== _arg_1)
            {
                this._1719574510goldBuyIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldBuyIron", _local_2, _arg_1));
            };
        }

        private function buyResourceHandle():void
        {
            if (((((!(this.foodInput.myText == "0")) || (!(this.woodInput.myText == "0"))) || (!(this.stoneInput.myText == "0"))) || (!(this.ironInput.myText == "0"))))
            {
                ActionFactory.getInstance().getShopCommands().buyResource(Context.getInstance().getCurCastle().id, goldBuyFood, goldBuyWood, goldBuyIron, goldBuyStone, buyResourceCallBack);
            }
            else
            {
                AlertWin.show(Lang.msg("您未购买资源"), null);
            };
        }

        [Bindable(event="propertyChange")]
        public function get foodInput():NumberRegulate
        {
            return (this._1130928628foodInput);
        }

        private function set goldBuyStone(_arg_1:int):void
        {
            var _local_2:Object = this._1776497151goldBuyStone;
            if (_local_2 !== _arg_1)
            {
                this._1776497151goldBuyStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldBuyStone", _local_2, _arg_1));
            };
        }

        private function _GoldBuyResourceWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("购买资源");
            _local_1 = Lang.msg("铜币");
            _local_1 = ("=" + this.buyResourceBean.forFood);
            _local_1 = Lang.msg("粮食");
            _local_1 = Lang.msg("铜币");
            _local_1 = ("=" + this.buyResourceBean.forWood);
            _local_1 = Lang.msg("木材");
            _local_1 = Lang.msg("铜币");
            _local_1 = ("=" + this.buyResourceBean.forStone);
            _local_1 = Lang.msg("石料");
            _local_1 = Lang.msg("铜币");
            _local_1 = ("=" + this.buyResourceBean.forIron);
            _local_1 = Lang.msg("铁矿");
            _local_1 = Lang.msg("铜币");
            _local_1 = this.buyFood;
            _local_1 = Lang.msg("粮食");
            _local_1 = onFoodChange;
            _local_1 = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forFood) > this.buyResourceBean.foodRemain) ? Math.floor((this.buyResourceBean.foodRemain / this.buyResourceBean.forFood)) : (this.maxMadel - this.useMadel));
            _local_1 = ("(" + Lang.msg("今日还可购买"));
            _local_1 = this.remainFood;
            _local_1 = Lang.msg("铜币");
            _local_1 = onWoodChange;
            _local_1 = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forWood) > this.buyResourceBean.woodRemain) ? Math.floor((this.buyResourceBean.woodRemain / this.buyResourceBean.forWood)) : (this.maxMadel - this.useMadel));
            _local_1 = this.buyWood;
            _local_1 = Lang.msg("木材");
            _local_1 = ("(" + Lang.msg("今日还可购买"));
            _local_1 = this.remainWood;
            _local_1 = Lang.msg("铜币");
            _local_1 = onStoneChange;
            _local_1 = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forStone) > this.buyResourceBean.stoneRemain) ? Math.floor((this.buyResourceBean.stoneRemain / this.buyResourceBean.forStone)) : (this.maxMadel - this.useMadel));
            _local_1 = this.buyStone;
            _local_1 = Lang.msg("石料");
            _local_1 = ("(" + Lang.msg("今日还可购买"));
            _local_1 = this.remainStone;
            _local_1 = Lang.msg("铜币");
            _local_1 = onIronChange;
            _local_1 = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forIron) > this.buyResourceBean.ironRemain) ? Math.floor((this.buyResourceBean.ironRemain / this.buyResourceBean.forIron)) : (this.maxMadel - this.useMadel));
            _local_1 = this.buyIron;
            _local_1 = Lang.msg("铁矿");
            _local_1 = ("(" + Lang.msg("今日还可购买"));
            _local_1 = this.remainIron;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("元宝充值");
            _local_1 = Lang.msg("资源兑换比例");
            _local_1 = (Lang.msg("帐户") + ":");
            _local_1 = this.playerInfo.medal;
        }

        private function set maxMadel(_arg_1:int):void
        {
            var _local_2:Object = this._390907635maxMadel;
            if (_local_2 !== _arg_1)
            {
                this._390907635maxMadel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxMadel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get maxMadel():int
        {
            return (this._390907635maxMadel);
        }

        private function onStoneChange(_arg_1:int):void
        {
            var _local_2:int = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forStone) > this.buyResourceBean.stoneRemain) ? int(Math.floor((this.buyResourceBean.stoneRemain / this.buyResourceBean.forStone))) : (this.maxMadel - this.useMadel));
            if (_arg_1 > _local_2)
            {
                _arg_1 = _local_2;
                this.stoneInput.myText = String(_arg_1);
            };
            this.goldBuyStone = _arg_1;
            this.useMadel = _arg_1;
            this.buyStone = (this.goldBuyStone * this.buyResourceBean.forStone);
            this.remainStone = (this.buyResourceBean.stoneRemain - this.buyStone);
        }

        public function ___GoldBuyResourceWin_Button1_click(_arg_1:MouseEvent):void
        {
            buyResourceHandle();
        }

        public function set foodInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1130928628foodInput;
            if (_local_2 !== _arg_1)
            {
                this._1130928628foodInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get goldBuyIron():int
        {
            return (this._1719574510goldBuyIron);
        }

        [Bindable(event="propertyChange")]
        public function get woodInput():NumberRegulate
        {
            return (this._1792883427woodInput);
        }

        private function _GoldBuyResourceWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label1.text = _arg_1;
            }, "_GoldBuyResourceWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage1.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage1.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("=" + this.buyResourceBean.forFood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label3.text = _arg_1;
            }, "_GoldBuyResourceWin_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("粮食");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage2.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage2.toolTip");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage3.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage3.toolTip");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("=" + this.buyResourceBean.forWood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label5.text = _arg_1;
            }, "_GoldBuyResourceWin_Label5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("木材");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage4.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage4.toolTip");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage5.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage5.toolTip");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("=" + this.buyResourceBean.forStone);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label7.text = _arg_1;
            }, "_GoldBuyResourceWin_Label7.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("石料");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage6.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage6.toolTip");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage7.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage7.toolTip");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("=" + this.buyResourceBean.forIron);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label9.text = _arg_1;
            }, "_GoldBuyResourceWin_Label9.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铁矿");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage8.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage8.toolTip");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage9.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage9.toolTip");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buyFood;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label10.text = _arg_1;
            }, "_GoldBuyResourceWin_Label10.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("粮食");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage10.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage10.toolTip");
            result[15] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onFoodChange);
            }, function (_arg_1:Function):void
            {
                foodInput.onDataChange = _arg_1;
            }, "foodInput.onDataChange");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forFood) > this.buyResourceBean.foodRemain) ? int(Math.floor((this.buyResourceBean.foodRemain / this.buyResourceBean.forFood))) : (this.maxMadel - this.useMadel));
            }, function (_arg_1:int):void
            {
                foodInput.valueMax = _arg_1;
            }, "foodInput.valueMax");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("(" + Lang.msg("今日还可购买"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label11.text = _arg_1;
            }, "_GoldBuyResourceWin_Label11.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.remainFood;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label12.text = _arg_1;
            }, "_GoldBuyResourceWin_Label12.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage11.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage11.toolTip");
            result[20] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onWoodChange);
            }, function (_arg_1:Function):void
            {
                woodInput.onDataChange = _arg_1;
            }, "woodInput.onDataChange");
            result[21] = binding;
            binding = new Binding(this, function ():int
            {
                return ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forWood) > this.buyResourceBean.woodRemain) ? int(Math.floor((this.buyResourceBean.woodRemain / this.buyResourceBean.forWood))) : (this.maxMadel - this.useMadel));
            }, function (_arg_1:int):void
            {
                woodInput.valueMax = _arg_1;
            }, "woodInput.valueMax");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buyWood;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label14.text = _arg_1;
            }, "_GoldBuyResourceWin_Label14.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("木材");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage12.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage12.toolTip");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("(" + Lang.msg("今日还可购买"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label15.text = _arg_1;
            }, "_GoldBuyResourceWin_Label15.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.remainWood;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label16.text = _arg_1;
            }, "_GoldBuyResourceWin_Label16.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage13.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage13.toolTip");
            result[27] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onStoneChange);
            }, function (_arg_1:Function):void
            {
                stoneInput.onDataChange = _arg_1;
            }, "stoneInput.onDataChange");
            result[28] = binding;
            binding = new Binding(this, function ():int
            {
                return ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forStone) > this.buyResourceBean.stoneRemain) ? int(Math.floor((this.buyResourceBean.stoneRemain / this.buyResourceBean.forStone))) : (this.maxMadel - this.useMadel));
            }, function (_arg_1:int):void
            {
                stoneInput.valueMax = _arg_1;
            }, "stoneInput.valueMax");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buyStone;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label18.text = _arg_1;
            }, "_GoldBuyResourceWin_Label18.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("石料");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage14.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage14.toolTip");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("(" + Lang.msg("今日还可购买"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label19.text = _arg_1;
            }, "_GoldBuyResourceWin_Label19.text");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.remainStone;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label20.text = _arg_1;
            }, "_GoldBuyResourceWin_Label20.text");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage15.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage15.toolTip");
            result[34] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onIronChange);
            }, function (_arg_1:Function):void
            {
                ironInput.onDataChange = _arg_1;
            }, "ironInput.onDataChange");
            result[35] = binding;
            binding = new Binding(this, function ():int
            {
                return ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forIron) > this.buyResourceBean.ironRemain) ? int(Math.floor((this.buyResourceBean.ironRemain / this.buyResourceBean.forIron))) : (this.maxMadel - this.useMadel));
            }, function (_arg_1:int):void
            {
                ironInput.valueMax = _arg_1;
            }, "ironInput.valueMax");
            result[36] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buyIron;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label22.text = _arg_1;
            }, "_GoldBuyResourceWin_Label22.text");
            result[37] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铁矿");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_EvonyImage16.toolTip = _arg_1;
            }, "_GoldBuyResourceWin_EvonyImage16.toolTip");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("(" + Lang.msg("今日还可购买"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label23.text = _arg_1;
            }, "_GoldBuyResourceWin_Label23.text");
            result[39] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.remainIron;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label24.text = _arg_1;
            }, "_GoldBuyResourceWin_Label24.text");
            result[40] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Button1.label = _arg_1;
            }, "_GoldBuyResourceWin_Button1.label");
            result[41] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("元宝充值");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Button2.label = _arg_1;
            }, "_GoldBuyResourceWin_Button2.label");
            result[42] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源兑换比例");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label26.text = _arg_1;
            }, "_GoldBuyResourceWin_Label26.text");
            result[43] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("帐户") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GoldBuyResourceWin_Label27.text = _arg_1;
            }, "_GoldBuyResourceWin_Label27.text");
            result[44] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.playerInfo.medal);
            }, function (_arg_1:int):void
            {
                _GoldBuyResourceWin_WalletShowAll1.medal = _arg_1;
            }, "_GoldBuyResourceWin_WalletShowAll1.medal");
            result[45] = binding;
            return (result);
        }

        private function set buyResourceBean(_arg_1:BuyResourceBean):void
        {
            var _local_2:Object = this._1327746692buyResourceBean;
            if (_local_2 !== _arg_1)
            {
                this._1327746692buyResourceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyResourceBean", _local_2, _arg_1));
            };
        }

        private function set buyIron(_arg_1:int):void
        {
            var _local_2:Object = this._244692078buyIron;
            if (_local_2 !== _arg_1)
            {
                this._244692078buyIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyIron", _local_2, _arg_1));
            };
        }

        private function onFoodChange(_arg_1:int):void
        {
            var _local_2:int = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forFood) > this.buyResourceBean.foodRemain) ? int(Math.floor((this.buyResourceBean.foodRemain / this.buyResourceBean.forFood))) : (this.maxMadel - this.useMadel));
            if (_arg_1 > _local_2)
            {
                _arg_1 = _local_2;
                this.foodInput.myText = String(_arg_1);
            };
            this.goldBuyFood = _arg_1;
            this.useMadel = _arg_1;
            this.buyFood = (this.goldBuyFood * this.buyResourceBean.forFood);
            this.remainFood = (this.buyResourceBean.foodRemain - this.buyFood);
        }

        private function set goldBuyFood(_arg_1:int):void
        {
            var _local_2:Object = this._1719482244goldBuyFood;
            if (_local_2 !== _arg_1)
            {
                this._1719482244goldBuyFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldBuyFood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        private function set buyStone(_arg_1:int):void
        {
            var _local_2:Object = this._995185281buyStone;
            if (_local_2 !== _arg_1)
            {
                this._995185281buyStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyStone", _local_2, _arg_1));
            };
        }

        private function buyResourceCallBack(_arg_1:CommandResponse):void
        {
            var _local_2:int;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = 0;
                _local_2 = (((this.goldBuyFood + this.goldBuyWood) + this.goldBuyStone) + this.goldBuyIron);
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameBuy", "1", _local_2, "BuyResource", "BuyResource", "BuyResource", _local_2, 1);
                };
                this.reFresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get remainWood():int
        {
            return (this._1194649401remainWood);
        }

        public function set woodInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1792883427woodInput;
            if (_local_2 !== _arg_1)
            {
                this._1792883427woodInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodInput", _local_2, _arg_1));
            };
        }

        public function ___GoldBuyResourceWin_Button2_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        [Bindable(event="propertyChange")]
        private function get buyWood():int
        {
            return (this._245106259buyWood);
        }

        private function set useMadel(_arg_1:int):void
        {
            var _local_2:Object = this._300268368useMadel;
            if (_local_2 !== _arg_1)
            {
                this._300268368useMadel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useMadel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stoneInput():NumberRegulate
        {
            return (this._1646388837stoneInput);
        }

        private function set buyFood(_arg_1:int):void
        {
            var _local_2:Object = this._244599812buyFood;
            if (_local_2 !== _arg_1)
            {
                this._244599812buyFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyFood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get remainIron():int
        {
            return (this._1194235220remainIron);
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get buyIron():int
        {
            return (this._244692078buyIron);
        }

        override public function set height(_arg_1:Number):void
        {
            super.height = _arg_1;
        }

        private function set remainWood(_arg_1:int):void
        {
            var _local_2:Object = this._1194649401remainWood;
            if (_local_2 !== _arg_1)
            {
                this._1194649401remainWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainWood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get buyStone():int
        {
            return (this._995185281buyStone);
        }

        [Bindable(event="propertyChange")]
        private function get buyResourceBean():BuyResourceBean
        {
            return (this._1327746692buyResourceBean);
        }

        override public function set width(_arg_1:Number):void
        {
            super.width = _arg_1;
        }

        override public function initialize():void
        {
            var target:GoldBuyResourceWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GoldBuyResourceWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleInfo_GoldBuyResourceWinWatcherSetupUtil");
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

        public function ___GoldBuyResourceWin_Button3_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        private function closeOwner():void
        {
            MinePopupManager.instance.removePopup();
        }

        [Bindable(event="propertyChange")]
        private function get goldBuyFood():int
        {
            return (this._1719482244goldBuyFood);
        }

        private function set goldBuyWood(_arg_1:int):void
        {
            var _local_2:Object = this._1719988691goldBuyWood;
            if (_local_2 !== _arg_1)
            {
                this._1719988691goldBuyWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldBuyWood", _local_2, _arg_1));
            };
        }

        private function rechargeHandle():void
        {
            AddFundWin.gotoPurchasePage();
        }

        [Bindable(event="propertyChange")]
        private function get useMadel():int
        {
            return (this._300268368useMadel);
        }

        private function set remainIron(_arg_1:int):void
        {
            var _local_2:Object = this._1194235220remainIron;
            if (_local_2 !== _arg_1)
            {
                this._1194235220remainIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainIron", _local_2, _arg_1));
            };
        }

        public function reFresh():void
        {
            ActionFactory.getInstance().getShopCommands().getBuyResourceInfo(Context.getInstance().getCurCastle().id, setBuyResourceInfo);
            this.maxMadel = Context.getInstance().getPlayerBean().playerInfo.medal;
            this.useMadel = 0;
            this.goldBuyFood = 0;
            this.buyFood = 0;
            this.remainFood = 0;
            this.goldBuyWood = 0;
            this.buyWood = 0;
            this.remainWood = 0;
            this.goldBuyStone = 0;
            this.buyStone = 0;
            this.remainStone = 0;
            this.goldBuyIron = 0;
            this.buyIron = 0;
            this.remainIron = 0;
            this.foodInput.myText = String(0);
            this.woodInput.myText = String(0);
            this.stoneInput.myText = String(0);
            this.ironInput.myText = String(0);
        }

        private function set buyWood(_arg_1:int):void
        {
            var _local_2:Object = this._245106259buyWood;
            if (_local_2 !== _arg_1)
            {
                this._245106259buyWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyWood", _local_2, _arg_1));
            };
        }

        public function setBuyResourceInfo(_arg_1:BuyResourceInfoResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.buyResourceBean = _arg_1.buyResourceBean;
                this.remainFood = this.buyResourceBean.foodRemain;
                this.remainWood = this.buyResourceBean.woodRemain;
                this.remainStone = this.buyResourceBean.stoneRemain;
                this.remainIron = this.buyResourceBean.ironRemain;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set remainStone(_arg_1:int):void
        {
            var _local_2:Object = this._1624118951remainStone;
            if (_local_2 !== _arg_1)
            {
                this._1624118951remainStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainStone", _local_2, _arg_1));
            };
        }

        public function set ironInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1038569502ironInput;
            if (_local_2 !== _arg_1)
            {
                this._1038569502ironInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironInput", _local_2, _arg_1));
            };
        }

        public function set stoneInput(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._1646388837stoneInput;
            if (_local_2 !== _arg_1)
            {
                this._1646388837stoneInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get goldBuyWood():int
        {
            return (this._1719988691goldBuyWood);
        }

        private function onIronChange(_arg_1:int):void
        {
            var _local_2:int = ((((this.maxMadel - this.useMadel) * this.buyResourceBean.forIron) > this.buyResourceBean.ironRemain) ? int(Math.floor((this.buyResourceBean.ironRemain / this.buyResourceBean.forIron))) : (this.maxMadel - this.useMadel));
            if (_arg_1 > _local_2)
            {
                _arg_1 = _local_2;
                this.ironInput.myText = String(_arg_1);
            };
            this.goldBuyIron = _arg_1;
            this.useMadel = _arg_1;
            this.buyIron = (this.goldBuyIron * this.buyResourceBean.forIron);
            this.remainIron = (this.buyResourceBean.ironRemain - this.buyIron);
        }

        private function set remainFood(_arg_1:int):void
        {
            var _local_2:Object = this._1194142954remainFood;
            if (_local_2 !== _arg_1)
            {
                this._1194142954remainFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainFood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get remainStone():int
        {
            return (this._1624118951remainStone);
        }

        [Bindable(event="propertyChange")]
        public function get ironInput():NumberRegulate
        {
            return (this._1038569502ironInput);
        }

        [Bindable(event="propertyChange")]
        private function get remainFood():int
        {
            return (this._1194142954remainFood);
        }

        [Bindable(event="propertyChange")]
        private function get goldBuyStone():int
        {
            return (this._1776497151goldBuyStone);
        }


    }
}//package view.castleInfo

