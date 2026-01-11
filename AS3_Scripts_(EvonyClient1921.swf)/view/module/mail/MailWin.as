// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.mail.MailWin

package view.module.mail
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.ToggleButtonBar;
    import com.evony.util.EvonyImage;
    import mx.controls.TextArea;
    import mx.controls.Text;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.utils.ObjectProxy;
    import mx.containers.ViewStack;
    import mx.containers.Canvas;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.containers.VBox;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.data.NewMailEventData;
    import view.AllWindows;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.MailBean;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import view.ui.AlertWin;
    import com.evony.common.module.friend.FriendResponse;
    import com.evony.common.module.CommandResponse;
    import mx.core.ClassFactory;
    import com.evony.common.constants.MailConstants;
    import mx.events.ItemClickEvent;
    import com.evony.Context;
    import com.evony.common.server.events.NewMail;
    import mx.binding.BindingManager;
    import flash.events.Event;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.TextEvent;
    import com.evony.util.InputTextFilter;
    import mx.binding.Binding;
    import com.evony.common.module.mail.MailResponse;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.mail.MailListResponse;
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

    public class MailWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "MailWin.open";
        private static var isWrite:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _MailWin_Label10:Label;
        public var _MailWin_Label11:Label;
        private var _11548545buttonBar:ToggleButtonBar;
        public var _MailWin_EvonyImage1:EvonyImage;
        public var _MailWin_EvonyImage2:EvonyImage;
        public var _MailWin_Array1:Array;
        private var curMailBox:int = 1;
        public var _MailWin_TextArea1:TextArea;
        public var _MailWin_Text1:Text;
        public var _MailWin_Text3:Text;
        public var _MailWin_DataGridColumn2:DataGridColumn;
        public var _MailWin_DataGridColumn4:DataGridColumn;
        public var _MailWin_DataGridColumn3:DataGridColumn;
        public var _MailWin_Text4:Text;
        private var _177664693sysMailCount:int;
        private var _1682980096replyBtnVisible:Boolean = false;
        private var _90754191_bean:ObjectProxy;
        private var _875838146mailContent:String;
        private var _1584105760viewStach:ViewStack;
        private var _2059856384replyUserName:String;
        public var _MailWin_Label2:Label;
        public var _MailWin_Label3:Label;
        public var _MailWin_Label4:Label;
        public var _MailWin_Label5:Label;
        private var isSelectAll:Boolean = false;
        public var _MailWin_Label7:Label;
        public var _MailWin_Label1:Label;
        public var _MailWin_Label9:Label;
        public var _MailWin_Label6:Label;
        public var _MailWin_Label8:Label;
        private var _100344454inbox:Canvas;
        private var _95356390dataP:ArrayCollection;
        private var _246425450markShow:Boolean = true;
        private var _688059345sendContent:TextArea;
        public var _MailWin_Button3:Button;
        public var _MailWin_Button4:Button;
        public var _MailWin_Button5:Button;
        public var _MailWin_Button6:Button;
        public var _MailWin_Button7:Button;
        public var _MailWin_Button8:Button;
        private var _2103625714receiveName:TextInput;
        private var _1941741961inboxDG:DataGrid;
        private var _1753307928mailDetail:Canvas;
        private var iPreTime:int = 0;
        private var _503520896sendTitle0:Text;
        private var strUrl:String = "";
        private var _16242608sendTitle:TextInput;
        private var _1815601705inboxCount:int;
        private var itemCount:int = 10;
        private var _577409037totalPage:int = 0;
        private var _1125923055curPage:int = 1;
        private var _1406547402writeMail:Canvas;
        public var _MailWin_Label12:Label;
        public var _MailWin_Label13:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"buttonBar",
                        "events":{"itemClick":"__buttonBar_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.left = "35";
                            this.top = "64";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":500,
                                "height":29,
                                "dataProvider":_MailWin_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewStach",
                        "stylesFactory":function ():void
                        {
                            this.top = "62";
                            this.bottom = "38";
                            this.left = "34";
                            this.right = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"inbox",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.right = "10";
                                                    this.verticalAlign = "middle";
                                                    this.top = "-4";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___MailWin_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"previous"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MailWin_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"ftp14f",
                                                                    "width":66
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___MailWin_Button2_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"next"});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"inboxDG",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "32";
                                                    this.bottom = "36";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_MailWin_DataGridColumn1_c(), _MailWin_DataGridColumn2_i(), _MailWin_DataGridColumn3_i(), _MailWin_DataGridColumn4_i()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_MailWin_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "5";
                                                    this.left = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ParamgraphText1",
                                                        "selectable":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "1";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button3",
                                                            "events":{"click":"___MailWin_Button3_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":10});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button4",
                                                            "events":{"click":"___MailWin_Button4_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":10});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button5",
                                                            "events":{"click":"___MailWin_Button5_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        })]});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"mailDetail",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "visible":false,
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "32";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":105,
                                                        "percentWidth":100,
                                                        "styleName":"textBackground",
                                                        "label":"mailTitle",
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                                this.top = "10";
                                                                this.right = "10";
                                                                this.bottom = "10";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 2;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label2",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"focusColor"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label3",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"focusColor"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label4",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"focusColor"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label5",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "right";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"focusColor"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 2;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label6",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"tableContent2"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label7",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"tableContent2"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label8",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"tableContent2"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_MailWin_Label9",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "styleName":"tableContent2"
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
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "36";
                                                    this.top = "142";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "label":"mailBody",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"_MailWin_TextArea1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "0";
                                                                this.right = "0";
                                                                this.top = "5";
                                                                this.bottom = "5";
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"editable":false});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.bottom = "1";
                                                    this.right = "5";
                                                    this.horizontalGap = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button6",
                                                            "events":{"click":"___MailWin_Button6_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button7",
                                                            "events":{"click":"___MailWin_Button7_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"sendTitle0",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.bottom = "5";
                                                    this.left = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ParamgraphText1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"writeMail",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "visible":false,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "32";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"textBackground",
                                                        "height":70,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MailWin_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.left = "5";
                                                                this.top = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "height":23,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"receiveName",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "85";
                                                                this.top = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":343,
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MailWin_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.left = "5";
                                                                this.top = "40";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "height":23,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"sendTitle",
                                                            "events":{"change":"__sendTitle_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "85";
                                                                this.top = "40";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":343,
                                                                    "maxChars":24,
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MailWin_Text3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "432";
                                                                this.top = "40";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":309,
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
                                                    this.bottom = "36";
                                                    this.top = "108";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"mailMessage",
                                                        "percentWidth":100,
                                                        "x":0,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"sendContent",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"",
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "x":0,
                                                                    "y":0,
                                                                    "styleName":"inputArea",
                                                                    "maxChars":500
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "bottom";
                                                    this.horizontalAlign = "right";
                                                    this.bottom = "1";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MailWin_Button8",
                                                            "events":{"click":"___MailWin_Button8_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_MailWin_Text4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.bottom = "5";
                                                    this.left = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ParamgraphText1",
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":109,
                                "y":55,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_MailWin_EvonyImage1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@mailAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MailWin_Label12",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "17";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
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
                                "x":219,
                                "y":55,
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_MailWin_EvonyImage2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@mailAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MailWin_Label13",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "17";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        private var _1870011207titleStr:String = Lang.msg("发信人");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MailWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.borderStyle = "none";
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___MailWin_BaseFunctionWindowEx1_creationComplete);
        }

        public static function writeMailToPlayer(_arg_1:String):void
        {
            var _local_2:NewMailEventData = new NewMailEventData();
            _local_2.targetUsername = _arg_1;
            isWrite = true;
            AllWindows.switchToFuncWindow(EVENT_SHOW, _local_2);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MailWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get replyUserName():String
        {
            return (this._2059856384replyUserName);
        }

        private function set replyUserName(_arg_1:String):void
        {
            var _local_2:Object = this._2059856384replyUserName;
            if (_local_2 !== _arg_1)
            {
                this._2059856384replyUserName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "replyUserName", _local_2, _arg_1));
            };
        }

        private function onMarkAsReadSelected():void
        {
            var _local_1:String;
            var _local_2:MailBean;
            if (this.dataP != null)
            {
                _local_1 = "";
                for each (_local_2 in this.dataP)
                {
                    if (_local_2.selected)
                    {
                        if (_local_1.length > 0)
                        {
                            _local_1 = (_local_1 + ",");
                        };
                        _local_1 = (_local_1 + _local_2.mailid);
                    };
                };
            };
            if (_local_1.length > 0)
            {
                ActionFactory.getInstance().getMailCommands().readOverMailList(_local_1, onMarkSelectedResponse);
            };
        }

        public function ___MailWin_Button5_click(_arg_1:MouseEvent):void
        {
            onDelectMailSelected();
        }

        [Bindable(event="propertyChange")]
        public function get receiveName():TextInput
        {
            return (this._2103625714receiveName);
        }

        public function set receiveName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2103625714receiveName;
            if (_local_2 !== _arg_1)
            {
                this._2103625714receiveName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiveName", _local_2, _arg_1));
            };
        }

        private function set replyBtnVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1682980096replyBtnVisible;
            if (_local_2 !== _arg_1)
            {
                this._1682980096replyBtnVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "replyBtnVisible", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get inboxCount():int
        {
            return (this._1815601705inboxCount);
        }

        [Bindable(event="propertyChange")]
        public function get writeMail():Canvas
        {
            return (this._1406547402writeMail);
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function onBlockResponse(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok)
            {
                AlertWin.show(Lang.msg("屏蔽成功"));
            };
        }

        public function ___MailWin_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        private function set inboxCount(_arg_1:int):void
        {
            var _local_2:Object = this._1815601705inboxCount;
            if (_local_2 !== _arg_1)
            {
                this._1815601705inboxCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inboxCount", _local_2, _arg_1));
            };
        }

        private function onSendMail(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("发送成功"));
                this.receiveName.text = "";
                this.sendTitle.text = "";
                this.sendContent.text = "";
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set writeMail(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1406547402writeMail;
            if (_local_2 !== _arg_1)
            {
                this._1406547402writeMail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "writeMail", _local_2, _arg_1));
            };
        }

        public function set lookUpStr(_arg_1:String):void
        {
            var _local_2:Object = this._1120764471lookUpStr;
            if (_local_2 !== _arg_1)
            {
                this._1120764471lookUpStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookUpStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sendTitle0():Text
        {
            return (this._503520896sendTitle0);
        }

        [Bindable(event="propertyChange")]
        public function get inbox():Canvas
        {
            return (this._100344454inbox);
        }

        private function _MailWin_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MailWin_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get _bean():ObjectProxy
        {
            return (this._90754191_bean);
        }

        private function changeAllCheckBox(_arg_1:Boolean):void
        {
            var _local_2:MailBean;
            if (this.dataP != null)
            {
                for each (_local_2 in this.dataP)
                {
                    _local_2.selected = _arg_1;
                };
            };
            this.isSelectAll = _arg_1;
        }

        public function ___MailWin_Button7_click(_arg_1:MouseEvent):void
        {
            back();
        }

        private function set sysMailCount(_arg_1:int):void
        {
            var _local_2:Object = this._177664693sysMailCount;
            if (_local_2 !== _arg_1)
            {
                this._177664693sysMailCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sysMailCount", _local_2, _arg_1));
            };
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    markShow = true;
                    this.reReadMailFromServer(MailConstants.MAIL_RECEIVE);
                    return;
                case 1:
                    markShow = true;
                    this.reReadMailFromServer(MailConstants.MAIL_SYSTEM);
                    return;
                case 2:
                    markShow = false;
                    this.reReadMailFromServer(MailConstants.MAIL_SEND);
                    return;
                case 3:
                    this._bean = null;
                    this.replyUserName = "";
                    if (this.receiveName != null)
                    {
                        this.receiveName.text = "";
                    };
                    this.viewStach.selectedChild = this.writeMail;
                    return;
            };
        }

        private function onHasNewMail(_arg_1:NewMail):void
        {
            this.sysMailCount = Context.getInstance().getPlayerBean().newMaileCount_system;
            this.inboxCount = Context.getInstance().getPlayerBean().newMaileCount_inbox;
        }

        [Bindable(event="propertyChange")]
        private function get titleStr():String
        {
            return (this._1870011207titleStr);
        }

        [Bindable(event="propertyChange")]
        private function get mailContent():String
        {
            return (this._875838146mailContent);
        }

        private function _MailWin_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MailWin_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___MailWin_Button4_click(_arg_1:MouseEvent):void
        {
            onSelectAll();
        }

        private function set markShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._246425450markShow;
            if (_local_2 !== _arg_1)
            {
                this._246425450markShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "markShow", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            var _local_1:NewMailEventData;
            trace((this.className + " refresh()"));
            if (isWrite)
            {
                this.buttonBar.selectedIndex = 3;
                isWrite = false;
            }
            else
            {
                markShow = true;
                if (inboxCount >= sysMailCount)
                {
                    this.buttonBar.selectedIndex = 0;
                }
                else
                {
                    this.buttonBar.selectedIndex = 1;
                };
            };
            this.curMailBox = MailConstants.MAIL_RECEIVE;
            if (this.eventData != null)
            {
                _local_1 = (eventData as NewMailEventData);
                this.replyUserName = _local_1.targetUsername;
                this.eventData = null;
                this.viewStach.selectedChild = this.writeMail;
                this._bean = null;
            }
            else
            {
                if (inboxCount >= sysMailCount)
                {
                    this.reReadMailFromServer(MailConstants.MAIL_RECEIVE);
                }
                else
                {
                    this.reReadMailFromServer(MailConstants.MAIL_SYSTEM);
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewStach():ViewStack
        {
            return (this._1584105760viewStach);
        }

        private function back():void
        {
            this.viewStach.selectedChild = this.inbox;
            reReadMailFromServer(curMailBox);
        }

        [Bindable(event="propertyChange")]
        public function get mailDetail():Canvas
        {
            return (this._1753307928mailDetail);
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function _MailWin_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MailWin_DataGridColumn4 = _local_1;
            _local_1.dataField = "receiveTime";
            _local_1.width = 200;
            BindingManager.executeBindings(this, "_MailWin_DataGridColumn4", _MailWin_DataGridColumn4);
            return (_local_1);
        }

        public function set sendTitle0(_arg_1:Text):void
        {
            var _local_2:Object = this._503520896sendTitle0;
            if (_local_2 !== _arg_1)
            {
                this._503520896sendTitle0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sendTitle0", _local_2, _arg_1));
            };
        }

        public function __sendTitle_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get replyBtnVisible():Boolean
        {
            return (this._1682980096replyBtnVisible);
        }

        public function set buttonBar(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._11548545buttonBar;
            if (_local_2 !== _arg_1)
            {
                this._11548545buttonBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonBar", _local_2, _arg_1));
            };
        }

        private function _MailWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MailWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onDelectMailSelected():void
        {
            var _local_1:String;
            var _local_2:MailBean;
            if (this.dataP != null)
            {
                _local_1 = "";
                for each (_local_2 in this.dataP)
                {
                    if (_local_2.selected)
                    {
                        if (_local_1.length > 0)
                        {
                            _local_1 = (_local_1 + ",");
                        };
                        _local_1 = (_local_1 + _local_2.mailid);
                    };
                };
            };
            if (_local_1.length > 0)
            {
                ActionFactory.getInstance().getMailCommands().deleteMail(_local_1);
            };
        }

        public function set inbox(_arg_1:Canvas):void
        {
            var _local_2:Object = this._100344454inbox;
            if (_local_2 !== _arg_1)
            {
                this._100344454inbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inbox", _local_2, _arg_1));
            };
        }

        public function ___MailWin_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        private function init():void
        {
            this.sysMailCount = Context.getInstance().getPlayerBean().newMaileCount_system;
            this.inboxCount = Context.getInstance().getPlayerBean().newMaileCount_inbox;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_MAIL, onHasNewMail);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.MAIL_DELETE_MAIL, onMailDelete);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.MAIL_READ_MAIL, onReadMail);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.MAIL_RECEIVE_MAIL_LIST, onReceiveMail);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.MAIL_SEND_MAIL, onSendMail);
            this.addEventListener(TextEvent.LINK, linkHandler);
        }

        public function set inboxDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1941741961inboxDG;
            if (_local_2 !== _arg_1)
            {
                this._1941741961inboxDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inboxDG", _local_2, _arg_1));
            };
        }

        private function set _bean(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._90754191_bean;
            if (_local_2 !== _arg_1)
            {
                this._90754191_bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_bean", _local_2, _arg_1));
            };
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        public function getNowDateToNumber():Number
        {
            var _local_1:Date = new Date();
            return (Math.floor((_local_1.time / 1000)));
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.readMailFromServer();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        private function textChange(_arg_1:Event):void
        {
            var _local_4:String;
            var _local_2:int;
            this.sendTitle.maxChars = 100;
            var _local_3:int;
            while (_local_3 < _arg_1.target.text.length)
            {
                _local_4 = _arg_1.target.text.substr(_local_3, 1);
                if (InputTextFilter.isChinese(_local_4))
                {
                    _local_2 = (_local_2 + 2);
                }
                else
                {
                    _local_2 = (_local_2 + 1);
                };
                if (_local_2 > 24)
                {
                    this.sendTitle.text = this.sendTitle.text.substring(0, _local_3);
                    this.sendTitle.maxChars = this.sendTitle.length;
                    return;
                };
                _local_3++;
            };
        }

        private function _MailWin_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MailWin_DataGridColumn3 = _local_1;
            _local_1.dataField = "sender";
            _local_1.width = 150;
            _local_1.itemRenderer = _MailWin_ClassFactory3_c();
            BindingManager.executeBindings(this, "_MailWin_DataGridColumn3", _MailWin_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get sysMailCount():int
        {
            return (this._177664693sysMailCount);
        }

        public function ___MailWin_Button6_click(_arg_1:MouseEvent):void
        {
            writeBack();
        }

        private function _MailWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("信件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("收件箱"));
            }, function (_arg_1:*):void
            {
                _MailWin_Array1[0] = _arg_1;
            }, "_MailWin_Array1[0]");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("系统信"));
            }, function (_arg_1:*):void
            {
                _MailWin_Array1[1] = _arg_1;
            }, "_MailWin_Array1[1]");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("发件箱"));
            }, function (_arg_1:*):void
            {
                _MailWin_Array1[2] = _arg_1;
            }, "_MailWin_Array1[2]");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("写信件"));
            }, function (_arg_1:*):void
            {
                _MailWin_Array1[3] = _arg_1;
            }, "_MailWin_Array1[3]");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label1.text = _arg_1;
            }, "_MailWin_Label1.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataP);
            }, function (_arg_1:Object):void
            {
                inboxDG.dataProvider = _arg_1;
            }, "inboxDG.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("主题");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_DataGridColumn2.headerText = _arg_1;
            }, "_MailWin_DataGridColumn2.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.titleStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_DataGridColumn3.headerText = _arg_1;
            }, "_MailWin_DataGridColumn3.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("接收时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_DataGridColumn4.headerText = _arg_1;
            }, "_MailWin_DataGridColumn4.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器只保留最近10天的信件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Text1.text = _arg_1;
            }, "_MailWin_Text1.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("标记为已读");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button3.label = _arg_1;
            }, "_MailWin_Button3.label");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (markShow);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_Button3.visible = _arg_1;
            }, "_MailWin_Button3.visible");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("全部选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button4.label = _arg_1;
            }, "_MailWin_Button4.label");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("删除选定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button5.label = _arg_1;
            }, "_MailWin_Button5.label");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("收信人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label2.text = _arg_1;
            }, "_MailWin_Label2.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("发信人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label3.text = _arg_1;
            }, "_MailWin_Label3.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("主题") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label4.text = _arg_1;
            }, "_MailWin_Label4.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label5.text = _arg_1;
            }, "_MailWin_Label5.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _bean.receiver;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label6.text = _arg_1;
            }, "_MailWin_Label6.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _bean.sender;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label7.text = _arg_1;
            }, "_MailWin_Label7.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _bean.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label8.text = _arg_1;
            }, "_MailWin_Label8.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _bean.receiveTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label9.text = _arg_1;
            }, "_MailWin_Label9.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.mailContent;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_TextArea1.htmlText = _arg_1;
            }, "_MailWin_TextArea1.htmlText");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("回复");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button6.label = _arg_1;
            }, "_MailWin_Button6.label");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.replyBtnVisible);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_Button6.visible = _arg_1;
            }, "_MailWin_Button6.visible");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button7.label = _arg_1;
            }, "_MailWin_Button7.label");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器只保留最近10天的信件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sendTitle0.text = _arg_1;
            }, "sendTitle0.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("收信人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label10.text = _arg_1;
            }, "_MailWin_Label10.text");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.replyUserName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                receiveName.text = _arg_1;
            }, "receiveName.text");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("主题") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label11.text = _arg_1;
            }, "_MailWin_Label11.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((_bean) ? ((Lang.msg("回复") + ":") + _bean.title) : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sendTitle.text = _arg_1;
            }, "sendTitle.text");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("信件内容最多500个字");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Text3.text = _arg_1;
            }, "_MailWin_Text3.text");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发送");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Button8.label = _arg_1;
            }, "_MailWin_Button8.label");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器只保留最近10天的信件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Text4.text = _arg_1;
            }, "_MailWin_Text4.text");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((inboxCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_EvonyImage1.visible = _arg_1;
            }, "_MailWin_EvonyImage1.visible");
            result[35] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.inboxCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label12.text = _arg_1;
            }, "_MailWin_Label12.text");
            result[36] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((inboxCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_Label12.visible = _arg_1;
            }, "_MailWin_Label12.visible");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((sysMailCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_EvonyImage2.visible = _arg_1;
            }, "_MailWin_EvonyImage2.visible");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.sysMailCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MailWin_Label13.text = _arg_1;
            }, "_MailWin_Label13.text");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((sysMailCount == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _MailWin_Label13.visible = _arg_1;
            }, "_MailWin_Label13.visible");
            result[40] = binding;
            return (result);
        }

        private function sendMail():void
        {
            if (this.sendTitle.text == "")
            {
                AlertWin.show(Lang.msg("主题不能为空"));
                return;
            };
            if (this.receiveName.text == "")
            {
                AlertWin.show(Lang.msg("收信人不能为空"));
                return;
            };
            if (this.sendContent.text == "")
            {
                AlertWin.show(Lang.msg("邮件内容不能为空"));
                return;
            };
            if ((getNowDateToNumber() - iPreTime) < 5)
            {
                AlertWin.show("There is a 5 second cooldown on sending messages.");
                return;
            };
            ActionFactory.getInstance().getMailCommands().sendMail(receiveName.text, this.sendTitle.text, this.sendContent.text, onSendMail);
            iPreTime = getNowDateToNumber();
        }

        public function set sendTitle(_arg_1:TextInput):void
        {
            var _local_2:Object = this._16242608sendTitle;
            if (_local_2 !== _arg_1)
            {
                this._16242608sendTitle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sendTitle", _local_2, _arg_1));
            };
        }

        public function writeBack():void
        {
            if (this.receiveName != null)
            {
                this.receiveName.text = this.replyUserName;
            };
            this.viewStach.selectedChild = this.writeMail;
            this.buttonBar.selectedIndex = 3;
        }

        private function onMarkSelectedResponse(_arg_1:MailResponse):void
        {
            var _local_2:MailBean;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                for each (_local_2 in this.dataP)
                {
                    if (_local_2.selected)
                    {
                        _local_2.isRead = MailConstants.IS_READ;
                        _local_2.selected = false;
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get markShow():Boolean
        {
            return (this._246425450markShow);
        }

        private function onReadMail(_arg_1:MailResponse):void
        {
            var _local_2:int = _arg_1.title.indexOf("(Link)");
            if (_local_2 != -1)
            {
                navigateToURL(new URLRequest(_arg_1.content), "_blank");
                return;
            };
            if (_arg_1.title.indexOf("Vote for the") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 0, GameConfig.instance.serverID);
                };
            };
            if (_arg_1.title.indexOf("It's Halloween at Evony!") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 3, GameConfig.instance.serverID);
                };
            };
            if (_arg_1.title.indexOf("Halloween Chest ") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 2, GameConfig.instance.serverID);
                };
            };
            if (_arg_1.title.indexOf("It's Christmas at Evony!") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 4, GameConfig.instance.serverID);
                };
            };
            if (_arg_1.title.indexOf("Sent You a Secret Santa Chest!") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 5, GameConfig.instance.serverID);
                };
            };
            if (_arg_1.title.indexOf("It's New Year’s at Evony!") != -1)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 6, GameConfig.instance.serverID);
                };
            }
            else
            {
                if (_arg_1.title.indexOf("Valentine’s Day Chest") != -1)
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 8, GameConfig.instance.serverID);
                    };
                }
                else
                {
                    if (_arg_1.title.indexOf("It's Valentine’s Day") != -1)
                    {
                        if (ExternalInterface.available)
                        {
                            ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 7, GameConfig.instance.serverID);
                        };
                    }
                    else
                    {
                        if (_arg_1.title.indexOf("St Patrick’s Day system email open") != -1)
                        {
                            if (ExternalInterface.available)
                            {
                                ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 9, GameConfig.instance.serverID);
                            };
                        }
                        else
                        {
                            if (_arg_1.title.indexOf("St Patrick’s Day friend send email open") != -1)
                            {
                                if (ExternalInterface.available)
                                {
                                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 10, GameConfig.instance.serverID);
                                };
                            }
                            else
                            {
                                if (_arg_1.title.indexOf("Happy Easter from Evony!") != -1)
                                {
                                    if (ExternalInterface.available)
                                    {
                                        ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 11, GameConfig.instance.serverID);
                                    };
                                }
                                else
                                {
                                    if (_arg_1.title.indexOf("Sent You a Special Easter Chest!") != -1)
                                    {
                                        if (ExternalInterface.available)
                                        {
                                            ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 12, GameConfig.instance.serverID);
                                        };
                                    }
                                    else
                                    {
                                        if (_arg_1.title.indexOf("an Awesome Package") != -1)
                                        {
                                            if (ExternalInterface.available)
                                            {
                                                ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 13, GameConfig.instance.serverID);
                                            };
                                        }
                                        else
                                        {
                                            if (_arg_1.title.indexOf("You a Hollow Wooden Bull") != -1)
                                            {
                                                if (ExternalInterface.available)
                                                {
                                                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 14, GameConfig.instance.serverID);
                                                };
                                            }
                                            else
                                            {
                                                if (_arg_1.title.indexOf("Wage War Like a Caesar") != -1)
                                                {
                                                    if (ExternalInterface.available)
                                                    {
                                                        ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 15, GameConfig.instance.serverID);
                                                    };
                                                }
                                                else
                                                {
                                                    if (_arg_1.title.indexOf("Sent You a Special Evony Happiness Chest") != -1)
                                                    {
                                                        if (ExternalInterface.available)
                                                        {
                                                            ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 16, GameConfig.instance.serverID);
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (_arg_1.title.indexOf("Every Cloud Has a Silver Lining") != -1)
                                                        {
                                                            if (ExternalInterface.available)
                                                            {
                                                                ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 17, GameConfig.instance.serverID);
                                                            };
                                                        }
                                                        else
                                                        {
                                                            if (_arg_1.title.indexOf("Got locked Chests") != -1)
                                                            {
                                                                if (ExternalInterface.available)
                                                                {
                                                                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 18, GameConfig.instance.serverID);
                                                                };
                                                            }
                                                            else
                                                            {
                                                                if (_arg_1.title.indexOf("Trick or Treat! It's Halloween! System email open.") != -1)
                                                                {
                                                                    if (ExternalInterface.available)
                                                                    {
                                                                        ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 19, GameConfig.instance.serverID);
                                                                    };
                                                                }
                                                                else
                                                                {
                                                                    if (_arg_1.title.indexOf("Trick or Treat! It's Halloween! Friend email open") != -1)
                                                                    {
                                                                        if (ExternalInterface.available)
                                                                        {
                                                                            ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 20, GameConfig.instance.serverID);
                                                                        };
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_arg_1.title.indexOf("Double Cents and Biggest Chests Ever") != -1)
                                                                        {
                                                                            if (ExternalInterface.available)
                                                                            {
                                                                                ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 21, GameConfig.instance.serverID);
                                                                            };
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_arg_1.title.indexOf("sent you a Battlechest of Christmas") != -1)
                                                                            {
                                                                                if (ExternalInterface.available)
                                                                                {
                                                                                    ExternalInterface.call("openmail", Context.getInstance().getPlayerBean().playerInfo.userId, 22, GameConfig.instance.serverID);
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            var _local_3:Object = new Object();
            _local_3["mailid"] = _arg_1.mailid;
            _local_3["title"] = _arg_1.title;
            _local_3["content"] = _arg_1.content;
            mailContent = _arg_1.content.replace("CLICK HERE", '<a href="event:here"><font color="#ff0000">CLICK HERE</font></a>');
            mailContent = mailContent.replace("CLICK HERE2", '<a href="event:here"><font color="#ff0000">CLICK HERE</font></a>');
            var _local_4:String = mailContent;
            var _local_5:int = _local_4.indexOf("HREFhttp");
            if (_local_5 != -1)
            {
                strUrl = _local_4.substr((_local_5 + 4));
                _local_4 = _local_4.substring(0, _local_5);
                mailContent = _local_4;
            };
            _local_3["receiver"] = _arg_1.receiver;
            _local_3["sender"] = _arg_1.sender;
            _local_3["receiveTime"] = _arg_1.receiveTime;
            this._bean = new ObjectProxy(_local_3);
        }

        private function reReadMailFromServer(_arg_1:int):void
        {
            this.viewStach.selectedChild = this.inbox;
            this.curMailBox = _arg_1;
            this.curPage = 0;
            this.totalPage = 0;
            this.readMailFromServer();
        }

        private function set titleStr(_arg_1:String):void
        {
            var _local_2:Object = this._1870011207titleStr;
            if (_local_2 !== _arg_1)
            {
                this._1870011207titleStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "titleStr", _local_2, _arg_1));
            };
        }

        private function _MailWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MailWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "title";
            _local_1.width = 400;
            _local_1.itemRenderer = _MailWin_ClassFactory2_c();
            BindingManager.executeBindings(this, "_MailWin_DataGridColumn2", _MailWin_DataGridColumn2);
            return (_local_1);
        }

        private function onMailDelete(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.readMailFromServer();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set mailContent(_arg_1:String):void
        {
            var _local_2:Object = this._875838146mailContent;
            if (_local_2 !== _arg_1)
            {
                this._875838146mailContent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailContent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        [Bindable(event="propertyChange")]
        public function get inboxDG():DataGrid
        {
            return (this._1941741961inboxDG);
        }

        public function ___MailWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:MailWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MailWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_mail_MailWinWatcherSetupUtil");
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

        public function ___MailWin_Button3_click(_arg_1:MouseEvent):void
        {
            onMarkAsReadSelected();
        }

        public function set sendContent(_arg_1:TextArea):void
        {
            var _local_2:Object = this._688059345sendContent;
            if (_local_2 !== _arg_1)
            {
                this._688059345sendContent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sendContent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sendTitle():TextInput
        {
            return (this._16242608sendTitle);
        }

        private function _MailWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.dataField = "mailid";
            _local_1.width = 30;
            _local_1.headerText = "";
            _local_1.itemRenderer = _MailWin_ClassFactory1_c();
            return (_local_1);
        }

        public function set viewStach(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1584105760viewStach;
            if (_local_2 !== _arg_1)
            {
                this._1584105760viewStach = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewStach", _local_2, _arg_1));
            };
        }

        public function blockPlayer():void
        {
            if (this._bean["mailid"])
            {
                ActionFactory.getInstance().getFriendCommands().isBlockMailPlayer(this._bean["mailid"], onBlockResponse);
            };
        }

        public function set mailDetail(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1753307928mailDetail;
            if (_local_2 !== _arg_1)
            {
                this._1753307928mailDetail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailDetail", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sendContent():TextArea
        {
            return (this._688059345sendContent);
        }

        public function ___MailWin_Button8_click(_arg_1:MouseEvent):void
        {
            sendMail();
        }

        private function readMailFromServer():void
        {
            this.dataP = null;
            if (this.curMailBox == MailConstants.MAIL_SEND)
            {
                this.titleStr = Lang.msg("收信人To");
            }
            else
            {
                this.titleStr = Lang.msg("发信人From");
            };
            ActionFactory.getInstance().getMailCommands().receiveMailList(curPage, this.curMailBox, itemCount);
        }

        private function onReceiveMail(_arg_1:MailListResponse):void
        {
            var _local_2:MailBean;
            if (this.curMailBox == MailConstants.MAIL_SEND)
            {
                for each (_local_2 in _arg_1.mailsArray)
                {
                    _local_2.sender = _local_2.receiver;
                };
            };
            this.dataP = _arg_1.mailsArray;
            this.totalPage = _arg_1.totalPage;
            this.curPage = _arg_1.pageNo;
        }

        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        private function _MailWin_Array1_i():Array
        {
            var _local_1:Array = [null, null, null, null];
            _MailWin_Array1 = _local_1;
            BindingManager.executeBindings(this, "_MailWin_Array1", _MailWin_Array1);
            return (_local_1);
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        private function onSelectAll():void
        {
            this.changeAllCheckBox((!(isSelectAll)));
        }

        private function linkHandler(_arg_1:TextEvent):void
        {
            trace(_arg_1.text);
            if (_arg_1.text.indexOf("here") == -1)
            {
                return;
            };
            if (strUrl != "")
            {
                navigateToURL(new URLRequest(strUrl), "_blank");
            }
            else
            {
                navigateToURL(new URLRequest(((GameConfig.instance.strEvony3Url + "&user=") + Context.getInstance().userName)), "_blank");
            };
        }

        private function _MailWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("信件");
            _local_1 = Lang.msg("收件箱");
            _local_1 = Lang.msg("系统信");
            _local_1 = Lang.msg("发件箱");
            _local_1 = Lang.msg("写信件");
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = dataP;
            _local_1 = Lang.msg("主题");
            _local_1 = this.titleStr;
            _local_1 = Lang.msg("接收时间");
            _local_1 = Lang.msg("服务器只保留最近10天的信件");
            _local_1 = Lang.msg("标记为已读");
            _local_1 = markShow;
            _local_1 = Lang.msg("全部选择");
            _local_1 = Lang.msg("删除选定");
            _local_1 = (Lang.msg("收信人") + ": ");
            _local_1 = (Lang.msg("发信人") + ": ");
            _local_1 = (Lang.msg("主题") + ": ");
            _local_1 = (Lang.msg("时间") + ": ");
            _local_1 = _bean.receiver;
            _local_1 = _bean.sender;
            _local_1 = _bean.title;
            _local_1 = _bean.receiveTime;
            _local_1 = this.mailContent;
            _local_1 = Lang.msg("回复");
            _local_1 = this.replyBtnVisible;
            _local_1 = Lang.msg("返回");
            _local_1 = Lang.msg("服务器只保留最近10天的信件");
            _local_1 = (Lang.msg("收信人") + ": ");
            _local_1 = this.replyUserName;
            _local_1 = (Lang.msg("主题") + ": ");
            _local_1 = ((_bean) ? ((Lang.msg("回复") + ":") + _bean.title) : "");
            _local_1 = Lang.msg("信件内容最多500个字");
            _local_1 = Lang.msg("发送");
            _local_1 = Lang.msg("服务器只保留最近10天的信件");
            _local_1 = ((inboxCount == 0) ? false : true);
            _local_1 = this.inboxCount;
            _local_1 = ((inboxCount == 0) ? false : true);
            _local_1 = ((sysMailCount == 0) ? false : true);
            _local_1 = this.sysMailCount;
            _local_1 = ((sysMailCount == 0) ? false : true);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function onSeeAbout(_arg_1:MailBean):void
        {
            var _local_2:int = _arg_1.title.indexOf("(Link)");
            if (_local_2 != -1)
            {
                ActionFactory.getInstance().getMailCommands().readMail(_arg_1.mailid);
                return;
            };
            var _local_3:Object = new Object();
            _local_3["mailid"] = _arg_1.mailid;
            _local_3["title"] = _arg_1.title;
            _local_3["receiver"] = _arg_1.receiver;
            _local_3["sender"] = _arg_1.sender;
            _local_3["receiveTime"] = _arg_1.receiveTime;
            this._bean = new ObjectProxy(_local_3);
            this.viewStach.selectedChild = this.mailDetail;
            if (this.curMailBox == MailConstants.MAIL_RECEIVE)
            {
                this.replyUserName = _arg_1.sender;
                this.replyBtnVisible = true;
            }
            else
            {
                if (this.curMailBox == MailConstants.MAIL_SEND)
                {
                    this.replyUserName = _arg_1.receiver;
                    this.replyBtnVisible = false;
                }
                else
                {
                    this.replyBtnVisible = false;
                };
            };
            ActionFactory.getInstance().getMailCommands().readMail(_arg_1.mailid);
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }


    }
}//package view.module.mail

