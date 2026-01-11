// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.PrestigeRank

package view.module.rank
{
    import view.ui.BaseWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.ToggleButtonBar;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import mx.containers.ViewStack;
    import com.evony.common.beans.ItemBean;
    import view.ui.WinTitle;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.MainWin;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import flash.events.MouseEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import mx.events.ItemClickEvent;
    import mx.core.ClassFactory;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.celeb.CelebResponse;
    import com.evony.Context;
    import com.evony.common.server.events.CelebRankCompleteTipResponse;
    import mx.events.FlexEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import com.evony.common.beans.*;
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

    public class PrestigeRank extends BaseWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "PrestigeRank.open";
        public static var instance:PrestigeRank = new (PrestigeRank)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1341206824questTypeTBB:ToggleButtonBar;
        public var _PrestigeRank_DataGridColumn1:DataGridColumn;
        public var _PrestigeRank_DataGridColumn2:DataGridColumn;
        public var _PrestigeRank_DataGridColumn3:DataGridColumn;
        private var _892024219strArg:String = "";
        public var _PrestigeRank_Label1:Label;
        public var _PrestigeRank_Label2:Label;
        public var _PrestigeRank_Label3:Label;
        public var _PrestigeRank_Label4:Label;
        private var pageSize:int = 100;
        private var _655126789questDg:DataGrid;
        private var _425636739questTypeArray:ArrayCollection;
        public var _PrestigeRank_Array2:Array;
        private var _946505330viewstack1:ViewStack;
        private var _995752784pageNo:int = 1;
        private var bean:ItemBean;
        private var _577409037totalPage:int = 0;
        private var _946505329viewstack2:ViewStack;
        private var winTitle:WinTitle;
        private var _776676342curSelectRankIndex:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":505,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "90";
                            this.bottom = "30";
                            this.right = "34";
                            this.left = "210";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"viewstack2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"n1",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PrestigeRank_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "25";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":98,
                                                                    "percentHeight":98,
                                                                    "styleName":"ParamgraphText2"
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
                                                        "label":"n2",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PrestigeRank_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "25";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":98,
                                                                    "percentHeight":98,
                                                                    "styleName":"ParamgraphText2"
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
                                                        "label":"n3",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PrestigeRank_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "25";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":98,
                                                                    "percentHeight":98,
                                                                    "styleName":"ParamgraphText2"
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
                                                        "label":"n4",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PrestigeRank_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "25";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":98,
                                                                    "percentHeight":98,
                                                                    "styleName":"ParamgraphText2"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"questDg",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "50";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "selectable":false,
                                            "sortableColumns":false,
                                            "columns":[_PrestigeRank_DataGridColumn1_i(), _PrestigeRank_DataGridColumn2_i(), _PrestigeRank_DataGridColumn3_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"questTypeTBB",
                        "events":{"itemClick":"__questTypeTBB_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.left = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":635,
                                "dataProvider":_PrestigeRank_Array2_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.right = "5";
                            this.bottom = "56";
                            this.top = "90";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"playerVs",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.verticalGap = 10;
                                                    this.bottom = "16";
                                                    this.left = "34";
                                                    this.right = "553";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button1_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"10,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button2_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"25,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button3_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"50,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button4_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"100,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button5_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"250,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button6_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"500,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button7_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"1,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button8_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"2,500,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button9_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"5,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button10_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"10,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
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
                                            "label":"title",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.verticalGap = 5;
                                                    this.bottom = "16";
                                                    this.left = "34";
                                                    this.right = "553";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button11_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Baron",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button12_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Viscount",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button13_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Earl",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button14_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Marquis",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button15_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Duke",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button16_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Furstin",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button17_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Prinzessin",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
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
                                            "label":"alliance",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.verticalGap = 5;
                                                    this.bottom = "16";
                                                    this.left = "34";
                                                    this.right = "553";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button18_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"1,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button19_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"2,500,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button20_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"5,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button21_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"10,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button22_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"25,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button23_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"50,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button24_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"100,000,000",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
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
                                            "label":"playerVs",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "10";
                                                    this.verticalGap = 10;
                                                    this.bottom = "16";
                                                    this.left = "34";
                                                    this.right = "553";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button25_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 5 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button26_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 8 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button27_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 9 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button28_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 10 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button29_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 11 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button30_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 12 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button31_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 13 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button32_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 14 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PrestigeRank_Button33_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "19";
                                                                this.right = "30";
                                                                this.fontSize = 12;
                                                                this.paddingBottom = 0;
                                                                this.paddingTop = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Star level 15 set",
                                                                    "styleName":"b135",
                                                                    "width":140,
                                                                    "height":25
                                                                });
                                                            }
                                                        })]});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PrestigeRank()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 505;
            this.styleName = "BaseFunctionWindow";
            this.addEventListener("creationComplete", ___PrestigeRank_BaseWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___PrestigeRank_BaseWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PrestigeRank._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            UIUtil.setPopopHelpWindowStye(instance);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainWin.instance, true);
            };
            if ((Application.application.width - instance.width) > 0)
            {
                instance.x = (((Application.application.width - instance.width) / 2) - 150);
                instance.y = (((Application.application.height - instance.height) / 2) - 30);
                PopUpManager.bringToFront(instance);
            }
            else
            {
                PopUpManager.centerPopUp(instance);
            };
        }


        private function set questTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._425636739questTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._425636739questTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get questDg():DataGrid
        {
            return (this._655126789questDg);
        }

        private function _PrestigeRank_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PrestigeRank_DataGridColumn3 = _local_1;
            _local_1.dataField = "date";
            _local_1.width = 80;
            _local_1.itemRenderer = _PrestigeRank_ClassFactory3_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_PrestigeRank_DataGridColumn3", _PrestigeRank_DataGridColumn3);
            return (_local_1);
        }

        public function set questDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._655126789questDg;
            if (_local_2 !== _arg_1)
            {
                this._655126789questDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDg", _local_2, _arg_1));
            };
        }

        public function ___PrestigeRank_Button21_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button25_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(5);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CELEB_FIND_PLAYER_BY_PRESTIGE, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CELEB_FIND_PLAYER_BY_TITLE, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CELEB_FIND_ALLIANCE_BY_PRESTIGE, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CELEB_FIND_PLAYER_BY_STAR, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CELEB_RANK_COMPLETE_TIP_RESPONSE, onFbNotice);
            winTitle = new WinTitle();
            winTitle.title = "Hall of Fame";
            winTitle.addEventListener("onClose", onClose);
            this.addChild(winTitle);
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get curSelectRankIndex():int
        {
            return (this._776676342curSelectRankIndex);
        }

        public function ___PrestigeRank_Button29_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(11);
        }

        public function set curSelectRankIndex(_arg_1:int):void
        {
            var _local_2:Object = this._776676342curSelectRankIndex;
            if (_local_2 !== _arg_1)
            {
                this._776676342curSelectRankIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curSelectRankIndex", _local_2, _arg_1));
            };
        }

        public function ___PrestigeRank_Button1_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function _PrestigeRank_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.curSelectRankIndex);
            }, function (_arg_1:int):void
            {
                viewstack2.selectedIndex = _arg_1;
            }, "viewstack2.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("前100个达成声望{0}的玩家", strArg);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_Label1.text = _arg_1;
            }, "_PrestigeRank_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("前100个达成爵位{0}的玩家", strArg);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_Label2.text = _arg_1;
            }, "_PrestigeRank_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("前100个达成声望{0}的联盟", strArg);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_Label3.text = _arg_1;
            }, "_PrestigeRank_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("前100个升星", strArg);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_Label4.text = _arg_1;
            }, "_PrestigeRank_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.questTypeArray);
            }, function (_arg_1:Object):void
            {
                questDg.dataProvider = _arg_1;
            }, "questDg.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_DataGridColumn1.headerText = _arg_1;
            }, "_PrestigeRank_DataGridColumn1.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curSelectRankIndex == 2) ? Lang.msg("所在联盟") : Lang.msg("君主"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_DataGridColumn2.headerText = _arg_1;
            }, "_PrestigeRank_DataGridColumn2.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("达成日期");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PrestigeRank_DataGridColumn3.headerText = _arg_1;
            }, "_PrestigeRank_DataGridColumn3.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("声望名人堂"));
            }, function (_arg_1:*):void
            {
                _PrestigeRank_Array2[0] = _arg_1;
            }, "_PrestigeRank_Array2[0]");
            result[9] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("爵位名人堂"));
            }, function (_arg_1:*):void
            {
                _PrestigeRank_Array2[1] = _arg_1;
            }, "_PrestigeRank_Array2[1]");
            result[10] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("声望名盟堂"));
            }, function (_arg_1:*):void
            {
                _PrestigeRank_Array2[2] = _arg_1;
            }, "_PrestigeRank_Array2[2]");
            result[11] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("升星名人堂"));
            }, function (_arg_1:*):void
            {
                _PrestigeRank_Array2[3] = _arg_1;
            }, "_PrestigeRank_Array2[3]");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.curSelectRankIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[13] = binding;
            return (result);
        }

        public function ___PrestigeRank_Button5_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function set viewstack2(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505329viewstack2;
            if (_local_2 !== _arg_1)
            {
                this._946505329viewstack2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack2", _local_2, _arg_1));
            };
        }

        public function ___PrestigeRank_Button9_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function _PrestigeRank_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.curSelectRankIndex;
            _local_1 = Lang.msg("前100个达成声望{0}的玩家", strArg);
            _local_1 = Lang.msg("前100个达成爵位{0}的玩家", strArg);
            _local_1 = Lang.msg("前100个达成声望{0}的联盟", strArg);
            _local_1 = Lang.msg("前100个升星", strArg);
            _local_1 = this.questTypeArray;
            _local_1 = Lang.msg("排名");
            _local_1 = ((this.curSelectRankIndex == 2) ? Lang.msg("所在联盟") : Lang.msg("君主"));
            _local_1 = Lang.msg("达成日期");
            _local_1 = Lang.msg("声望名人堂");
            _local_1 = Lang.msg("爵位名人堂");
            _local_1 = Lang.msg("声望名盟堂");
            _local_1 = Lang.msg("升星名人堂");
            _local_1 = this.curSelectRankIndex;
        }

        public function ___PrestigeRank_Button32_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(14);
        }

        public function ___PrestigeRank_Button11_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function onChangeStarRank(_arg_1:int):void
        {
            strArg = _arg_1.toString();
            ActionFactory.getInstance().getCelebRankCommands().findPlayerByStar(_arg_1);
        }

        private function onChangeRank(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    strArg = "10,000";
                    ActionFactory.getInstance().getCelebRankCommands().findPlayerByPrestige("10000");
                    curSelectRankIndex = 0;
                    return;
                case 1:
                    strArg = "Baron";
                    ActionFactory.getInstance().getCelebRankCommands().findPlayerByTitle("Baron");
                    curSelectRankIndex = 1;
                    return;
                case 2:
                    strArg = "1,000,000";
                    ActionFactory.getInstance().getCelebRankCommands().findAllianceByPrestige("1000000");
                    curSelectRankIndex = 2;
                    return;
                case 3:
                    strArg = "5";
                    ActionFactory.getInstance().getCelebRankCommands().findPlayerByStar(5);
                    curSelectRankIndex = 3;
                    return;
            };
        }

        public function ___PrestigeRank_Button19_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function _PrestigeRank_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PrestigeRank_DataGridColumn2 = _local_1;
            _local_1.width = 80;
            _local_1.itemRenderer = _PrestigeRank_ClassFactory2_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_PrestigeRank_DataGridColumn2", _PrestigeRank_DataGridColumn2);
            return (_local_1);
        }

        public function ___PrestigeRank_Button15_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button22_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button26_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(8);
        }

        private function _PrestigeRank_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PrestigeRank_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___PrestigeRank_Button2_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button6_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get strArg():String
        {
            return (this._892024219strArg);
        }

        public function onClose(_arg_1:Event):void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___PrestigeRank_Button33_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(15);
        }

        public function ___PrestigeRank_Button12_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function __questTypeTBB_itemClick(_arg_1:ItemClickEvent):void
        {
            onChangeRank(_arg_1);
        }

        public function ___PrestigeRank_Button16_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get questTypeArray():ArrayCollection
        {
            return (this._425636739questTypeArray);
        }

        private function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        private function _PrestigeRank_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PrestigeRank_DataGridColumn1 = _local_1;
            _local_1.width = 60;
            _local_1.itemRenderer = _PrestigeRank_ClassFactory1_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_PrestigeRank_DataGridColumn1", _PrestigeRank_DataGridColumn1);
            return (_local_1);
        }

        public function ___PrestigeRank_Button23_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack2():ViewStack
        {
            return (this._946505329viewstack2);
        }

        override public function initialize():void
        {
            var target:PrestigeRank;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PrestigeRank_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_PrestigeRankWatcherSetupUtil");
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

        public function ___PrestigeRank_Button27_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(9);
        }

        private function _PrestigeRank_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PrestigeRank_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___PrestigeRank_Button3_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button7_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button30_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(12);
        }

        public function onRank(_arg_1:CelebResponse):void
        {
            if (curSelectRankIndex == 2)
            {
                this.questTypeArray = _arg_1.allianceBeanArray;
            }
            else
            {
                if (curSelectRankIndex == 3)
                {
                    this.questTypeArray = _arg_1.playerBeanArray;
                }
                else
                {
                    this.questTypeArray = _arg_1.playerBeanArray;
                };
            };
        }

        public function ___PrestigeRank_Button13_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function onFbNotice(_arg_1:CelebRankCompleteTipResponse):void
        {
            if (Context.getInstance().facebookUser)
            {
                HallFbNotice.show(_arg_1.rank, _arg_1.name);
            };
        }

        public function ___PrestigeRank_BaseWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        public function set questTypeTBB(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._1341206824questTypeTBB;
            if (_local_2 !== _arg_1)
            {
                this._1341206824questTypeTBB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeTBB", _local_2, _arg_1));
            };
        }

        public function ___PrestigeRank_Button17_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        public function ___PrestigeRank_Button20_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button24_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function set strArg(_arg_1:String):void
        {
            var _local_2:Object = this._892024219strArg;
            if (_local_2 !== _arg_1)
            {
                this._892024219strArg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strArg", _local_2, _arg_1));
            };
        }

        public function ___PrestigeRank_Button28_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(10);
        }

        private function _PrestigeRank_Array2_i():Array
        {
            var _local_1:Array = [null, null, null, null];
            _PrestigeRank_Array2 = _local_1;
            BindingManager.executeBindings(this, "_PrestigeRank_Array2", _PrestigeRank_Array2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get questTypeTBB():ToggleButtonBar
        {
            return (this._1341206824questTypeTBB);
        }

        private function _PrestigeRank_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PrestigeRank_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___PrestigeRank_Button8_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button4_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        override public function refresh():void
        {
            questTypeTBB.selectedIndex = 0;
            if (strArg == "")
            {
                strArg = "10,000";
            };
            ActionFactory.getInstance().getCelebRankCommands().findPlayerByPrestige("10000");
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

        public function ___PrestigeRank_Button31_click(_arg_1:MouseEvent):void
        {
            onChangeStarRank(13);
        }

        public function ___PrestigeRank_Button10_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button14_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        public function ___PrestigeRank_Button18_click(_arg_1:MouseEvent):void
        {
            GetList(_arg_1);
        }

        private function GetList(_arg_1:Event):void
        {
            var _local_2:String = _arg_1.target.label;
            strArg = _local_2;
            _local_2 = _local_2.replace(",", "");
            _local_2 = _local_2.replace(",", "");
            _local_2 = _local_2.replace(",", "");
            if (curSelectRankIndex == 0)
            {
                ActionFactory.getInstance().getCelebRankCommands().findPlayerByPrestige(_local_2);
            }
            else
            {
                if (curSelectRankIndex == 1)
                {
                    ActionFactory.getInstance().getCelebRankCommands().findPlayerByTitle(_local_2);
                }
                else
                {
                    if (curSelectRankIndex == 2)
                    {
                        ActionFactory.getInstance().getCelebRankCommands().findAllianceByPrestige(_local_2);
                    };
                };
            };
        }

        public function ___PrestigeRank_BaseWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function destroy():void
        {
        }


    }
}//package view.module.rank

