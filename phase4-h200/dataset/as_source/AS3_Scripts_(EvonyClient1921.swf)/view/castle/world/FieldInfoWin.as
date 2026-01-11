// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.FieldInfoWin

package view.castle.world
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.containers.VBox;
    import mx.controls.TextArea;
    import mx.controls.Text;
    import com.evony.common.beans.MapCastleBean;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import view.ui.MyHRule;
    import mx.controls.Button;
    import view.module.office.CurFieldView;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import mx.events.ToolTipEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.Context;
    import view.module.mail.MailWin;
    import com.evony.common.beans.CastleBean;
    import com.evony.MsgDispacther;
    import com.evony.events.CastleFlagEvent;
    import com.evony.common.server.events.DeclaredWarStatusChange;
    import com.evony.data.NewArmyEventData;
    import view.AllWindows;
    import view.module.trainningField.NewArmyWin;
    import com.evony.common.beans.FieldBean;
    import com.evony.Coordinate;
    import view.MainWin;
    import view.castle.TownView;
    import flash.external.ExternalInterface;
    import view.ui.TargetCount;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.constants.FieldConstants;
    import com.evony.factory.PlayerInfoTypeManager;
    import com.evony.GameConfig;
    import com.evony.common.constants.DeclaredWarConstants;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.factory.ImageManager;
    import com.evony.Lang2;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.eum.ItemEum;
    import mx.collections.ArrayCollection;
    import com.evony.common.constants.ArmyConstants;
    import flash.display.Bitmap;
    import mx.binding.Binding;
    import view.castle.Map;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.util.UIUtil;
    import com.evony.common.module.field.OtherFieldInfoResponse;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import view.ui.OtherPlayerHero;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.common.module.hero.HeroListResponse;
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

    public class FieldInfoWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const warEndTimeAdd:Number = 174600000;
        private const warDeclareEndTimeAdd:Number = 1800000;
        private var _929919998isCanTrans:Boolean;
        public var _FieldInfoWin_Image1:Image;
        private var _317024851attackBtnEnabled:Boolean;
        public var _FieldInfoWin_ButtonWithIcon1:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon2:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon4:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon5:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon6:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon7:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon8:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon9:ButtonWithIcon;
        private var _1441488458isCanPolicies:Boolean;
        private var _888791483isProtect:Boolean = false;
        private var _1499484681trickBtn:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon12:ButtonWithIcon;
        public var _FieldInfoWin_ButtonWithIcon14:ButtonWithIcon;
        private var _1265009317fieldName:String;
        public var _FieldInfoWin_ButtonWithIcon13:ButtonWithIcon;
        private var _845629382hasTrainingField:Boolean;
        private var _535325936colonyBtnVisible:Boolean = false;
        private var fieldX:int;
        private var fieldY:int;
        private var _258392604isCurField:Boolean;
        private var _999139173attackTooltip:String;
        private var _1264715435fieldDesc:String;
        private var _861252683fieldId:int;
        private var _478932236attackBtn:ButtonWithIcon;
        private var _3560110tile:Tile;
        private var _1557906322isBuildVisible:Boolean;
        private var _1013623319castleLevelName:String;
        private var _1963149530lordDesc:VBox;
        private var _946446392isCanBuild:Boolean = false;
        private var _1421975908cityDesc:TextArea;
        private var _947881436isCanAddcl:Boolean = false;
        private var _30039314isCanSend:Boolean;
        public var _FieldInfoWin_Text1:Text;
        public var _FieldInfoWin_Text2:Text;
        public var _FieldInfoWin_Text3:Text;
        public var _FieldInfoWin_Text4:Text;
        public var _FieldInfoWin_Text5:Text;
        public var _FieldInfoWin_Text6:Text;
        public var _FieldInfoWin_Text7:Text;
        private var _1846446685isMineField:Boolean;
        private var _159518068declareWarVisible:Boolean;
        private var _741149243isCanSendMail:Boolean = false;
        private var _3019696bean:MapCastleBean;
        private var _1312421877isMineCastle:Boolean;
        private var _1430683378buildBtn:ButtonWithIcon;
        private var _704142718xuanzhanTooltip:String;
        private var _1185090783imgSrc:Object;
        public var _FieldInfoWin_Label1:Label;
        public var _FieldInfoWin_Label2:Label;
        public var _FieldInfoWin_Label3:Label;
        public var _FieldInfoWin_Label4:Label;
        public var _FieldInfoWin_Label5:Label;
        public var _FieldInfoWin_Label6:Label;
        public var _FieldInfoWin_Label7:Label;
        public var _FieldInfoWin_Label8:Label;
        public var _FieldInfoWin_Label9:Label;
        private var _2036861603hasTrainingFieldTooltip:String;
        private var fieldBuildId:int;
        private var numOfIsBuilding:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":500,
                    "height":360,
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
                                    "id":"_FieldInfoWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
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
                            this.top = "20";
                            this.left = "20";
                            this.bottom = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_FieldInfoWin_Image1",
                                    "events":{"complete":"___FieldInfoWin_Image1_complete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "43";
                                        this.themeColor = 198152;
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":90
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"cityDesc",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontFamily = "Arial";
                                        this.left = "115";
                                        this.right = "20";
                                        this.top = "43";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"newGreyBackground",
                                            "height":129,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"lordDesc",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "43";
                                        this.left = "115";
                                        this.borderStyle = "solid";
                                        this.right = "20";
                                        this.verticalGap = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":136,
                                            "styleName":"newBackGroundWithBode",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "percentWidth":21,
                                                                    "height":20
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "height":20
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "percentWidth":60,
                                                                    "height":20,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "percentWidth":60,
                                                                    "height":20,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "percentWidth":60,
                                                                    "height":20
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FieldInfoWin_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":30,
                                                                    "styleName":"tableContent5"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_FieldInfoWin_Text6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent6",
                                                                    "percentWidth":60,
                                                                    "height":20,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "left";
                                        this.verticalAlign = "top";
                                        this.top = "190";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"newBackGroundWithBode",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_FieldInfoWin_Label8",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":224,
                                                        "styleName":"tableContent5"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_FieldInfoWin_Text7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"tableContent6",
                                                        "percentWidth":60,
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "x":20,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_FieldInfoWin_Label9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.top = "2";
                                                    this.bottom = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":90,
                                                        "styleName":"contentheader1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon1",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/entry.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon2",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.textAlign = "left";
                                        this.bottom = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/reconnaissance.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"attackBtn",
                                    "events":{
                                        "click":"__attackBtn_click",
                                        "toolTipShown":"__attackBtn_toolTipShown"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/attack.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon4",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon4_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "35";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/gotosend.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon5",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon5_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/transportation.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon6",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon6_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/xuanzhan.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon7",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon7_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/attack.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon8",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon8_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "11";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/Policies.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon9",
                                    "events":{
                                        "click":"___FieldInfoWin_ButtonWithIcon9_click",
                                        "toolTipShown":"___FieldInfoWin_ButtonWithIcon9_toolTipShown"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "35";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/attack.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"buildBtn",
                                    "events":{
                                        "click":"__buildBtn_click",
                                        "mouseOver":"__buildBtn_mouseOver",
                                        "mouseOut":"__buildBtn_mouseOut"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/building.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"trickBtn",
                                    "events":{
                                        "click":"__trickBtn_click",
                                        "mouseOver":"__trickBtn_mouseOver",
                                        "mouseOut":"__trickBtn_mouseOut"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/building.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon12",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon12_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "35";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/mail.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon13",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon13_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "10";
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/reconnaissance.png",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"_FieldInfoWin_ButtonWithIcon14",
                                    "events":{"click":"___FieldInfoWin_ButtonWithIcon14_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "59";
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/entry.png",
                                            "enabled":true,
                                            "height":25
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___FieldInfoWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var curFieldView:CurFieldView = new CurFieldView();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FieldInfoWin()
        {
            mx_internal::_document = this;
            this.x = 34;
            this.y = 262;
            this.width = 500;
            this.height = 360;
            this.addEventListener("creationComplete", ___FieldInfoWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FieldInfoWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get isCanTrans():Boolean
        {
            return (this._929919998isCanTrans);
        }

        private function set isCanTrans(_arg_1:Boolean):void
        {
            var _local_2:Object = this._929919998isCanTrans;
            if (_local_2 !== _arg_1)
            {
                this._929919998isCanTrans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanTrans", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get trickBtn():ButtonWithIcon
        {
            return (this._1499484681trickBtn);
        }

        public function set trickBtn(_arg_1:ButtonWithIcon):void
        {
            var _local_2:Object = this._1499484681trickBtn;
            if (_local_2 !== _arg_1)
            {
                this._1499484681trickBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trickBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get castleLevelName():String
        {
            return (this._1013623319castleLevelName);
        }

        public function set buildBtn(_arg_1:ButtonWithIcon):void
        {
            var _local_2:Object = this._1430683378buildBtn;
            if (_local_2 !== _arg_1)
            {
                this._1430683378buildBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildBtn", _local_2, _arg_1));
            };
        }

        private function set colonyBtnVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._535325936colonyBtnVisible;
            if (_local_2 !== _arg_1)
            {
                this._535325936colonyBtnVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBtnVisible", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isCanAddcl():Boolean
        {
            return (this._947881436isCanAddcl);
        }

        private function DeclaredWar(_arg_1:int):void
        {
            ActionFactory.getInstance().getCommonCommands().declaredWarAgainstPlayer(_arg_1, onDeclaredWarResponse);
        }

        public function ___FieldInfoWin_ButtonWithIcon6_click(_arg_1:MouseEvent):void
        {
            DeclaredWar(this.bean.ownerPlayerId);
        }

        private function set castleLevelName(_arg_1:String):void
        {
            var _local_2:Object = this._1013623319castleLevelName;
            if (_local_2 !== _arg_1)
            {
                this._1013623319castleLevelName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleLevelName", _local_2, _arg_1));
            };
        }

        public function __attackBtn_toolTipShown(_arg_1:ToolTipEvent):void
        {
            checkToolTip();
        }

        private function upriseResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show("Uprise successfully");
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set isCanAddcl(_arg_1:Boolean):void
        {
            var _local_2:Object = this._947881436isCanAddcl;
            if (_local_2 !== _arg_1)
            {
                this._947881436isCanAddcl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanAddcl", _local_2, _arg_1));
            };
        }

        private function set imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1185090783imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1185090783imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSrc", _local_2, _arg_1));
            };
        }

        private function getMcCastleName(_arg_1:int):String
        {
            var _local_2:* = " ";
            if (_arg_1 == 0)
            {
                _local_2 = Lang.msg("亚特兰蒂斯");
            }
            else
            {
                if (_arg_1 == 1)
                {
                    _local_2 = Lang.msg("华盛顿");
                }
                else
                {
                    if (_arg_1 == 2)
                    {
                        _local_2 = Lang.msg("紫禁城");
                    }
                    else
                    {
                        if (_arg_1 == 3)
                        {
                            _local_2 = Lang.msg("洛阳");
                        };
                    };
                };
            };
            return (_local_2);
        }

        private function onDeclaredWarResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("宣战成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set lordDesc(_arg_1:VBox):void
        {
            var _local_2:Object = this._1963149530lordDesc;
            if (_local_2 !== _arg_1)
            {
                this._1963149530lordDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lordDesc", _local_2, _arg_1));
            };
        }

        private function castleBuild():void
        {
            var _local_1:int;
            if (checkIsBuilding())
            {
                _local_1 = Context.getInstance().getCurCastle().id;
                this.isCanBuild = false;
                ActionFactory.getInstance().getCityCommands().constructCastle(_local_1, this.fieldBuildId, true);
            }
            else
            {
                AlertWin.show(Lang.msg("已在建城"), null);
            };
        }

        private function isFitCondition():Boolean
        {
            if ((((((((Context.getInstance().getCurCastle().resource.wood.amount >= 10000) && (Context.getInstance().getCurCastle().resource.food.amount >= 10000)) && (Context.getInstance().getCurCastle().resource.gold >= 10000)) && (Context.getInstance().getCurCastle().resource.stone.amount >= 10000)) && (Context.getInstance().getCurCastle().resource.iron.amount >= 10000)) && (Context.getInstance().getCurCastle().troop.peasants >= 250)) && (Context.getInstance().getPlayerBean().playerInfo.titleId >= Context.getInstance().getPlayerBean().castlesArray.length)))
            {
                return (true);
            };
            return (false);
        }

        [Bindable(event="propertyChange")]
        private function get isMineField():Boolean
        {
            return (this._1846446685isMineField);
        }

        private function onSendMail():void
        {
            MailWin.writeMailToPlayer(bean.userName);
            this.visible = false;
        }

        public function __trickBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onBuildBtnMouseOver(_arg_1);
        }

        private function onPolicies():void
        {
            PoliciesView.show(this.bean.id, bean.userName, bean.powerLevel);
        }

        private function getIsMineCastle():Boolean
        {
            var _local_3:CastleBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                _local_3 = (Context.getInstance().getPlayerBean().castlesArray[_local_2] as CastleBean);
                if (((_local_3.fieldId == this.fieldId) && (!(this.fieldId == Context.getInstance().getCurCastle().fieldId))))
                {
                    _local_1 = true;
                    break;
                };
                _local_2++;
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get isBuildVisible():Boolean
        {
            return (this._1557906322isBuildVisible);
        }

        private function setWarStatusSucess(_arg_1:DeclaredWarStatusChange):void
        {
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(Context.getInstance().getCurCastle().id, fieldId);
            MsgDispacther.getInstance().dispatchEvent(new CastleFlagEvent(_arg_1.userName, _arg_1.status));
        }

        private function onNewArmy(_arg_1:int):void
        {
            var _local_2:NewArmyEventData = new NewArmyEventData();
            _local_2.x = this.fieldX;
            _local_2.y = this.fieldY;
            _local_2.missionType = _arg_1;
            if (((tile.mapCastleBean == null) || (tile.mapCastleBean.playerLogoUrl == null)))
            {
                _local_2.isNpc = true;
            }
            else
            {
                _local_2.isNpc = false;
            };
            AllWindows.switchToFuncWindow(NewArmyWin.EVENT_SHOW, _local_2);
            this.visible = false;
        }

        private function sendCoordinatesCommand():void
        {
            ActionFactory.getInstance().getCastleSignCommand().saveCastleSignList(bean.id, fieldX, fieldY);
        }

        public function ___FieldInfoWin_ButtonWithIcon12_click(_arg_1:MouseEvent):void
        {
            onSendMail();
        }

        private function set isProtect(_arg_1:Boolean):void
        {
            var _local_2:Object = this._888791483isProtect;
            if (_local_2 !== _arg_1)
            {
                this._888791483isProtect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isProtect", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isProtect():Boolean
        {
            return (this._888791483isProtect);
        }

        private function onEnterCastle():void
        {
            var _local_4:CastleBean;
            var _local_5:CastleBean;
            var _local_6:int;
            var _local_7:FieldBean;
            var _local_8:Coordinate;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                _local_4 = (Context.getInstance().getPlayerBean().castlesArray[_local_2] as CastleBean);
                if (_local_4.fieldId == this.fieldId)
                {
                    Context.getInstance().setCurCastle(_local_4);
                    MainWin.instance.onCityInClick();
                    _local_1 = true;
                    this.visible = false;
                    break;
                };
                _local_2++;
            };
            if (_local_1)
            {
                return;
            };
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                _local_5 = Context.getInstance().getPlayerBean().castlesArray[_local_3];
                _local_6 = 0;
                while (_local_6 < _local_5.fieldsArray.length)
                {
                    _local_7 = (_local_5.fieldsArray[_local_6] as FieldBean);
                    if (this.fieldId == _local_7.id)
                    {
                        _local_8 = new Coordinate(_local_7.id);
                        CurFieldView.show(_local_7, _local_8, (((("(" + _local_8.x) + ",") + _local_8.y) + ")"));
                        break;
                    };
                    _local_6++;
                };
                _local_3++;
            };
            TownView.singleton().refreshWall();
        }

        private function onCityConstructCastle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                trace("开始筑城了");
                if (Context.getInstance().getPlayerBean().castlesArray.length == 1)
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("TrackPageView", TargetCount.IngameCreatedTwoOrMoreCities);
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __buildBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onBuildBtnMouseOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get attackTooltip():String
        {
            return (this._999139173attackTooltip);
        }

        [Bindable(event="propertyChange")]
        public function get cityDesc():TextArea
        {
            return (this._1421975908cityDesc);
        }

        public function __attackBtn_click(_arg_1:MouseEvent):void
        {
            onNewArmy(ObjConstants.ARMY_MISSION_OCCUPY);
        }

        public function ___FieldInfoWin_ButtonWithIcon8_click(_arg_1:MouseEvent):void
        {
            onPolicies();
        }

        [Bindable(event="propertyChange")]
        private function get fieldName():String
        {
            return (this._1265009317fieldName);
        }

        [Bindable(event="propertyChange")]
        private function get tile():Tile
        {
            return (this._3560110tile);
        }

        private function _FieldInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.fieldName;
            _local_1 = this.imgSrc;
            _local_1 = this.fieldDesc;
            _local_1 = (tile.fieldType == FieldConstants.TYPE_NPC);
            _local_1 = (!(tile.fieldType == FieldConstants.TYPE_NPC));
            _local_1 = (Lang.msg("君主") + ": ");
            _local_1 = ((bean.userName) ? bean.userName : " - -");
            _local_1 = (Lang.msg("宗主") + ": ");
            _local_1 = ((bean.suzerain) ? bean.suzerain : " - -");
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = ((bean.prestige) ? bean.prestige : " - - ");
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = bean.honor;
            _local_1 = (Lang.msg("联盟") + ": ");
            _local_1 = ((bean.allianceName) ? bean.allianceName : " - - ");
            _local_1 = (Lang.msg("状态") + ": ");
            _local_1 = PlayerInfoTypeManager.getState(bean.state);
            _local_1 = (Lang.msg("地理位置") + ": ");
            _local_1 = bean.zoneName;
            _local_1 = ((tile.fieldType != FieldConstants.TYPE_CASTLE) ? ((tile.fieldType != FieldConstants.TYPE_NPC) ? Lang.msg("{0}级别{1}", tile.getFieldName(), tile.getLevel()) : Lang.msg("{0}级别{1}", castleLevelName, tile.getLevel())) : castleLevelName);
            _local_1 = Lang.msg("进入");
            _local_1 = (((isCurField) || (isMineField)) || (isMineCastle));
            _local_1 = Lang.msg("侦察");
            _local_1 = this.bean.canScout;
            _local_1 = this.hasTrainingField;
            _local_1 = this.hasTrainingFieldTooltip;
            _local_1 = Lang.msg("攻击");
            _local_1 = (((!(((isCurField) || (isMineField)) || (isMineCastle))) && (((((((bean.canOccupy) || (bean.declaredWarStatus == DeclaredWarConstants.STATUS_PREPARATIONS)) || (GameConfig.instance.serverID == "NA20")) || (GameConfig.instance.serverID == "NA21")) || (GameConfig.instance.serverID == "NA57")) || (GameConfig.instance.strAttackFlag == "true")) || (GameConfig.instance.serverID == "beta"))) && ((((((!((bean.type == FieldConstants.TYPE_CASTLE) && (bean.powerLevel == 4))) || (GameConfig.instance.serverID == "NA20")) || (GameConfig.instance.serverID == "NA21")) || (GameConfig.instance.serverID == "NA57")) || (GameConfig.instance.strAttackFlag == "true")) || (GameConfig.instance.serverID == "beta")));
            _local_1 = this.attackBtnEnabled;
            _local_1 = this.attackTooltip;
            _local_1 = Lang.msg("派遣");
            _local_1 = isCanSend;
            _local_1 = ((this.hasTrainingField) ? true : ((this.hasTrainingField) && (!(isMineCastle))));
            _local_1 = this.hasTrainingFieldTooltip;
            _local_1 = Lang.msg("运输");
            _local_1 = ((isCanTrans) || (isMineCastle));
            _local_1 = this.hasTrainingField;
            _local_1 = this.hasTrainingFieldTooltip;
            _local_1 = Lang.msg("宣战");
            _local_1 = ((this.declareWarVisible) && (this.bean.colonialRelation == ColonyConstants.COLONY_RELATION_FREE));
            _local_1 = this.bean.canDeclaredWar;
            _local_1 = this.xuanzhanTooltip;
            _local_1 = Lang.msg("起义");
            _local_1 = (this.bean.colonialRelation == ColonyConstants.COLONY_RELATION_BEING_COLONIED);
            _local_1 = (this.bean.colonialStatus == ColonyConstants.COLONY_STATUS_OCCUPIED);
            _local_1 = Lang.msg("政令");
            _local_1 = this.isCanPolicies;
            _local_1 = this.isCanPolicies;
            _local_1 = ((this.isCanPolicies) ? "" : this.hasTrainingFieldTooltip);
            _local_1 = Lang.msg("殖民");
            _local_1 = colonyBtnVisible;
            _local_1 = (((this.attackBtnEnabled) && (!(Context.getInstance().getCurCastle().colonization == 2))) || (!(attackBtn.visible)));
            _local_1 = ((Context.getInstance().getCurCastle().colonization == 2) ? "You need to regain your freedom first before you can colonize the city." : this.attackTooltip);
            _local_1 = Lang.msg("筑城");
            _local_1 = isBuildVisible;
            _local_1 = isCanBuild;
            _local_1 = ((buildBtn.enabled) ? null : Lang.msg("建新城的提示"));
            _local_1 = Lang.msg("计谋");
            _local_1 = ((!(isBuildVisible)) && (tile.fieldType == FieldConstants.TYPE_CASTLE));
            _local_1 = Lang.msg("送信");
            _local_1 = this.isCanSendMail;
            _local_1 = Lang.msg("显示英雄");
            _local_1 = this.isCanSendMail;
            _local_1 = Lang.msg("收藏坐标");
            _local_1 = isCanAddcl;
            _local_1 = this.hasTrainingFieldTooltip;
        }

        [Bindable(event="propertyChange")]
        private function get fieldDesc():String
        {
            return (this._1264715435fieldDesc);
        }

        private function set isMineField(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1846446685isMineField;
            if (_local_2 !== _arg_1)
            {
                this._1846446685isMineField = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isMineField", _local_2, _arg_1));
            };
        }

        private function set hasTrainingFieldTooltip(_arg_1:String):void
        {
            var _local_2:Object = this._2036861603hasTrainingFieldTooltip;
            if (_local_2 !== _arg_1)
            {
                this._2036861603hasTrainingFieldTooltip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTrainingFieldTooltip", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function refresh(_arg_1:Tile):void
        {
            var _local_3:BuildingBean;
            var _local_4:String;
            var _local_5:String;
            if (!_arg_1)
            {
                return;
            };
            isMineCastle = false;
            this.tile = _arg_1;
            this.hasTrainingField = false;
            var _local_2:CastleBean = Context.getInstance().getCurCastle();
            for each (_local_3 in _local_2.buildingsArray)
            {
                if (_local_3.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
                {
                    this.hasTrainingField = true;
                    break;
                };
            };
            this.fieldX = _arg_1.getAddress().x;
            this.fieldY = _arg_1.getAddress().y;
            fieldId = ((Context.mapSizeX * this.fieldY) + this.fieldX);
            _local_4 = (((("(" + _arg_1.getAddress().x) + ",") + _arg_1.getAddress().y) + ")");
            if (_arg_1.fieldType == FieldConstants.TYPE_NPC)
            {
                if (_arg_1.getPowerLevel() < 4)
                {
                    this.imgSrc = ImageManager.getMcFieldImg(FieldConstants.TYPE_CASTLE, _arg_1.getPowerLevel());
                    this.castleLevelName = "";
                    if (_arg_1.getPowerLevel() < 4)
                    {
                        this.castleLevelName = "Historic City ";
                    };
                    castleLevelName = (castleLevelName + _arg_1.getFieldName());
                    if (_arg_1.getPowerLevel() == 0)
                    {
                        this.castleLevelName = (this.castleLevelName + ". City ");
                    }
                    else
                    {
                        if (_arg_1.getPowerLevel() == 1)
                        {
                            this.castleLevelName = (this.castleLevelName + ". Fort ");
                        }
                        else
                        {
                            if (_arg_1.getPowerLevel() == 2)
                            {
                                this.castleLevelName = (this.castleLevelName + ". Town ");
                            }
                            else
                            {
                                if (_arg_1.getPowerLevel() == 3)
                                {
                                    this.castleLevelName = (this.castleLevelName + ". Village ");
                                };
                            };
                        };
                    };
                }
                else
                {
                    this.imgSrc = ImageManager.getFieldImg(FieldConstants.TYPE_CASTLE, _arg_1.getLevel());
                    castleLevelName = this.getCastleName(_arg_1.getLevel());
                };
            }
            else
            {
                if (_arg_1.fieldType == FieldConstants.TYPE_CASTLE)
                {
                    if (_arg_1.mapCastleBean != null)
                    {
                        this.imgSrc = _arg_1.mapCastleBean.playerLogoUrl;
                    }
                    else
                    {
                        this.imgSrc = null;
                    };
                    castleLevelName = this.getCastleName(_arg_1.getLevel());
                }
                else
                {
                    this.imgSrc = ImageManager.getFieldImg(_arg_1.fieldType, _arg_1.getLevel());
                };
            };
            if (_arg_1.isCastle())
            {
                if (_arg_1.fieldType == FieldConstants.TYPE_NPC)
                {
                    if (_arg_1.getPowerLevel() < 4)
                    {
                        _local_5 = ((_arg_1.fieldType != FieldConstants.TYPE_CASTLE) ? ((_arg_1.fieldType != FieldConstants.TYPE_NPC) ? Lang.msg("{0}级别{1}", _arg_1.getFieldName(), _arg_1.getLevel()) : Lang.msg("{0}级别{1}", castleLevelName, _arg_1.getLevel())) : castleLevelName);
                        this.fieldName = _arg_1.getFieldName();
                        this.fieldDesc = Lang2.msg(this.fieldName);
                        this.cityDesc.visible = true;
                        this.lordDesc.visible = false;
                    }
                    else
                    {
                        this.fieldName = this.getNpcCastleName(_arg_1.getLevel());
                        this.fieldDesc = Lang.msg("野蛮人城池的说明");
                    };
                }
                else
                {
                    this.cityDesc.visible = false;
                    this.lordDesc.visible = true;
                    this.fieldName = ((_arg_1.getFieldName() + " ") + _local_4);
                };
            }
            else
            {
                this.fieldName = "";
                this.fieldName = ((this.fieldName + _arg_1.getFieldName()) + " ");
                this.fieldName = ((((this.fieldName + Lang.msg("等级（简）")) + _arg_1.getLevel()) + " ") + _local_4);
            };
            this.bean = null;
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(Context.getInstance().getCurCastle().id, fieldId);
            isCanBuild = ((((this.getIsMineField()) && (_arg_1.fieldType == FieldConstants.TYPE_FLAT)) && (isFitCondition())) && (checkIsBuilding()));
            isMineCastle = this.getIsMineCastle();
            isMineField = this.getIsMineField();
            isBuildVisible = ((this.isMineField) && (_arg_1.fieldType == FieldConstants.TYPE_FLAT));
            isCurField = ((this.fieldId == Context.getInstance().getCurCastle().fieldId) ? true : false);
        }

        private function set isBuildVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1557906322isBuildVisible;
            if (_local_2 !== _arg_1)
            {
                this._1557906322isBuildVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBuildVisible", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_ButtonWithIcon5_click(_arg_1:MouseEvent):void
        {
            onNewArmy(ObjConstants.ARMY_MISSION_TRANS);
        }

        private function set declareWarVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._159518068declareWarVisible;
            if (_local_2 !== _arg_1)
            {
                this._159518068declareWarVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declareWarVisible", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_ButtonWithIcon14_click(_arg_1:MouseEvent):void
        {
            sendCoordinatesCommand();
        }

        [Bindable(event="propertyChange")]
        private function get isCanSend():Boolean
        {
            return (this._30039314isCanSend);
        }

        [Bindable(event="propertyChange")]
        public function get attackBtn():ButtonWithIcon
        {
            return (this._478932236attackBtn);
        }

        public function __buildBtn_click(_arg_1:MouseEvent):void
        {
            this.castleBuild();
        }

        private function set xuanzhanTooltip(_arg_1:String):void
        {
            var _local_2:Object = this._704142718xuanzhanTooltip;
            if (_local_2 !== _arg_1)
            {
                this._704142718xuanzhanTooltip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xuanzhanTooltip", _local_2, _arg_1));
            };
        }

        public function __buildBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onBuildBtnMouseOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get buildBtn():ButtonWithIcon
        {
            return (this._1430683378buildBtn);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO, onOtherFieldInfo);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CITY_CONSTRUCT_CASTLE, onCityConstructCastle);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_STATUS_CHANGE, setWarStatusSucess);
        }

        private function onJmApply(_arg_1:ItemEum=null):void
        {
            if (_arg_1 != null)
            {
                ActionFactory.getInstance().getShopCommands().useTrickItem(this.bean.id, 0, _arg_1.id, callBackTrickHandle);
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyBtnVisible():Boolean
        {
            return (this._535325936colonyBtnVisible);
        }

        public function ___FieldInfoWin_ButtonWithIcon2_click(_arg_1:MouseEvent):void
        {
            onNewArmy(ObjConstants.ARMY_MISSION_SCOUT);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        private function checkHero():void
        {
            ActionFactory.getInstance().getHeroCommand().ShowPlayerHerosByUserName(bean.userName, showHeroResponse);
        }

        private function checkIsBuilding():Boolean
        {
            var _local_3:int;
            var _local_1:Boolean = true;
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().selfArmysArray;
            if (_local_2.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    if ((((this.fieldBuildId == _local_2[_local_3].targetFieldId) && (_local_2[_local_3].missionType == ObjConstants.ARMY_MISSION_CONSTRUCT)) && (_local_2[_local_3].direction == ArmyConstants.ARMY_FORWARD)))
                    {
                        _local_1 = false;
                        numOfIsBuilding++;
                    };
                    _local_3++;
                };
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get lordDesc():VBox
        {
            return (this._1963149530lordDesc);
        }

        private function getIsMineField():Boolean
        {
            var _local_3:CastleBean;
            var _local_4:int;
            var _local_5:FieldBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                if (_local_1 == true) break;
                _local_3 = Context.getInstance().getPlayerBean().castlesArray[_local_2];
                _local_4 = 0;
                while (_local_4 < _local_3.fieldsArray.length)
                {
                    _local_5 = _local_3.fieldsArray[_local_4];
                    if (_local_5.id == this.fieldId)
                    {
                        this.fieldBuildId = _local_5.id;
                        _local_1 = true;
                        break;
                    };
                    _local_4++;
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function onCreationComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                Bitmap(_arg_1.currentTarget.content).smoothing = true;
            };
        }

        public function set cityDesc(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1421975908cityDesc;
            if (_local_2 !== _arg_1)
            {
                this._1421975908cityDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityDesc", _local_2, _arg_1));
            };
        }

        private function _FieldInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fieldName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label1.text = _arg_1;
            }, "_FieldInfoWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _FieldInfoWin_Image1.source = _arg_1;
            }, "_FieldInfoWin_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fieldDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityDesc.text = _arg_1;
            }, "cityDesc.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (tile.fieldType == FieldConstants.TYPE_NPC);
            }, function (_arg_1:Boolean):void
            {
                cityDesc.visible = _arg_1;
            }, "cityDesc.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(tile.fieldType == FieldConstants.TYPE_NPC));
            }, function (_arg_1:Boolean):void
            {
                lordDesc.visible = _arg_1;
            }, "lordDesc.visible");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label2.text = _arg_1;
            }, "_FieldInfoWin_Label2.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((bean.userName) ? bean.userName : " - -");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text1.text = _arg_1;
            }, "_FieldInfoWin_Text1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("宗主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label3.text = _arg_1;
            }, "_FieldInfoWin_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((bean.suzerain) ? bean.suzerain : " - -");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text2.text = _arg_1;
            }, "_FieldInfoWin_Text2.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label4.text = _arg_1;
            }, "_FieldInfoWin_Label4.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((bean.prestige) ? bean.prestige : " - - ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text3.text = _arg_1;
            }, "_FieldInfoWin_Text3.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label5.text = _arg_1;
            }, "_FieldInfoWin_Label5.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = bean.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text4.text = _arg_1;
            }, "_FieldInfoWin_Text4.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label6.text = _arg_1;
            }, "_FieldInfoWin_Label6.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((bean.allianceName) ? bean.allianceName : " - - ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text5.text = _arg_1;
            }, "_FieldInfoWin_Text5.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("状态") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label7.text = _arg_1;
            }, "_FieldInfoWin_Label7.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = PlayerInfoTypeManager.getState(bean.state);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text6.text = _arg_1;
            }, "_FieldInfoWin_Text6.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("地理位置") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label8.text = _arg_1;
            }, "_FieldInfoWin_Label8.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = bean.zoneName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Text7.text = _arg_1;
            }, "_FieldInfoWin_Text7.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((tile.fieldType != FieldConstants.TYPE_CASTLE) ? ((tile.fieldType != FieldConstants.TYPE_NPC) ? Lang.msg("{0}级别{1}", tile.getFieldName(), tile.getLevel()) : Lang.msg("{0}级别{1}", castleLevelName, tile.getLevel())) : castleLevelName);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_Label9.text = _arg_1;
            }, "_FieldInfoWin_Label9.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("进入");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon1.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon1.myLabel");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((isCurField) || (isMineField)) || (isMineCastle));
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon1.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon1.visible");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("侦察");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon2.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon2.myLabel");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bean.canScout);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon2.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon2.visible");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.hasTrainingField);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon2.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon2.enabled");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.hasTrainingFieldTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon2.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon2.toolTip");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("攻击");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                attackBtn.myLabel = _arg_1;
            }, "attackBtn.myLabel");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(((isCurField) || (isMineField)) || (isMineCastle))) && (((((((bean.canOccupy) || (bean.declaredWarStatus == DeclaredWarConstants.STATUS_PREPARATIONS)) || (GameConfig.instance.serverID == "NA20")) || (GameConfig.instance.serverID == "NA21")) || (GameConfig.instance.serverID == "NA57")) || (GameConfig.instance.strAttackFlag == "true")) || (GameConfig.instance.serverID == "beta"))) && ((((((!((bean.type == FieldConstants.TYPE_CASTLE) && (bean.powerLevel == 4))) || (GameConfig.instance.serverID == "NA20")) || (GameConfig.instance.serverID == "NA21")) || (GameConfig.instance.serverID == "NA57")) || (GameConfig.instance.strAttackFlag == "true")) || (GameConfig.instance.serverID == "beta")));
            }, function (_arg_1:Boolean):void
            {
                attackBtn.visible = _arg_1;
            }, "attackBtn.visible");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.attackBtnEnabled);
            }, function (_arg_1:Boolean):void
            {
                attackBtn.enabled = _arg_1;
            }, "attackBtn.enabled");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.attackTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                attackBtn.toolTip = _arg_1;
            }, "attackBtn.toolTip");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("派遣");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon4.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon4.myLabel");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isCanSend);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon4.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon4.visible");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.hasTrainingField) ? true : ((this.hasTrainingField) && (!(isMineCastle))));
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon4.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon4.enabled");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.hasTrainingFieldTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon4.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon4.toolTip");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("运输");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon5.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon5.myLabel");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((isCanTrans) || (isMineCastle));
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon5.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon5.visible");
            result[35] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.hasTrainingField);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon5.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon5.enabled");
            result[36] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.hasTrainingFieldTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon5.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon5.toolTip");
            result[37] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("宣战");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon6.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon6.myLabel");
            result[38] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.declareWarVisible) && (this.bean.colonialRelation == ColonyConstants.COLONY_RELATION_FREE));
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon6.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon6.visible");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bean.canDeclaredWar);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon6.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon6.enabled");
            result[40] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.xuanzhanTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon6.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon6.toolTip");
            result[41] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("起义");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon7.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon7.myLabel");
            result[42] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bean.colonialRelation == ColonyConstants.COLONY_RELATION_BEING_COLONIED);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon7.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon7.visible");
            result[43] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bean.colonialStatus == ColonyConstants.COLONY_STATUS_OCCUPIED);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon7.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon7.enabled");
            result[44] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("政令");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon8.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon8.myLabel");
            result[45] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanPolicies);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon8.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon8.visible");
            result[46] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanPolicies);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon8.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon8.enabled");
            result[47] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.isCanPolicies) ? "" : this.hasTrainingFieldTooltip);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon8.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon8.toolTip");
            result[48] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("殖民");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon9.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon9.myLabel");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (colonyBtnVisible);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon9.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon9.visible");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((this.attackBtnEnabled) && (!(Context.getInstance().getCurCastle().colonization == 2))) || (!(attackBtn.visible)));
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon9.enabled = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon9.enabled");
            result[51] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().getCurCastle().colonization == 2) ? "You need to regain your freedom first before you can colonize the city." : this.attackTooltip);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon9.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon9.toolTip");
            result[52] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("筑城");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buildBtn.myLabel = _arg_1;
            }, "buildBtn.myLabel");
            result[53] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isBuildVisible);
            }, function (_arg_1:Boolean):void
            {
                buildBtn.visible = _arg_1;
            }, "buildBtn.visible");
            result[54] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isCanBuild);
            }, function (_arg_1:Boolean):void
            {
                buildBtn.enabled = _arg_1;
            }, "buildBtn.enabled");
            result[55] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((buildBtn.enabled) ? null : Lang.msg("建新城的提示"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buildBtn.toolTip = _arg_1;
            }, "buildBtn.toolTip");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("计谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                trickBtn.myLabel = _arg_1;
            }, "trickBtn.myLabel");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(isBuildVisible)) && (tile.fieldType == FieldConstants.TYPE_CASTLE));
            }, function (_arg_1:Boolean):void
            {
                trickBtn.visible = _arg_1;
            }, "trickBtn.visible");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("送信");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon12.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon12.myLabel");
            result[59] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanSendMail);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon12.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon12.visible");
            result[60] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("显示英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon13.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon13.myLabel");
            result[61] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanSendMail);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon13.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon13.visible");
            result[62] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("收藏坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon14.myLabel = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon14.myLabel");
            result[63] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isCanAddcl);
            }, function (_arg_1:Boolean):void
            {
                _FieldInfoWin_ButtonWithIcon14.visible = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon14.visible");
            result[64] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.hasTrainingFieldTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FieldInfoWin_ButtonWithIcon14.toolTip = _arg_1;
            }, "_FieldInfoWin_ButtonWithIcon14.toolTip");
            result[65] = binding;
            return (result);
        }

        public function ___FieldInfoWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.visible = false;
            if (Map.instance != null)
            {
                Map.instance.restorePlayAll();
            };
        }

        private function set attackTooltip(_arg_1:String):void
        {
            var _local_2:Object = this._999139173attackTooltip;
            if (_local_2 !== _arg_1)
            {
                this._999139173attackTooltip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attackTooltip", _local_2, _arg_1));
            };
        }

        private function set fieldName(_arg_1:String):void
        {
            var _local_2:Object = this._1265009317fieldName;
            if (_local_2 !== _arg_1)
            {
                this._1265009317fieldName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldName", _local_2, _arg_1));
            };
        }

        private function remainTime(_arg_1:Number):String
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_2:Number = new Date().valueOf();
            var _local_3:int = Context.getInstance().getTimeDiff();
            var _local_4:int = ((_arg_1 + _local_3) - _local_2);
            _local_4 = int((_local_4 / 1000));
            var _local_5:* = "";
            if (_local_4 >= 0)
            {
                _local_6 = int((_local_4 / (60 * 60)));
                if (_local_6 > 0)
                {
                    _local_5 = (_local_5 + ((_local_6 + Lang.msg("时")) + " "));
                };
                _local_7 = int(((_local_4 / 60) % 60));
                if (((_local_5.length > 0) || (_local_7 > 0)))
                {
                    _local_5 = (_local_5 + ((_local_7 + Lang.msg("分")) + " "));
                };
                if (_local_6 == 0)
                {
                    _local_8 = (_local_4 % 60);
                    _local_5 = (_local_5 + (_local_8 + Lang.msg("秒")));
                };
            };
            return (_local_5);
        }

        private function set attackBtnEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._317024851attackBtnEnabled;
            if (_local_2 !== _arg_1)
            {
                this._317024851attackBtnEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attackBtnEnabled", _local_2, _arg_1));
            };
        }

        private function set fieldDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1264715435fieldDesc;
            if (_local_2 !== _arg_1)
            {
                this._1264715435fieldDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldDesc", _local_2, _arg_1));
            };
        }

        private function onOtherFieldInfo(_arg_1:OtherFieldInfoResponse):void
        {
            if (!this.visible)
            {
                return;
            };
            if (((tile.fieldType == FieldConstants.TYPE_CASTLE) && (this.imgSrc == null)))
            {
                this.imgSrc = _arg_1.bean.playerLogoUrl;
            };
            this.bean = _arg_1.bean;
            this.isCanSendMail = ((!(bean.userName == null)) && (!(bean.userName == Context.getInstance().getPlayerBean().playerInfo.userName)));
            this.isCanTrans = (((bean.canTrans) && (!(this.fieldId == Context.getInstance().getCurCastle().fieldId))) ? true : false);
            this.isCanSend = (((((bean.canSend) && (!(this.fieldId == Context.getInstance().getCurCastle().fieldId))) || (getIsMineField())) || (getIsMineCastle())) ? true : false);
            this.isCanAddcl = ((tile.fieldType == FieldConstants.TYPE_CASTLE) && (!(this.bean.userName == Context.getInstance().getPlayerBean().playerInfo.userName)));
            this.declareWarVisible = ((((this.bean.declaredWarStatus == DeclaredWarConstants.STATUS_PEACE) && (this.bean.relation == AllianceConstants.MIDDLE_ALLIANCE)) && (this.bean.type == FieldConstants.TYPE_CASTLE)) && (this.bean.powerLevel == FieldConstants.POWER_NORMAL));
            this.colonyBtnVisible = ((((((((this.bean.canOccupy) && (!(isProtect))) && (!(this.bean.freshMan))) && (!(this.bean.furlough))) || (this.bean.declaredWarStatus == DeclaredWarConstants.STATUS_PREPARATIONS)) || (this.bean.declaredWarStatus == DeclaredWarConstants.STATUS_WAR)) && (this.bean.colonialRelation == ColonyConstants.COLONY_RELATION_FREE)) && (this.bean.powerLevel == FieldConstants.POWER_NORMAL));
            isProtect = ((!(UIUtil.checkOffice())) && (UIUtil.judgeTime() < 7));
            if (isProtect)
            {
                this.xuanzhanTooltip = Lang.msg("新手保护期内无法进行该操作");
            }
            else
            {
                if (this.bean.freshMan)
                {
                    this.xuanzhanTooltip = Lang.msg("无法对新手玩家，同盟玩家，友盟玩家提出宣战");
                }
                else
                {
                    this.xuanzhanTooltip = "";
                };
            };
            this.checkToolTip();
            this.isCanPolicies = ((((Context.getInstance().getCurCastle().powerlevel < 4) && (!(isCanSend))) && (!(((isCurField) || (isMineField)) || (isMineCastle)))) && ((tile.fieldType == FieldConstants.TYPE_CASTLE) || (tile.fieldType == FieldConstants.TYPE_NPC)));
        }

        private function set bean(_arg_1:MapCastleBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_ButtonWithIcon7_click(_arg_1:MouseEvent):void
        {
            uprise();
        }

        private function set tile(_arg_1:Tile):void
        {
            var _local_2:Object = this._3560110tile;
            if (_local_2 !== _arg_1)
            {
                this._3560110tile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tile", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasTrainingFieldTooltip():String
        {
            return (this._2036861603hasTrainingFieldTooltip);
        }

        private function set fieldId(_arg_1:int):void
        {
            var _local_2:Object = this._861252683fieldId;
            if (_local_2 !== _arg_1)
            {
                this._861252683fieldId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldId", _local_2, _arg_1));
            };
        }

        private function set isCanPolicies(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1441488458isCanPolicies;
            if (_local_2 !== _arg_1)
            {
                this._1441488458isCanPolicies = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanPolicies", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get declareWarVisible():Boolean
        {
            return (this._159518068declareWarVisible);
        }

        [Bindable(event="propertyChange")]
        private function get xuanzhanTooltip():String
        {
            return (this._704142718xuanzhanTooltip);
        }

        private function set isCanSendMail(_arg_1:Boolean):void
        {
            var _local_2:Object = this._741149243isCanSendMail;
            if (_local_2 !== _arg_1)
            {
                this._741149243isCanSendMail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanSendMail", _local_2, _arg_1));
            };
        }

        private function onBuildBtnMouseOver(_arg_1:MouseEvent):void
        {
        }

        override public function initialize():void
        {
            var target:FieldInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FieldInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_world_FieldInfoWinWatcherSetupUtil");
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

        private function onBuildBtnMouseOut(_arg_1:MouseEvent):void
        {
        }

        private function getCastleName(_arg_1:int):String
        {
            var _local_2:* = " ";
            if (_arg_1 < 4)
            {
                _local_2 = Lang.msg("村庄");
            }
            else
            {
                if (((_arg_1 >= 4) && (_arg_1 <= 6)))
                {
                    _local_2 = Lang.msg("小镇");
                }
                else
                {
                    if (((_arg_1 >= 7) && (_arg_1 <= 9)))
                    {
                        _local_2 = Lang.msg("要塞");
                    }
                    else
                    {
                        if (_arg_1 == 10)
                        {
                            _local_2 = Lang.msg("城池");
                        };
                    };
                };
            };
            return (_local_2);
        }

        private function set hasTrainingField(_arg_1:Boolean):void
        {
            var _local_2:Object = this._845629382hasTrainingField;
            if (_local_2 !== _arg_1)
            {
                this._845629382hasTrainingField = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTrainingField", _local_2, _arg_1));
            };
        }

        private function set isCanBuild(_arg_1:Boolean):void
        {
            var _local_2:Object = this._946446392isCanBuild;
            if (_local_2 !== _arg_1)
            {
                this._946446392isCanBuild = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanBuild", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_ButtonWithIcon4_click(_arg_1:MouseEvent):void
        {
            onNewArmy(ObjConstants.ARMY_MISSION_SEND);
        }

        public function __trickBtn_click(_arg_1:MouseEvent):void
        {
            this.trickApply();
        }

        [Bindable(event="propertyChange")]
        private function get attackBtnEnabled():Boolean
        {
            return (this._317024851attackBtnEnabled);
        }

        private function getNpcCastleName(_arg_1:int):String
        {
            var _local_2:* = " ";
            if (_arg_1 < 4)
            {
                _local_2 = Lang.msg("野蛮人村庄");
            }
            else
            {
                if (((_arg_1 >= 4) && (_arg_1 <= 6)))
                {
                    _local_2 = Lang.msg("野蛮人小镇");
                }
                else
                {
                    if (((_arg_1 >= 7) && (_arg_1 <= 9)))
                    {
                        _local_2 = Lang.msg("野蛮人要塞");
                    }
                    else
                    {
                        if (_arg_1 == 10)
                        {
                            _local_2 = Lang.msg("野蛮人城池");
                        };
                    };
                };
            };
            return (_local_2);
        }

        public function ___FieldInfoWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function checkToolTip():void
        {
            var _local_1:String;
            if (!this.hasTrainingField)
            {
                this.attackBtnEnabled = false;
                this.attackTooltip = Lang.msg("请先建造校场");
                this.hasTrainingFieldTooltip = Lang.msg("请先建造校场");
            }
            else
            {
                this.hasTrainingFieldTooltip = "";
                if (this.bean.furlough)
                {
                    if (this.bean.powerLevel != FieldConstants.POWER_NORMAL)
                    {
                        this.attackBtnEnabled = true;
                    }
                    else
                    {
                        this.attackBtnEnabled = false;
                        this.attackTooltip = Lang.msg("休假无法宣战");
                    };
                }
                else
                {
                    if (((!((this.bean.type == FieldConstants.TYPE_CASTLE) && (this.bean.powerLevel == FieldConstants.POWER_NORMAL))) || (this.bean.relation == AllianceConstants.ENEMY_ALLIANCE)))
                    {
                        this.attackBtnEnabled = true;
                        this.attackTooltip = null;
                    }
                    else
                    {
                        _local_1 = "";
                        if (this.bean.declaredWarStatus == DeclaredWarConstants.STATUS_PREPARATIONS)
                        {
                            this.attackBtnEnabled = false;
                            _local_1 = remainTime((this.bean.declaredWarStartTime + warDeclareEndTimeAdd));
                            if (_local_1 == "")
                            {
                                _local_1 = "1m";
                            };
                            this.attackTooltip = ("War begins in " + _local_1);
                        }
                        else
                        {
                            if (this.bean.declaredWarStatus == DeclaredWarConstants.STATUS_WAR)
                            {
                                this.attackBtnEnabled = true;
                                _local_1 = remainTime((this.bean.declaredWarStartTime + warEndTimeAdd));
                                if (_local_1 == "")
                                {
                                    _local_1 = "1m";
                                };
                                this.attackTooltip = ("War ends in " + _local_1);
                            }
                            else
                            {
                                this.attackTooltip = null;
                            };
                        };
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get fieldId():int
        {
            return (this._861252683fieldId);
        }

        private function callBackTrickHandle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("计谋使用成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():MapCastleBean
        {
            return (this._3019696bean);
        }

        public function ___FieldInfoWin_ButtonWithIcon13_click(_arg_1:MouseEvent):void
        {
            checkHero();
        }

        [Bindable(event="propertyChange")]
        private function get isCanSendMail():Boolean
        {
            return (this._741149243isCanSendMail);
        }

        [Bindable(event="propertyChange")]
        private function get isCanBuild():Boolean
        {
            return (this._946446392isCanBuild);
        }

        [Bindable(event="propertyChange")]
        private function get hasTrainingField():Boolean
        {
            return (this._845629382hasTrainingField);
        }

        private function set isCurField(_arg_1:Boolean):void
        {
            var _local_2:Object = this._258392604isCurField;
            if (_local_2 !== _arg_1)
            {
                this._258392604isCurField = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCurField", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isCanPolicies():Boolean
        {
            return (this._1441488458isCanPolicies);
        }

        private function getIsCurField():Boolean
        {
            var _local_3:FieldBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getCurCastle().fieldsArray.length)
            {
                _local_3 = (Context.getInstance().getCurCastle().fieldsArray[_local_2] as FieldBean);
                if (this.fieldId == _local_3.id)
                {
                    _local_1 = true;
                    break;
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function set isCanSend(_arg_1:Boolean):void
        {
            var _local_2:Object = this._30039314isCanSend;
            if (_local_2 !== _arg_1)
            {
                this._30039314isCanSend = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanSend", _local_2, _arg_1));
            };
        }

        public function ___FieldInfoWin_ButtonWithIcon1_click(_arg_1:MouseEvent):void
        {
            onEnterCastle();
        }

        private function trickApply():void
        {
            SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_JM_APPLY;
            if ((((isCurField) || (isMineField)) || (isMineCastle)))
            {
                SpeedupItemSelector.show(ItemManager.trickMineCastleArray, onJmApply);
            }
            else
            {
                SpeedupItemSelector.show(ItemManager.trickCastleItemArray, onJmApply);
            };
        }

        private function uprise():void
        {
            ActionFactory.getInstance().getColonyCommands().uprise(Context.getInstance().getCurCastle().id, upriseResponse);
        }

        public function ___FieldInfoWin_ButtonWithIcon9_click(_arg_1:MouseEvent):void
        {
            onNewArmy(ObjConstants.ARMY_MISSION_COLONIZE);
        }

        public function set attackBtn(_arg_1:ButtonWithIcon):void
        {
            var _local_2:Object = this._478932236attackBtn;
            if (_local_2 !== _arg_1)
            {
                this._478932236attackBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attackBtn", _local_2, _arg_1));
            };
        }

        private function set isMineCastle(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1312421877isMineCastle;
            if (_local_2 !== _arg_1)
            {
                this._1312421877isMineCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isMineCastle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isCurField():Boolean
        {
            return (this._258392604isCurField);
        }

        public function ___FieldInfoWin_ButtonWithIcon9_toolTipShown(_arg_1:ToolTipEvent):void
        {
            checkToolTip();
        }

        [Bindable(event="propertyChange")]
        private function get isMineCastle():Boolean
        {
            return (this._1312421877isMineCastle);
        }

        private function showHeroResponse(_arg_1:HeroListResponse):void
        {
            var _local_2:OtherPlayerHero;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (_arg_1.herosArray.length > 0)
                {
                    _local_2 = new OtherPlayerHero();
                    if (!_local_2.isPopUp)
                    {
                        PopUpManager.addPopUp(_local_2, MainFrame.instance, false);
                    }
                    else
                    {
                        PopUpManager.bringToFront(_local_2);
                    };
                    _local_2.setHeroList(_arg_1.herosArray);
                }
                else
                {
                    AlertWin.show(Lang.msg("未设置显示英雄"));
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __trickBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onBuildBtnMouseOut(_arg_1);
        }


    }
}//package view.castle.world

