// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.PlayerInfoWin

package view.module.playerInfo
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.DataGrid;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.collections.ArrayCollection;
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import com.evony.common.beans.PlayerBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.factory.PlayerInfoTypeManager;
    import com.evony.common.constants.HeroConstants;
    import flash.events.IOErrorEvent;
    import mx.core.ClassFactory;
    import com.evony.common.beans.BuffBean;
    import com.evony.util.UIUtil;
    import com.evony.common.beans.CastleBean;
    import view.module.herosMansion.HeroProperties;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import view.ui.AlertWin;
    import com.evony.util.ImageSmooth;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.hero.SetShowInfroResponse;
    import flash.display.Bitmap;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import com.evony.GameConfig;
    import flash.net.URLRequestMethod;
    import com.evony.client.action.ActionFactory;
    import com.evony.Coordinate;
    import view.module.office.CurFieldView;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import com.evony.events.EnterCastleEvent;
    import mx.events.FlexEvent;
    import mx.events.ListEvent;
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

    public class PlayerInfoWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "PlayerInfoWin.open";
        public static var instance:PlayerInfoWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _PlayerInfoWin_Text1:Text;
        public var _PlayerInfoWin_Text2:Text;
        public var _PlayerInfoWin_Text3:Text;
        public var _PlayerInfoWin_Text4:Text;
        public var _PlayerInfoWin_DataGrid1:DataGrid;
        public var _PlayerInfoWin_Text6:Text;
        public var _PlayerInfoWin_Text7:Text;
        public var _PlayerInfoWin_Text8:Text;
        public var _PlayerInfoWin_Text9:Text;
        public var _PlayerInfoWin_Text5:Text;
        private var _815231871playerInfoBean:PlayerInfoBean;
        public var _PlayerInfoWin_Label2:Label;
        public var _PlayerInfoWin_Label4:Label;
        public var _PlayerInfoWin_Label6:Label;
        public var _PlayerInfoWin_Label1:Label;
        public var _PlayerInfoWin_Label9:Label;
        public var _PlayerInfoWin_Label3:Label;
        public var _PlayerInfoWin_Label5:Label;
        public var _PlayerInfoWin_Label7:Label;
        public var _PlayerInfoWin_Label8:Label;
        private var _188814270changePicBtn:Button;
        private var _742881793changeNameBtn:Button;
        private var _774879744playerPeaceBuff:Boolean = false;
        private var _835356941totalPeople:int;
        private var _3010670accProtectBtn:Button;
        private var _1318185952stateStr:Text;
        private var _703018170statusChangeBtn:Button;
        public var _PlayerInfoWin_Text10:Text;
        private var _202689522playerNewBuff:Boolean = false;
        public var _PlayerInfoWin_Text13:Text;
        public var _PlayerInfoWin_Text12:Text;
        private var _993849131playerPeaceCoolDownBuff:Boolean = false;
        public var _PlayerInfoWin_Image1:Image;
        private var buffsArray:ArrayCollection;
        public var _PlayerInfoWin_Label10:Label;
        public var _PlayerInfoWin_Label11:Label;
        public var _PlayerInfoWin_Label12:Label;
        private var _2006448278heroTotal:int;
        private var _913715584flagChangeBtn:Button;
        private var _2095520559playerInfo:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"playerInfo",
                        "stylesFactory":function ():void
                        {
                            this.top = "20";
                            this.bottom = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"playerInfo",
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "43";
                                        this.right = "40";
                                        this.bottom = "97";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":370,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_PlayerInfoWin_DataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.borderStyle = "solid";
                                                    this.borderThickness = 1;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "rowCount":10,
                                                        "rowHeight":35,
                                                        "styleName":"style2",
                                                        "draggableColumns":false,
                                                        "columns":[_PlayerInfoWin_DataGridColumn1_c(), _PlayerInfoWin_DataGridColumn2_c(), _PlayerInfoWin_DataGridColumn3_c(), _PlayerInfoWin_DataGridColumn4_c(), _PlayerInfoWin_DataGridColumn5_c(), _PlayerInfoWin_DataGridColumn6_c(), _PlayerInfoWin_DataGridColumn7_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "35";
                                        this.top = "43";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":375,
                                            "height":180,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "9";
                                                    this.right = "10";
                                                    this.horizontalAlign = "center";
                                                    this.verticalGap = 4;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_PlayerInfoWin_Image1",
                                                            "events":{
                                                                "complete":"___PlayerInfoWin_Image1_complete",
                                                                "click":"___PlayerInfoWin_Image1_click"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "height":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"changePicBtn",
                                                            "events":{"click":"__changePicBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"Blue75"});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 8;
                                                    this.left = "5";
                                                    this.top = "8";
                                                    this.bottom = "3";
                                                    this.right = "100";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 3;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "label":"username",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label1",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":60,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "height":24,
                                                                                "label":"userName",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_PlayerInfoWin_Text1",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                        this.left = "0";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"changeNameBtn",
                                                                        "events":{"click":"__changeNameBtn_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"Blue75"});
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
                                                                return ({
                                                                    "source":"images/Controls/tab/line.png",
                                                                    "percentWidth":100
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
                                                                    "percentWidth":100,
                                                                    "label":"alliance",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":160,
                                                                                "height":24,
                                                                                "label":"Alliance",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_PlayerInfoWin_Text2",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                        this.left = "0";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
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
                                                                return ({
                                                                    "source":"images/Controls/tab/line.png",
                                                                    "percentWidth":100
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
                                                                    "percentWidth":100,
                                                                    "label":"office",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":160,
                                                                                "height":24,
                                                                                "label":"office",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_PlayerInfoWin_Text3",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                        this.left = "0";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
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
                                                                return ({
                                                                    "source":"images/Controls/tab/line.png",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "label":"title",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":160,
                                                                                "height":24,
                                                                                "label":"title",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_PlayerInfoWin_Text4",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                        this.left = "0";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
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
                                                                return ({
                                                                    "source":"images/Controls/tab/line.png",
                                                                    "percentWidth":100
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
                                        this.top = "206";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":375,
                                            "x":35,
                                            "height":115,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "5";
                                                    this.top = "6";
                                                    this.bottom = "5";
                                                    this.left = "5";
                                                    this.horizontalGap = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalGap = 5;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":50,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "label":"population",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label5",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":110,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":80,
                                                                                            "height":27,
                                                                                            "label":"population",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text5",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
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
                                                                            return ({
                                                                                "source":"images/Controls/tab/line.png",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "label":"castleCount",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label6",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":110,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":80,
                                                                                            "height":27,
                                                                                            "label":"castleCount",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text6",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
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
                                                                            return ({
                                                                                "source":"images/Controls/tab/line.png",
                                                                                "percentWidth":100
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
                                                                                "percentWidth":100,
                                                                                "label":"heroCount",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label7",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":110,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":80,
                                                                                            "height":27,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text7",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
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
                                                                            return ({
                                                                                "source":"images/Controls/tab/line.png",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalGap = 5;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":50,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "label":"ranking",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label8",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":75,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":120,
                                                                                            "height":27,
                                                                                            "label":"ranking",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text8",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
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
                                                                            return ({
                                                                                "source":"images/Controls/tab/line.png",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "label":"prestige",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label9",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":75,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":120,
                                                                                            "height":27,
                                                                                            "label":"prestige",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text9",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
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
                                                                            return ({
                                                                                "source":"images/Controls/tab/line.png",
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "label":"honor",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PlayerInfoWin_Label10",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":75,
                                                                                            "styleName":"PropertyName1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":120,
                                                                                            "height":27,
                                                                                            "label":"ranking",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Text,
                                                                                                "id":"_PlayerInfoWin_Text10",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.horizontalCenter = "0";
                                                                                                    this.verticalCenter = "0";
                                                                                                    this.textAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "selectable":false,
                                                                                                        "styleName":"PropertyValue1"
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
                                                        })]});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":35,
                                            "y":321,
                                            "width":375,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 7;
                                                    this.left = "5";
                                                    this.top = "6";
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 3;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "label":"status",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label11",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":80,
                                                                                "height":27,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"stateStr",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "0";
                                                                                        this.horizontalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"statusChangeBtn",
                                                                        "events":{"click":"__statusChangeBtn_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"Blue75"});
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
                                                                return ({
                                                                    "source":"images/Controls/tab/line.png",
                                                                    "percentWidth":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 3;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "label":"flag",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PlayerInfoWin_Label12",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":110,
                                                                                "styleName":"PropertyName1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":80,
                                                                                "height":27,
                                                                                "label":"flag",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_PlayerInfoWin_Text12",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.verticalCenter = "3";
                                                                                        this.horizontalCenter = "0";
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "selectable":false,
                                                                                            "styleName":"PropertyValue1"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"flagChangeBtn",
                                                                        "events":{"click":"__flagChangeBtn_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"Blue75"});
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
                                        this.left = "35";
                                        this.top = "420";
                                        this.right = "35";
                                        this.bottom = "13";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_PlayerInfoWin_Text13",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.left = "10";
                                                    this.right = "10";
                                                    this.bottom = "10";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "selectable":false,
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___PlayerInfoWin_Button5_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "3";
                                                    this.right = "200";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Security code",
                                                        "styleName":"y165",
                                                        "visible":true
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"accProtectBtn",
                                                "events":{"click":"__accProtectBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "3";
                                                    this.right = "10";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Account Protection",
                                                        "styleName":"y165",
                                                        "enabled":false
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var _985752863player:PlayerBean = Context.getInstance().getPlayerBean();
        private var _267503458myCityArray:ArrayCollection = new ArrayCollection();
        private var _619157576heroList:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PlayerInfoWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.creationPolicy = "all";
            this.addEventListener("creationComplete", ___PlayerInfoWin_BaseFunctionWindowEx1_creationComplete);
            this.addEventListener("removedFromStage", ___PlayerInfoWin_BaseFunctionWindowEx1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerInfoWin._watcherSetupUtil = _arg_1;
        }


        public function set changeNameBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._742881793changeNameBtn;
            if (_local_2 !== _arg_1)
            {
                this._742881793changeNameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeNameBtn", _local_2, _arg_1));
            };
        }

        private function refreshSelectList():void
        {
            var _local_1:Boolean;
            var _local_2:HeroListBean;
            var _local_3:int;
            for each (_local_2 in heroList)
            {
                _local_1 = false;
                _local_3 = 0;
                while (_local_3 < player.setshowinfroArray.length)
                {
                    if (_local_2.id == player.setshowinfroArray[_local_3].selectshowheroid)
                    {
                        _local_1 = true;
                        break;
                    };
                    _local_3++;
                };
                if (_local_1)
                {
                    _local_2.selected = true;
                }
                else
                {
                    _local_2.selected = false;
                };
            };
        }

        private function sortByLevel():void
        {
            var _local_1:Sort = new Sort();
            var _local_2:SortField = new SortField();
            _local_2.descending = true;
            _local_2.name = "level";
            _local_2.numeric = true;
            _local_1.fields = [_local_2];
            heroList.sort = _local_1;
            heroList.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get changeNameBtn():Button
        {
            return (this._742881793changeNameBtn);
        }

        private function _PlayerInfoWin_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Select";
            _local_1.dataField = "selected";
            _local_1.width = 60;
            _local_1.sortable = false;
            _local_1.itemRenderer = _PlayerInfoWin_ClassFactory3_c();
            return (_local_1);
        }

        private function set playerInfoBean(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._815231871playerInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._815231871playerInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfoBean", _local_2, _arg_1));
            };
        }

        private function _PlayerInfoWin_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Atk";
            _local_1.dataField = "attack";
            _local_1.width = 40;
            return (_local_1);
        }

        private function init():void
        {
            instance = this;
            this.player = Context.getInstance().getPlayerBean();
            this.playerInfoBean = this.player.playerInfo;
            this.setCityArray();
            this.setPopTotal();
            this.setHeroTotal();
            this.checkBuffs();
            this.checkAccountProtection();
            this.getHeroList();
            this.sortByLevel();
        }

        public function ___PlayerInfoWin_Image1_click(_arg_1:MouseEvent):void
        {
            clickRoleHandle();
        }

        public function set flagChangeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._913715584flagChangeBtn;
            if (_local_2 !== _arg_1)
            {
                this._913715584flagChangeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagChangeBtn", _local_2, _arg_1));
            };
        }

        public function __flagChangeBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        public function __changePicBtn_click(_arg_1:MouseEvent):void
        {
            changePlayerPic();
        }

        private function _PlayerInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroList);
            }, function (_arg_1:Object):void
            {
                _PlayerInfoWin_DataGrid1.dataProvider = _arg_1;
            }, "_PlayerInfoWin_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.playerInfoBean.faceUrl);
            }, function (_arg_1:Object):void
            {
                _PlayerInfoWin_Image1.source = _arg_1;
            }, "_PlayerInfoWin_Image1.source");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                changePicBtn.label = _arg_1;
            }, "changePicBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().getPlayerBean().changedFace) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                changePicBtn.enabled = _arg_1;
            }, "changePicBtn.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label1.text = _arg_1;
            }, "_PlayerInfoWin_Label1.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text1.text = _arg_1;
            }, "_PlayerInfoWin_Text1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                changeNameBtn.label = _arg_1;
            }, "changeNameBtn.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所属联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label2.text = _arg_1;
            }, "_PlayerInfoWin_Label2.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text2.text = _arg_1;
            }, "_PlayerInfoWin_Text2.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("官职") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label3.text = _arg_1;
            }, "_PlayerInfoWin_Label3.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text3.text = _arg_1;
            }, "_PlayerInfoWin_Text3.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("爵位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label4.text = _arg_1;
            }, "_PlayerInfoWin_Label4.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = PlayerInfoTypeManager.getTitle(this.playerInfoBean.titleId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text4.text = _arg_1;
            }, "_PlayerInfoWin_Text4.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label5.text = _arg_1;
            }, "_PlayerInfoWin_Label5.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.totalPeople;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text5.text = _arg_1;
            }, "_PlayerInfoWin_Text5.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label6.text = _arg_1;
            }, "_PlayerInfoWin_Label6.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.player.castlesArray.length;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text6.text = _arg_1;
            }, "_PlayerInfoWin_Text6.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("英雄数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label7.text = _arg_1;
            }, "_PlayerInfoWin_Label7.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.heroTotal;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text7.text = _arg_1;
            }, "_PlayerInfoWin_Text7.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("排名") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label8.text = _arg_1;
            }, "_PlayerInfoWin_Label8.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.ranking;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text8.text = _arg_1;
            }, "_PlayerInfoWin_Text8.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label9.text = _arg_1;
            }, "_PlayerInfoWin_Label9.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text9.text = _arg_1;
            }, "_PlayerInfoWin_Text9.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label10.text = _arg_1;
            }, "_PlayerInfoWin_Label10.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text10.text = _arg_1;
            }, "_PlayerInfoWin_Text10.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家状态") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label11.text = _arg_1;
            }, "_PlayerInfoWin_Label11.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((playerPeaceBuff == true) ? Lang.msg("免战") : ((playerNewBuff == true) ? Lang.msg("新手") : Lang.msg("正常")));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                stateStr.text = _arg_1;
            }, "stateStr.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("修改玩家状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                statusChangeBtn.label = _arg_1;
            }, "statusChangeBtn.label");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家旗号") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Label12.text = _arg_1;
            }, "_PlayerInfoWin_Label12.text");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.flag;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text12.text = _arg_1;
            }, "_PlayerInfoWin_Text12.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("修改玩家旗号");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                flagChangeBtn.label = _arg_1;
            }, "flagChangeBtn.label");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("账号密保说明");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfoWin_Text13.text = _arg_1;
            }, "_PlayerInfoWin_Text13.text");
            result[32] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get playerInfo():Canvas
        {
            return (this._2095520559playerInfo);
        }

        private function _PlayerInfoWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Lvl";
            _local_1.dataField = "level";
            _local_1.width = 45;
            return (_local_1);
        }

        private function heroLoca(_arg_1:int):String
        {
            var _local_2:String;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_3:int;
            while (_local_3 < player.castlesArray.length)
            {
                _local_4 = 0;
                while (_local_4 < player.getCastles(_local_3).herosArray.length)
                {
                    if (_arg_1 == player.getCastles(_local_3).getHeros(_local_4).id)
                    {
                        if (player.getCastles(_local_3).getHeros(_local_4).status == HeroConstants.HERO_GUARD_STATU)
                        {
                            _local_5 = 0;
                            while (_local_5 < player.getCastles(_local_3).fieldsArray.length)
                            {
                                _local_6 = 0;
                                while (_local_6 < player.getCastles(_local_3).getFields(_local_5).armysArray.length)
                                {
                                    if (_arg_1 == player.getCastles(_local_3).getFields(_local_5).getArmys(_local_6).heroid)
                                    {
                                        _local_2 = ((player.getCastles(_local_3).getFields(_local_5).name + " Lv") + player.getCastles(_local_3).getFields(_local_5).level);
                                    };
                                    _local_6++;
                                };
                                _local_5++;
                            };
                        }
                        else
                        {
                            _local_2 = player.getCastles(_local_3).name;
                        };
                    };
                    _local_4++;
                };
                _local_3++;
            };
            return (_local_2);
        }

        private function changePlayerPic():void
        {
            PlayerFaceSelect.show();
        }

        [Bindable(event="propertyChange")]
        private function get totalPeople():int
        {
            return (this._835356941totalPeople);
        }

        [Bindable(event="propertyChange")]
        public function get changePicBtn():Button
        {
            return (this._188814270changePicBtn);
        }

        private function _PlayerInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("玩家信息");
            _local_1 = heroList;
            _local_1 = this.playerInfoBean.faceUrl;
            _local_1 = Lang.msg("更改");
            _local_1 = ((Context.getInstance().getPlayerBean().changedFace) ? false : true);
            _local_1 = (Lang.msg("君主") + ": ");
            _local_1 = this.playerInfoBean.userName;
            _local_1 = Lang.msg("更改");
            _local_1 = (Lang.msg("所属联盟") + ": ");
            _local_1 = this.playerInfoBean.alliance;
            _local_1 = (Lang.msg("官职") + ": ");
            _local_1 = this.playerInfoBean.office;
            _local_1 = (Lang.msg("爵位") + ": ");
            _local_1 = PlayerInfoTypeManager.getTitle(this.playerInfoBean.titleId);
            _local_1 = (Lang.msg("人口") + ": ");
            _local_1 = this.totalPeople;
            _local_1 = (Lang.msg("城池数") + ": ");
            _local_1 = this.player.castlesArray.length;
            _local_1 = (Lang.msg("英雄数") + ": ");
            _local_1 = this.heroTotal;
            _local_1 = (Lang.msg("排名") + ": ");
            _local_1 = this.playerInfoBean.ranking;
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = this.playerInfoBean.prestige;
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = this.playerInfoBean.honor;
            _local_1 = (Lang.msg("玩家状态") + ": ");
            _local_1 = ((playerPeaceBuff == true) ? Lang.msg("免战") : ((playerNewBuff == true) ? Lang.msg("新手") : Lang.msg("正常")));
            _local_1 = Lang.msg("修改玩家状态");
            _local_1 = (Lang.msg("玩家旗号") + ": ");
            _local_1 = this.playerInfoBean.flag;
            _local_1 = Lang.msg("修改玩家旗号");
            _local_1 = Lang.msg("账号密保说明");
        }

        [Bindable(event="propertyChange")]
        private function get playerPeaceCoolDownBuff():Boolean
        {
            return (this._993849131playerPeaceCoolDownBuff);
        }

        private function errorHandle(_arg_1:IOErrorEvent):void
        {
        }

        private function _PlayerInfoWin_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Location";
            _local_1.dataField = "location";
            _local_1.width = 80;
            _local_1.sortable = false;
            _local_1.itemRenderer = _PlayerInfoWin_ClassFactory2_c();
            return (_local_1);
        }

        private function _PlayerInfoWin_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PlayerInfoWin_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function checkBuffs():void
        {
            var _local_2:BuffBean;
            buffsArray = player.buffsArray;
            var _local_1:int;
            while (_local_1 < buffsArray.length)
            {
                _local_2 = buffsArray[_local_1];
                if (((_local_2.typeId == "PlayerPeaceBuff") || (_local_2.typeId == "PlayerPeaceUniteServerBuff")))
                {
                    playerPeaceBuff = true;
                };
                if (_local_2.typeId == "PlayerPeaceCoolDownBuff")
                {
                    playerPeaceCoolDownBuff = true;
                };
                _local_1++;
            };
            if (!UIUtil.checkOffice())
            {
                playerNewBuff = true;
            };
        }

        private function getHeroList():void
        {
            var _local_2:CastleBean;
            var _local_3:int;
            var _local_4:HeroListBean;
            var _local_5:int;
            heroList.removeAll();
            var _local_1:int;
            while (_local_1 < player.castlesArray.length)
            {
                _local_2 = player.castlesArray[_local_1];
                _local_3 = 0;
                while (_local_3 < _local_2.herosArray.length)
                {
                    if (_local_2.herosArray[_local_3].status != HeroConstants.HERO_SEIZED_STATU)
                    {
                        _local_4 = new HeroListBean();
                        _local_4.id = _local_2.herosArray[_local_3].id;
                        _local_4.name = _local_2.herosArray[_local_3].name;
                        _local_4.level = _local_2.herosArray[_local_3].level;
                        _local_4.attack = (_local_2.herosArray[_local_3].attack + _local_2.herosArray[_local_3].power);
                        _local_4.politics = (_local_2.herosArray[_local_3].politics + _local_2.herosArray[_local_3].management);
                        _local_4.intelligence = (_local_2.herosArray[_local_3].intelligence + _local_2.herosArray[_local_3].stratagem);
                        _local_4.location = this.heroLoca(_local_4.id);
                        _local_5 = 0;
                        while (_local_5 < player.setshowinfroArray.length)
                        {
                            if (_local_4.id == player.setshowinfroArray[_local_5].selectshowheroid)
                            {
                                _local_4.selected = true;
                            };
                            _local_5++;
                        };
                        heroList.addItem(_local_4);
                    };
                    _local_3++;
                };
                _local_1++;
            };
        }

        private function set playerPeaceCoolDownBuff(_arg_1:Boolean):void
        {
            var _local_2:Object = this._993849131playerPeaceCoolDownBuff;
            if (_local_2 !== _arg_1)
            {
                this._993849131playerPeaceCoolDownBuff = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerPeaceCoolDownBuff", _local_2, _arg_1));
            };
        }

        private function setHeroTotal():void
        {
            var _local_3:CastleBean;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this.player.castlesArray.length)
            {
                _local_3 = this.player.castlesArray[_local_2];
                _local_1 = (_local_1 + _local_3.herosArray.length);
                _local_2++;
            };
            this.heroTotal = _local_1;
        }

        private function changeNameHandle():void
        {
            NameChangeWin.show();
        }

        public function set playerInfo(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get myCityArray():ArrayCollection
        {
            return (this._267503458myCityArray);
        }

        private function setCityArray():void
        {
            var _local_1:int;
            var _local_2:CastleBean;
            if (this.player.castlesArray.length > 0)
            {
                myCityArray.removeAll();
                while (_local_1 < this.player.castlesArray.length)
                {
                    _local_2 = this.player.castlesArray[_local_1];
                    myCityArray.addItem(_local_2);
                    _local_1++;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get accProtectBtn():Button
        {
            return (this._3010670accProtectBtn);
        }

        [Bindable(event="propertyChange")]
        private function get heroTotal():int
        {
            return (this._2006448278heroTotal);
        }

        public function set statusChangeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._703018170statusChangeBtn;
            if (_local_2 !== _arg_1)
            {
                this._703018170statusChangeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusChangeBtn", _local_2, _arg_1));
            };
        }

        private function set heroList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._619157576heroList;
            if (_local_2 !== _arg_1)
            {
                this._619157576heroList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroList", _local_2, _arg_1));
            };
        }

        private function set totalPeople(_arg_1:int):void
        {
            var _local_2:Object = this._835356941totalPeople;
            if (_local_2 !== _arg_1)
            {
                this._835356941totalPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPeople", _local_2, _arg_1));
            };
        }

        private function _PlayerInfoWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Name";
            _local_1.dataField = "name";
            _local_1.width = 65;
            _local_1.sortable = false;
            _local_1.itemRenderer = _PlayerInfoWin_ClassFactory1_c();
            return (_local_1);
        }

        private function _PlayerInfoWin_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Int";
            _local_1.dataField = "intelligence";
            _local_1.width = 40;
            return (_local_1);
        }

        public function onClickHero(_arg_1:Object):void
        {
            var _local_4:int;
            var _local_5:HeroProperties;
            var _local_2:HeroListBean = (_arg_1 as HeroListBean);
            var _local_3:int;
            while (_local_3 < player.castlesArray.length)
            {
                _local_4 = 0;
                while (_local_4 < player.getCastles(_local_3).herosArray.length)
                {
                    if (player.getCastles(_local_3).getHeros(_local_4).id == _local_2.id)
                    {
                        _local_5 = new HeroProperties();
                        if (!_local_5.isPopUp)
                        {
                            PopUpManager.addPopUp(_local_5, MainFrame.instance, false);
                        };
                        _local_5._heroMes = player.getCastles(_local_3).getHeros(_local_4);
                        return;
                    };
                    _local_4++;
                };
                _local_3++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get flagChangeBtn():Button
        {
            return (this._913715584flagChangeBtn);
        }

        public function set changePicBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._188814270changePicBtn;
            if (_local_2 !== _arg_1)
            {
                this._188814270changePicBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changePicBtn", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:PlayerInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_PlayerInfoWinWatcherSetupUtil");
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

        private function _PlayerInfoWin_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PlayerInfoWin_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function __accProtectBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        public function ___PlayerInfoWin_BaseFunctionWindowEx1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function btnHandle(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.id)
            {
                case "statusChangeBtn":
                    if (((!(playerPeaceBuff)) || (!(playerPeaceCoolDownBuff))))
                    {
                        StageChangeWin.show(this.stateStr.text);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("免战状态或免战冷却状态中不能再使用免战"));
                    };
                    return;
                case "flagChangeBtn":
                    FlagChangeWin.show();
                    return;
                case "accProtectBtn":
                    AccountProtectionWin.show();
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerPeaceBuff():Boolean
        {
            return (this._774879744playerPeaceBuff);
        }

        public function ___PlayerInfoWin_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get playerInfoBean():PlayerInfoBean
        {
            return (this._815231871playerInfoBean);
        }

        private function onSetShowHero(_arg_1:SetShowInfroResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                player.setshowinfroArray = _arg_1.selectheroidsArray;
                this.refreshSelectList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set playerPeaceBuff(_arg_1:Boolean):void
        {
            var _local_2:Object = this._774879744playerPeaceBuff;
            if (_local_2 !== _arg_1)
            {
                this._774879744playerPeaceBuff = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerPeaceBuff", _local_2, _arg_1));
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        [Bindable(event="propertyChange")]
        private function get heroList():ArrayCollection
        {
            return (this._619157576heroList);
        }

        public function set stateStr(_arg_1:Text):void
        {
            var _local_2:Object = this._1318185952stateStr;
            if (_local_2 !== _arg_1)
            {
                this._1318185952stateStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stateStr", _local_2, _arg_1));
            };
        }

        private function completeHandle(_arg_1:Event):void
        {
            if (_arg_1.target.data == "E01")
            {
                Context.getInstance().noAccountProtection = false;
            }
            else
            {
                Context.getInstance().noAccountProtection = true;
            };
        }

        private function checkAccountProtection():void
        {
            var _local_1:URLLoader = new URLLoader();
            var _local_2:URLRequest = new URLRequest();
            var _local_3:URLVariables = new URLVariables();
            _local_1.addEventListener(Event.COMPLETE, completeHandle, false, 0, true);
            _local_1.addEventListener(IOErrorEvent.IO_ERROR, errorHandle, false, 0, true);
            _local_2.url = ((GameConfig.instance.accountProtectUrl + "PageModule=IsProtect&u=") + Context.getInstance().userName);
            _local_2.method = URLRequestMethod.POST;
            _local_1.load(_local_2);
        }

        private function _PlayerInfoWin_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Pol";
            _local_1.dataField = "politics";
            _local_1.width = 40;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get statusChangeBtn():Button
        {
            return (this._703018170statusChangeBtn);
        }

        public function changeHero(_arg_1:Object):void
        {
            var _local_2:HeroListBean = (_arg_1 as HeroListBean);
            var _local_3:int;
            while (_local_3 < heroList.length)
            {
                if (_local_2.id == heroList[_local_3].id)
                {
                    heroList[_local_3].selected = (!(heroList[_local_3].selected));
                };
                _local_3++;
            };
            ActionFactory.getInstance().getHeroCommand().SetShowHeroId(_local_2.id, _local_2.selected, onSetShowHero);
        }

        private function set myCityArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._267503458myCityArray;
            if (_local_2 !== _arg_1)
            {
                this._267503458myCityArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myCityArray", _local_2, _arg_1));
            };
        }

        public function onSecurityCode():void
        {
            if (Context.getInstance().getPlayerBean().isSetSecurityCode)
            {
                if (Context.getInstance().bCancelSecurityCode)
                {
                    CancelSecurityCode.show(0);
                }
                else
                {
                    if (Context.getInstance().bLoginSecurityCode)
                    {
                        SetSecurity.show();
                    }
                    else
                    {
                        ApplySecurityCode.show(0);
                    };
                };
            }
            else
            {
                SetSecurityCode.show();
            };
        }

        public function onClickLocation(_arg_1:Object):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Coordinate;
            var _local_2:HeroListBean = (_arg_1 as HeroListBean);
            var _local_3:int;
            while (_local_3 < player.castlesArray.length)
            {
                _local_4 = 0;
                while (_local_4 < player.getCastles(_local_3).herosArray.length)
                {
                    if (_local_2.id == player.getCastles(_local_3).getHeros(_local_4).id)
                    {
                        if (player.getCastles(_local_3).getHeros(_local_4).status == HeroConstants.HERO_GUARD_STATU)
                        {
                            _local_5 = 0;
                            while (_local_5 < player.getCastles(_local_3).fieldsArray.length)
                            {
                                _local_6 = 0;
                                while (_local_6 < player.getCastles(_local_3).getFields(_local_5).armysArray.length)
                                {
                                    if (_local_2.id == player.getCastles(_local_3).getFields(_local_5).getArmys(_local_6).heroid)
                                    {
                                        _local_7 = new Coordinate(player.getCastles(_local_3).getFields(_local_5).id);
                                        CurFieldView.show(player.getCastles(_local_3).getFields(_local_5), _local_7, (((("(" + _local_7.x) + ",") + _local_7.y) + ")"));
                                        return;
                                    };
                                    _local_6++;
                                };
                                _local_5++;
                            };
                        }
                        else
                        {
                            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
                            Context.getInstance().setCurCastle(player.getCastles(_local_3));
                            EnterCastleEvent.enterCastle(true);
                            return;
                        };
                    };
                    _local_4++;
                };
                _local_3++;
            };
        }

        private function set player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        public function ___PlayerInfoWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set heroTotal(_arg_1:int):void
        {
            var _local_2:Object = this._2006448278heroTotal;
            if (_local_2 !== _arg_1)
            {
                this._2006448278heroTotal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroTotal", _local_2, _arg_1));
            };
        }

        private function _PlayerInfoWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PlayerInfoWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function refresh():void
        {
            super.refresh();
            this.player = Context.getInstance().getPlayerBean();
            this.playerInfoBean = this.player.playerInfo;
            this.setCityArray();
            this.setPopTotal();
            this.setHeroTotal();
            this.checkBuffs();
            this.getHeroList();
        }

        [Bindable(event="propertyChange")]
        private function get player():PlayerBean
        {
            return (this._985752863player);
        }

        public function ___PlayerInfoWin_Button5_click(_arg_1:MouseEvent):void
        {
            onSecurityCode();
        }

        private function set playerNewBuff(_arg_1:Boolean):void
        {
            var _local_2:Object = this._202689522playerNewBuff;
            if (_local_2 !== _arg_1)
            {
                this._202689522playerNewBuff = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerNewBuff", _local_2, _arg_1));
            };
        }

        private function clickRoleHandle():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get stateStr():Text
        {
            return (this._1318185952stateStr);
        }

        public function __changeNameBtn_click(_arg_1:MouseEvent):void
        {
            changeNameHandle();
        }

        public function set accProtectBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._3010670accProtectBtn;
            if (_local_2 !== _arg_1)
            {
                this._3010670accProtectBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accProtectBtn", _local_2, _arg_1));
            };
        }

        public function __statusChangeBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get playerNewBuff():Boolean
        {
            return (this._202689522playerNewBuff);
        }

        override public function destroy():void
        {
            if (FlagChangeWin.instance)
            {
                PopUpManager.removePopUp(FlagChangeWin.instance);
            }
            else
            {
                if (NameChangeWin.instance)
                {
                    PopUpManager.removePopUp(NameChangeWin.instance);
                }
                else
                {
                    if (StageChangeWin.instance)
                    {
                        PopUpManager.removePopUp(StageChangeWin.instance);
                    };
                };
            };
        }

        private function setPopTotal():void
        {
            var _local_3:CastleBean;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this.player.castlesArray.length)
            {
                _local_3 = this.player.castlesArray[_local_2];
                _local_1 = (_local_1 + _local_3.resource.curPopulation);
                _local_2++;
            };
            this.totalPeople = _local_1;
        }

        private function viewCastle(_arg_1:ListEvent):void
        {
            if (_arg_1.itemRenderer.data)
            {
                if (_arg_1.itemRenderer.data.id != Context.getInstance().getCurCastle().id)
                {
                    Context.getInstance().setCurCastle((_arg_1.itemRenderer.data as CastleBean));
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
                };
            };
        }


    }
}//package view.module.playerInfo

