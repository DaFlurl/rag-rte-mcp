// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceMember.AllianceMemberInfoShow

package view.module.alliance.oldAlliance.allianceMember
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Image;
    import mx.controls.Button;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.controls.ComboBox;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import com.evony.common.constants.AllianceConstants;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.Binding;
    import com.evony.factory.PlayerInfoTypeManager;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
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

    use namespace mx_internal;

    public class AllianceMemberInfoShow extends Canvas implements IBindingClient 
    {

        public static var instance:AllianceMemberInfoShow;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceMemberInfoShow_Text10:Text;
        public var _AllianceMemberInfoShow_Text11:Text;
        public var _AllianceMemberInfoShow_Text2:Text;
        public var _AllianceMemberInfoShow_Text3:Text;
        public var _AllianceMemberInfoShow_Text4:Text;
        public var _AllianceMemberInfoShow_Text5:Text;
        public var _AllianceMemberInfoShow_Text6:Text;
        public var _AllianceMemberInfoShow_Text7:Text;
        public var _AllianceMemberInfoShow_Text1:Text;
        public var _AllianceMemberInfoShow_Text9:Text;
        public var _AllianceMemberInfoShow_Text8:Text;
        public var _AllianceMemberInfoShow_Image1:Image;
        private var _1315418018exitBtn:Button;
        private var _1366077706memberLevel:int;
        private var _19962424memberInfoBean:PlayerInfoBean;
        private var _1748641499officePostCB:ComboBox;
        private var _497023925curMemberId:int;
        private var _1694398603resetLevel:Button;
        public var _AllianceMemberInfoShow_Label10:Label;
        public var _AllianceMemberInfoShow_Label11:Label;
        public var _AllianceMemberInfoShow_Label12:Label;
        private var _112621893canChangePower:Boolean = false;
        public var _AllianceMemberInfoShow_Button2:Button;
        public var _AllianceMemberInfoShow_Button3:Button;
        public var _AllianceMemberInfoShow_Label1:Label;
        public var _AllianceMemberInfoShow_Label2:Label;
        public var _AllianceMemberInfoShow_Label3:Label;
        public var _AllianceMemberInfoShow_Label4:Label;
        public var _AllianceMemberInfoShow_Label5:Label;
        public var _AllianceMemberInfoShow_Label6:Label;
        public var _AllianceMemberInfoShow_Label7:Label;
        public var _AllianceMemberInfoShow_Label8:Label;
        public var _AllianceMemberInfoShow_Label9:Label;
        private var _2067570601isOwner:Boolean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":490,
                    "height":350,
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
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceMemberInfoShow_Label1",
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
                        "type":ComboBox,
                        "id":"officePostCB",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.bottom = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":110,
                                "height":20
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "45";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "height":149,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.top = "10";
                                        this.bottom = "10";
                                        this.verticalGap = 5;
                                        this.right = "130";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
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
                                                            "id":"_AllianceMemberInfoShow_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":35,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":65,
                                                                    "styleName":"labelWithBackGround",
                                                                    "height":22,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":35,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":35,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":35,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":35,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AllianceMemberInfoShow_Image1",
                                    "events":{"complete":"___AllianceMemberInfoShow_Image1_complete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "15";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":109,
                                            "height":109
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "200";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":89,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
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
                                                            "id":"_AllianceMemberInfoShow_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceMemberInfoShow_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceMemberInfoShow_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
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
                                                            "id":"_AllianceMemberInfoShow_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_AllianceMemberInfoShow_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":25,
                                                                    "height":22,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_AllianceMemberInfoShow_Text11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"labelWithBackGround",
                                                                    "selectable":false
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
                            this.right = "40";
                            this.bottom = "30";
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"resetLevel",
                                    "events":{"click":"__resetLevel_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "styleName":"b95"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AllianceMemberInfoShow_Button2",
                                    "events":{"click":"___AllianceMemberInfoShow_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":75,
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AllianceMemberInfoShow_Button3",
                                    "events":{"click":"___AllianceMemberInfoShow_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":75,
                                            "height":25
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"exitBtn",
                        "events":{"click":"__exitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1443179717dataPCB:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("联盟成员"),
            "data":AllianceConstants.LAST_POWER_FOR_ALLIANCE
        }, {
            "label":Lang.msg("联盟官员"),
            "data":AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE
        }, {
            "label":Lang.msg("联盟长老"),
            "data":AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE
        }, {
            "label":Lang.msg("联盟副盟主"),
            "data":AllianceConstants.TOP2_POWER_FOR_ALLIANCE
        }]);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceMemberInfoShow()
        {
            mx_internal::_document = this;
            this.width = 490;
            this.height = 350;
            this.addEventListener("creationComplete", ___AllianceMemberInfoShow_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceMemberInfoShow._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:PlayerInfoBean=null):void
        {
            var _local_2:int;
            if (instance == null)
            {
                instance = new (AllianceMemberInfoShow)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.memberInfoBean = _arg_1;
            instance.memberLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
            instance.canChangePower = instance._canChangePower();
            if (Context.getInstance().getPlayerBean().playerInfo.userName == _arg_1.userName)
            {
                instance.isOwner = false;
            }
            else
            {
                instance.isOwner = true;
            };
            switch (_arg_1.levelId)
            {
                case AllianceConstants.LAST_POWER_FOR_ALLIANCE:
                    _local_2 = 0;
                    break;
                case AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE:
                    _local_2 = 1;
                    break;
                case AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE:
                    _local_2 = 2;
                    break;
                case AllianceConstants.TOP2_POWER_FOR_ALLIANCE:
                    _local_2 = 3;
                    break;
            };
            instance.officePostCB.selectedIndex = _local_2;
        }


        private function turnBack():void
        {
            PopUpManager.removePopUp(this);
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceMemberList"}));
        }

        [Bindable(event="propertyChange")]
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        private function onSetPowerForUser(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("设置权限成功"));
                MinePopupManager.instance.removePopup();
                ActionFactory.getInstance().getAllianceCommands().getAllianceMembers();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set memberLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1366077706memberLevel;
            if (_local_2 !== _arg_1)
            {
                this._1366077706memberLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLevel", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE, onSetPowerForUser);
        }

        private function _AllianceMemberInfoShow_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label1.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataPCB);
            }, function (_arg_1:Object):void
            {
                officePostCB.dataProvider = _arg_1;
            }, "officePostCB.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (canChangePower);
            }, function (_arg_1:Boolean):void
            {
                officePostCB.visible = _arg_1;
            }, "officePostCB.visible");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label2.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text1.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所属联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label3.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text2.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟职位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label4.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label4.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.allianceLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text3.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("官职") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label5.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label5.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text4.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text4.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("爵位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label6.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label6.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = PlayerInfoTypeManager.getTitle(memberInfoBean.titleId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text5.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text5.text");
            result[12] = binding;
            binding = new Binding(this, function ():Object
            {
                return (memberInfoBean.faceUrl);
            }, function (_arg_1:Object):void
            {
                _AllianceMemberInfoShow_Image1.source = _arg_1;
            }, "_AllianceMemberInfoShow_Image1.source");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label7.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label7.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.population;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text6.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text6.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("排名") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label8.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label8.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.ranking;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text7.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text7.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label9.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label9.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.castleCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text8.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text8.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label10.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label10.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text9.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text9.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label11.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label11.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text10.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text10.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟职位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Label12.text = _arg_1;
            }, "_AllianceMemberInfoShow_Label12.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = memberInfoBean.allianceLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Text11.text = _arg_1;
            }, "_AllianceMemberInfoShow_Text11.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改权限");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                resetLevel.label = _arg_1;
            }, "resetLevel.label");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (canChangePower);
            }, function (_arg_1:Boolean):void
            {
                resetLevel.visible = _arg_1;
            }, "resetLevel.visible");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("逐出");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Button2.label = _arg_1;
            }, "_AllianceMemberInfoShow_Button2.label");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((memberInfoBean.levelId > Context.getInstance().getPlayerBean().playerInfo.levelId) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _AllianceMemberInfoShow_Button2.enabled = _arg_1;
            }, "_AllianceMemberInfoShow_Button2.enabled");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("写信");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceMemberInfoShow_Button3.label = _arg_1;
            }, "_AllianceMemberInfoShow_Button3.label");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isOwner);
            }, function (_arg_1:Boolean):void
            {
                _AllianceMemberInfoShow_Button3.visible = _arg_1;
            }, "_AllianceMemberInfoShow_Button3.visible");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isOwner);
            }, function (_arg_1:Boolean):void
            {
                _AllianceMemberInfoShow_Button3.includeInLayout = _arg_1;
            }, "_AllianceMemberInfoShow_Button3.includeInLayout");
            result[32] = binding;
            return (result);
        }

        public function __resetLevel_click(_arg_1:MouseEvent):void
        {
            changePower();
        }

        private function changePower():void
        {
            if (officePostCB.selectedItem["data"] == memberInfoBean.levelId)
            {
                AlertWin.show(Lang.msg("该成员已经是{0}", officePostCB.selectedLabel));
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(memberInfoBean.userName, officePostCB.selectedItem["data"]);
            };
        }

        private function writeMail():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {
                "id":"allianceMail",
                "data":memberInfoBean.userName
            }));
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        private function get memberInfoBean():PlayerInfoBean
        {
            return (this._19962424memberInfoBean);
        }

        [Bindable(event="propertyChange")]
        private function get canChangePower():Boolean
        {
            return (this._112621893canChangePower);
        }

        private function set isOwner(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2067570601isOwner;
            if (_local_2 !== _arg_1)
            {
                this._2067570601isOwner = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isOwner", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get exitBtn():Button
        {
            return (this._1315418018exitBtn);
        }

        private function _canChangePower():Boolean
        {
            var _local_1:Boolean = ((memberInfoBean.userName != Context.getInstance().getPlayerBean().playerInfo.userName) ? (((memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) : false);
            if (memberLevel < instance.memberInfoBean.levelId)
            {
                resetLevel.enabled = true;
            }
            else
            {
                resetLevel.enabled = false;
            };
            return (_local_1);
        }

        public function ___AllianceMemberInfoShow_Button2_click(_arg_1:MouseEvent):void
        {
            fireMember();
        }

        private function set curMemberId(_arg_1:int):void
        {
            var _local_2:Object = this._497023925curMemberId;
            if (_local_2 !== _arg_1)
            {
                this._497023925curMemberId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curMemberId", _local_2, _arg_1));
            };
        }

        private function fireMember():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(memberInfoBean.userName, onKickOutMemberFromAlliance);
        }

        [Bindable(event="propertyChange")]
        public function get resetLevel():Button
        {
            return (this._1694398603resetLevel);
        }

        private function _AllianceMemberInfoShow_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("玩家信息");
            _local_1 = dataPCB;
            _local_1 = canChangePower;
            _local_1 = (Lang.msg("君主") + ": ");
            _local_1 = memberInfoBean.userName;
            _local_1 = (Lang.msg("所属联盟") + ": ");
            _local_1 = memberInfoBean.alliance;
            _local_1 = (Lang.msg("联盟职位") + ": ");
            _local_1 = memberInfoBean.allianceLevel;
            _local_1 = (Lang.msg("官职") + ": ");
            _local_1 = memberInfoBean.office;
            _local_1 = (Lang.msg("爵位") + ": ");
            _local_1 = PlayerInfoTypeManager.getTitle(memberInfoBean.titleId);
            _local_1 = memberInfoBean.faceUrl;
            _local_1 = (Lang.msg("人口") + ": ");
            _local_1 = memberInfoBean.population;
            _local_1 = (Lang.msg("排名") + ": ");
            _local_1 = memberInfoBean.ranking;
            _local_1 = (Lang.msg("城池数") + ": ");
            _local_1 = memberInfoBean.castleCount;
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = memberInfoBean.prestige;
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = memberInfoBean.honor;
            _local_1 = (Lang.msg("联盟职位") + ": ");
            _local_1 = memberInfoBean.allianceLevel;
            _local_1 = Lang.msg("更改权限");
            _local_1 = canChangePower;
            _local_1 = Lang.msg("逐出");
            _local_1 = ((memberInfoBean.levelId > Context.getInstance().getPlayerBean().playerInfo.levelId) ? true : false);
            _local_1 = Lang.msg("写信");
            _local_1 = isOwner;
            _local_1 = isOwner;
        }

        private function set memberInfoBean(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._19962424memberInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._19962424memberInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberInfoBean", _local_2, _arg_1));
            };
        }

        public function __exitBtn_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        private function set canChangePower(_arg_1:Boolean):void
        {
            var _local_2:Object = this._112621893canChangePower;
            if (_local_2 !== _arg_1)
            {
                this._112621893canChangePower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canChangePower", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AllianceMemberInfoShow;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceMemberInfoShow_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceMember_AllianceMemberInfoShowWatcherSetupUtil");
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

        private function set dataPCB(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443179717dataPCB;
            if (_local_2 !== _arg_1)
            {
                this._1443179717dataPCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataPCB", _local_2, _arg_1));
            };
        }

        public function ___AllianceMemberInfoShow_Button3_click(_arg_1:MouseEvent):void
        {
            writeMail();
        }

        [Bindable(event="propertyChange")]
        private function get isOwner():Boolean
        {
            return (this._2067570601isOwner);
        }

        [Bindable(event="propertyChange")]
        private function get curMemberId():int
        {
            return (this._497023925curMemberId);
        }

        public function set officePostCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1748641499officePostCB;
            if (_local_2 !== _arg_1)
            {
                this._1748641499officePostCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officePostCB", _local_2, _arg_1));
            };
        }

        public function ___AllianceMemberInfoShow_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set exitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1315418018exitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1315418018exitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataPCB():ArrayCollection
        {
            return (this._1443179717dataPCB);
        }

        [Bindable(event="propertyChange")]
        public function get officePostCB():ComboBox
        {
            return (this._1748641499officePostCB);
        }

        public function ___AllianceMemberInfoShow_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set resetLevel(_arg_1:Button):void
        {
            var _local_2:Object = this._1694398603resetLevel;
            if (_local_2 !== _arg_1)
            {
                this._1694398603resetLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resetLevel", _local_2, _arg_1));
            };
        }

        private function onKickOutMemberFromAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("开除成员成功"));
                MinePopupManager.instance.removePopup();
                ActionFactory.getInstance().getAllianceCommands().getAllianceMembers();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.module.alliance.oldAlliance.allianceMember

