// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.AllianceView

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.ViewStack;
    import mx.core.ClassFactory;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.controls.TabBar;
    import com.evony.common.beans.IndexAllianceInfoBean;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import mx.events.PropertyChangeEvent;
    import autoevony.gui.MainScreen;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import autoevony.scripts.CityState;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.action.ActionFactory;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.alliance.HasAllianceResponse;
    import com.evony.common.beans.AllianceAddPlayerByLeaderInfoBean;
    import autoevony.event.popUpWinShowEvent;
    import autoevony.gui.info.FormatPrestige_inlineComponent0;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.beans.RankAllianceBean;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import com.evony.common.server.events.PlayerInfoUpdate;
    import com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse;
    import com.evony.common.module.alliance.WantedAllianceResponse;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AllianceView extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1606004101allianceInfo:Canvas;
        private var _1442394109allianceInfoStack:ViewStack;
        public var _AllianceView_ClassFactory2:ClassFactory;
        public var _AllianceView_ClassFactory3:ClassFactory;
        private var _1721659690_noAllianceInfo_DataGrid:DataGrid;
        private var _1849660678_MyAlliance_Label1:Label;
        private var _183090124noAllianceCreate:Canvas;
        private var pageSize:int = 10;
        private var _792861762noAllianceInfoStack:ViewStack;
        public var _AllianceView_TextArea1:TextArea;
        public var _AllianceView_TextArea2:TextArea;
        public var _AllianceView_DataGrid2:DataGrid;
        private var _1291329255events:Events;
        private var _1324451378cancelApplicationForAllianceBtn:Button;
        private var _1467420720allianceInfoTab:TabBar;
        private var _1366077706memberLevel:int = 0;
        public var _AllianceView_Button3:Button;
        public var _AllianceView_Button4:Button;
        private var _1565453997createAlliance:Button;
        private var _509512218noAllianceInfo:Canvas;
        private var _974073845_noAllianceList:AllianceList;
        private var _289625360createAllianceRespArea:Label;
        private var _1672186937indexAllianceInfoBean:IndexAllianceInfoBean;
        private var _948881689members:AllianceMembers;
        private var _463978545noAllianceInfoTab:TabBar;
        private var rankType:int = 2;
        private var _358164531noAllianceCreateSelector:ViewStack;
        private var _1191572447selector:ViewStack;
        private var _1239866535showInAlliance:int = 0;
        private var _1223883875_AllianceInfo_ClassFactory0:ClassFactory;
        private var _20402466newAllianceName:TextInput;
        private var _1865730502allianceWanted:String = "";
        private var _497392812_allianceList:AllianceList;
        private var _1758237353allianceDiplo:Diplomacy;
        private var _1628155364warreport:WarReport;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"none",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                            this.top = "3";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"selector",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "bottom";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":TabBar,
                                                                        "id":"noAllianceInfoTab",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.tabStyleName = "REtabBarTab";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "dataProvider":"noAllianceInfoStack",
                                                                                "styleName":"REtabBar"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ViewStack,
                                                            "id":"noAllianceInfoStack",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderColor = 0x222222;
                                                                this.borderThickness = 1;
                                                                this.borderStyle = "solid";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "creationPolicy":"all",
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "id":"noAllianceInfo",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Info",
                                                                                "percentHeight":100,
                                                                                "percentWidth":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "percentHeight":100,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"height":10});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFFF;
                                                                                                    this.fontSize = 12;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"text":"  You can apply for an alliance from the alliance list, or wait for an invitation from an alliance."});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"height":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":HBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "height":30,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_MyAlliance_Label1",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.fontSize = 12;
                                                                                                                this.fontFamily = "DejaVu Sans";
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Spacer,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"width":5});
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Button,
                                                                                                            "id":"cancelApplicationForAllianceBtn",
                                                                                                            "events":{"click":"__cancelApplicationForAllianceBtn_click"},
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "label":"Cancel",
                                                                                                                    "styleName":"REwinBtn"
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"height":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFFF;
                                                                                                    this.fontSize = 12;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"text":"  Invitations from:"});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":DataGrid,
                                                                                                "id":"_noAllianceInfo_DataGrid",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.headerStyleName = "columnHeaderSyle";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REdataGrid",
                                                                                                        "allowDragSelection":false,
                                                                                                        "allowMultipleSelection":false,
                                                                                                        "doubleClickEnabled":false,
                                                                                                        "dragEnabled":false,
                                                                                                        "draggableColumns":false,
                                                                                                        "editable":false,
                                                                                                        "enabled":true,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "minHeight":50,
                                                                                                        "percentHeight":100,
                                                                                                        "percentWidth":100,
                                                                                                        "resizableColumns":true,
                                                                                                        "rowHeight":23,
                                                                                                        "selectable":false,
                                                                                                        "showHeaders":true,
                                                                                                        "sortableColumns":true,
                                                                                                        "variableRowHeight":true,
                                                                                                        "visible":true,
                                                                                                        "wordWrap":false,
                                                                                                        "columns":[_AllianceView_DataGridColumn1_c(), _AllianceView_DataGridColumn2_c(), _AllianceView_DataGridColumn3_c(), _AllianceView_DataGridColumn4_c(), _AllianceView_DataGridColumn5_c()]
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
                                                                        "id":"noAllianceCreate",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Create",
                                                                                "percentHeight":100,
                                                                                "percentWidth":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":ViewStack,
                                                                                    "id":"noAllianceCreateSelector",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.borderStyle = "none";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentHeight":100,
                                                                                            "percentWidth":100,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentHeight":100,
                                                                                                        "percentWidth":100,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Spacer,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"height":15});
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.fontSize = 12;
                                                                                                                this.fontFamily = "DejaVu Sans";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"text":"  Creating an alliance requires an Embassy level 2 or greater."});
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "percentHeight":100,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Spacer,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"height":10});
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":HBox,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.verticalAlign = "bottom";
                                                                                                                this.verticalGap = 2;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":40,
                                                                                                                    "percentWidth":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":Spacer,
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"width":5});
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":TextInput,
                                                                                                                        "id":"newAllianceName",
                                                                                                                        "stylesFactory":function ():void
                                                                                                                        {
                                                                                                                            this.fontSize = 12;
                                                                                                                            this.fontFamily = "DejaVu Sans";
                                                                                                                        },
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "width":100,
                                                                                                                                "maxChars":8
                                                                                                                            });
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Spacer,
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"width":2});
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Button,
                                                                                                                        "id":"createAlliance",
                                                                                                                        "events":{"click":"__createAlliance_click"},
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "label":"Create Alliance",
                                                                                                                                "styleName":"REwinBtn"
                                                                                                                            });
                                                                                                                        }
                                                                                                                    })]
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.fontSize = 12;
                                                                                                                this.fontFamily = "DejaVu Sans";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"text":"    Creating an Alliance costs 10,000 gold."});
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Spacer,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"height":20});
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"createAllianceRespArea",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.fontSize = 12;
                                                                                                                this.fontFamily = "DejaVu Sans";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({"text":""});
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
                                                                        "type":AllianceList,
                                                                        "id":"_noAllianceList",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Alliance List",
                                                                                "percentHeight":100,
                                                                                "percentWidth":100
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "bottom";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":TabBar,
                                                                        "id":"allianceInfoTab",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.tabStyleName = "REtabBarTab";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "dataProvider":"allianceInfoStack",
                                                                                "styleName":"REtabBar"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ViewStack,
                                                            "id":"allianceInfoStack",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderColor = 0x222222;
                                                                this.borderThickness = 1;
                                                                this.borderStyle = "solid";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "creationPolicy":"all",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "id":"allianceInfo",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Info",
                                                                                "percentHeight":100,
                                                                                "percentWidth":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.left = "3";
                                                                                        this.right = "3";
                                                                                        this.top = "3";
                                                                                        this.bottom = "3";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":DataGrid,
                                                                                                "id":"_AllianceView_DataGrid2",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.headerStyleName = "columnHeaderSyle";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REdataGrid",
                                                                                                        "allowMultipleSelection":true,
                                                                                                        "draggableColumns":false,
                                                                                                        "height":50,
                                                                                                        "resizableColumns":false,
                                                                                                        "rowHeight":23,
                                                                                                        "selectable":false,
                                                                                                        "sortableColumns":false,
                                                                                                        "variableRowHeight":true,
                                                                                                        "percentWidth":100,
                                                                                                        "columns":[_AllianceView_DataGridColumn6_c(), _AllianceView_DataGridColumn7_c(), _AllianceView_DataGridColumn8_c(), _AllianceView_DataGridColumn9_c(), _AllianceView_DataGridColumn10_c()]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.horizontalGap = 0;
                                                                                                    this.verticalGap = 0;
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "percentHeight":80,
                                                                                                        "percentWidth":100,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":HBox,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.verticalAlign = "bottom";
                                                                                                                this.verticalGap = 0;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":17,
                                                                                                                    "percentWidth":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":Label,
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "text":"     Introduction",
                                                                                                                                "styleName":"REmainFormText"
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
                                                                                                                this.verticalGap = 0;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "percentHeight":100,
                                                                                                                    "percentWidth":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":TextArea,
                                                                                                                        "id":"_AllianceView_TextArea1",
                                                                                                                        "stylesFactory":function ():void
                                                                                                                        {
                                                                                                                            this.fontFamily = "DejaVu Sans";
                                                                                                                            this.fontSize = 12;
                                                                                                                            this.paddingLeft = 7;
                                                                                                                            this.paddingTop = 4;
                                                                                                                            this.paddingRight = 7;
                                                                                                                            this.paddingBottom = 4;
                                                                                                                        },
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "percentWidth":100,
                                                                                                                                "percentHeight":100,
                                                                                                                                "styleName":"txtAreaStyle",
                                                                                                                                "editable":false
                                                                                                                            });
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Button,
                                                                                                                        "id":"_AllianceView_Button3",
                                                                                                                        "events":{"click":"___AllianceView_Button3_click"},
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "label":"Edit",
                                                                                                                                "styleName":"REwinBtn"
                                                                                                                            });
                                                                                                                        }
                                                                                                                    })]
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.horizontalGap = 0;
                                                                                                    this.verticalGap = 0;
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "percentHeight":100,
                                                                                                        "percentWidth":100,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":HBox,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.verticalAlign = "bottom";
                                                                                                                this.verticalGap = 0;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":17,
                                                                                                                    "percentWidth":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":Label,
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "text":"     Alliance Notice",
                                                                                                                                "styleName":"REmainFormText"
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
                                                                                                                this.verticalGap = 0;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "percentHeight":100,
                                                                                                                    "percentWidth":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":TextArea,
                                                                                                                        "id":"_AllianceView_TextArea2",
                                                                                                                        "stylesFactory":function ():void
                                                                                                                        {
                                                                                                                            this.fontFamily = "DejaVu Sans";
                                                                                                                            this.fontSize = 12;
                                                                                                                            this.paddingLeft = 7;
                                                                                                                            this.paddingTop = 4;
                                                                                                                            this.paddingRight = 7;
                                                                                                                            this.paddingBottom = 4;
                                                                                                                        },
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "percentWidth":100,
                                                                                                                                "percentHeight":100,
                                                                                                                                "styleName":"txtAreaStyle",
                                                                                                                                "editable":false
                                                                                                                            });
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Button,
                                                                                                                        "id":"_AllianceView_Button4",
                                                                                                                        "events":{"click":"___AllianceView_Button4_click"},
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "label":"Edit",
                                                                                                                                "styleName":"REwinBtn"
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
                                                                        "type":Diplomacy,
                                                                        "id":"allianceDiplo",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"label":"Diplomacy"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":AllianceMembers,
                                                                        "id":"members",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"label":"Members"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":WarReport,
                                                                        "id":"warreport",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"label":"War Reports"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Events,
                                                                        "id":"events",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"label":"Events"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":AllianceList,
                                                                        "id":"_allianceList",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"label":"Alliance List"});
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
        });
        private var _1047287310allianceAddPlayerByLeaderInfoBeanListArray:ArrayCollection = new ArrayCollection();
        private var _2145012720friendlyListArray:ArrayCollection = new ArrayCollection();
        private var _1900069446middleListArray:ArrayCollection = new ArrayCollection();
        private var _1429287501enemyListArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceView()
        {
            mx_internal::_document = this;
            this.creationPolicy = "none";
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___AllianceView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceView._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get allianceInfoStack():ViewStack
        {
            return (this._1442394109allianceInfoStack);
        }

        private function _AllianceView_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceView_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_AllianceView_ClassFactory2", this._AllianceView_ClassFactory2);
            return (_local_1);
        }

        public function set allianceInfo(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1606004101allianceInfo;
            if (_local_2 !== _arg_1)
            {
                this._1606004101allianceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfo", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            if (((!(MainScreen.getPlayer() == null)) && (!(MainScreen.getPlayer().playerInfo.alliance == null))))
            {
                this.showInAlliance = 1;
                this.memberLevel = MainScreen.getPlayer().playerInfo.levelId;
            };
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, this.evtPlayerInfoUpdate);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE, this.updateData);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_WANTED, this.handleAllianceWantedResp);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST, this.handleAllianceInviteOnClientBeanResp);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER, this.handleAllianceManagementResponse);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER, this.handleAgreeComeinAllianceByUserResp);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST, this.handleAgreeComeinAllianceByUserResp);
            _local_1.addEventListener(ResponseDispatcher.ALLIANCE_IS_HAS_ALLIANCE, this.onHasAlliance);
            addEventListener(FlexEvent.SHOW, this.updateData);
            addEventListener(Event.RENDER, this.onRender);
        }

        [Bindable(event="propertyChange")]
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        private function onCreateAlliance():void
        {
            var _local_2:CityState;
            if (this.newAllianceName.text == "")
            {
                return;
            };
            var _local_1:Boolean;
            for each (_local_2 in MainScreen.getCities())
            {
                if (_local_2.cityManager.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_EMBASSY, 2) > 0)
                {
                    _local_1 = true;
                    break;
                };
            };
            if (_local_1)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().createAlliance(_local_2.castle.id, this.newAllianceName.text, this.handleOnCreateAllianceResp);
            }
            else
            {
                this.createAllianceRespArea.text = "Error - You need at least one level 2 or greater embassy.";
            };
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                this.allianceAddPlayerByLeaderInfoBeanListArray.removeAll();
                this.allianceWanted = "";
                ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
            }
            else
            {
                this.indexAllianceInfoBean = new IndexAllianceInfoBean();
                this.friendlyListArray.removeAll();
                this.middleListArray.removeAll();
                this.enemyListArray.removeAll();
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceWanted();
                ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
                this.showCreateAllianceInfo();
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

        public function set allianceInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1442394109allianceInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._1442394109allianceInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfoStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get events():Events
        {
            return (this._1291329255events);
        }

        [Bindable(event="propertyChange")]
        public function get members():AllianceMembers
        {
            return (this._948881689members);
        }

        public function ___AllianceView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get newAllianceName():TextInput
        {
            return (this._20402466newAllianceName);
        }

        [Bindable(event="propertyChange")]
        public function get _noAllianceInfo_DataGrid():DataGrid
        {
            return (this._1721659690_noAllianceInfo_DataGrid);
        }

        [Bindable(event="propertyChange")]
        public function get warreport():WarReport
        {
            return (this._1628155364warreport);
        }

        [Bindable(event="propertyChange")]
        public function get cancelApplicationForAllianceBtn():Button
        {
            return (this._1324451378cancelApplicationForAllianceBtn);
        }

        public function set events(_arg_1:Events):void
        {
            var _local_2:Object = this._1291329255events;
            if (_local_2 !== _arg_1)
            {
                this._1291329255events = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "events", _local_2, _arg_1));
            };
        }

        public function set warreport(_arg_1:WarReport):void
        {
            var _local_2:Object = this._1628155364warreport;
            if (_local_2 !== _arg_1)
            {
                this._1628155364warreport = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warreport", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Founder";
            _local_1.dataField = "creatorName";
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get noAllianceCreate():Canvas
        {
            return (this._183090124noAllianceCreate);
        }

        public function set newAllianceName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._20402466newAllianceName;
            if (_local_2 !== _arg_1)
            {
                this._20402466newAllianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newAllianceName", _local_2, _arg_1));
            };
        }

        public function ___AllianceView_Button3_click(_arg_1:MouseEvent):void
        {
            this.showEditIntroWin();
        }

        private function handleOnCreateAllianceResp(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.createAllianceRespArea.text = ("Error - " + _arg_1.errorMsg);
            };
        }

        private function _AllianceView_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceInfo_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_AllianceInfo_ClassFactory0", this._AllianceInfo_ClassFactory0);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get middleListArray():ArrayCollection
        {
            return (this._1900069446middleListArray);
        }

        private function _AllianceView_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Members";
            _local_1.dataField = "memberCount";
            _local_1.width = 0.15;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get createAlliance():Button
        {
            return (this._1565453997createAlliance);
        }

        [Bindable(event="propertyChange")]
        public function get _allianceList():AllianceList
        {
            return (this._497392812_allianceList);
        }

        [Bindable(event="propertyChange")]
        public function get allianceDiplo():Diplomacy
        {
            return (this._1758237353allianceDiplo);
        }

        public function __cancelApplicationForAllianceBtn_click(_arg_1:MouseEvent):void
        {
            this.cancelApplyForAlliance();
        }

        public function set members(_arg_1:AllianceMembers):void
        {
            var _local_2:Object = this._948881689members;
            if (_local_2 !== _arg_1)
            {
                this._948881689members = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "members", _local_2, _arg_1));
            };
        }

        private function onRender(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            removeEventListener(Event.RENDER, this.onRender);
            this.updateData();
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_ClassFactory0():ClassFactory
        {
            return (this._1223883875_AllianceInfo_ClassFactory0);
        }

        private function cancelApplyForAlliance():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().cancelUserWantInAlliance(this.allianceWanted, this.handleAllianceWantedResp);
        }

        public function set noAllianceCreateSelector(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._358164531noAllianceCreateSelector;
            if (_local_2 !== _arg_1)
            {
                this._358164531noAllianceCreateSelector = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAllianceCreateSelector", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Alliance Name";
            _local_1.dataField = "allianceName";
            return (_local_1);
        }

        private function _AllianceView_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank";
            _local_1.width = 0.15;
            return (_local_1);
        }

        public function get allianceList():AllianceList
        {
            return ((this.showInAlliance == 0) ? this._noAllianceList : ((this.showInAlliance == 1) ? this._allianceList : null));
        }

        public function set _noAllianceInfo_DataGrid(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1721659690_noAllianceInfo_DataGrid;
            if (_local_2 !== _arg_1)
            {
                this._1721659690_noAllianceInfo_DataGrid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_noAllianceInfo_DataGrid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get noAllianceCreateSelector():ViewStack
        {
            return (this._358164531noAllianceCreateSelector);
        }

        [Bindable(event="propertyChange")]
        public function get noAllianceInfoStack():ViewStack
        {
            return (this._792861762noAllianceInfoStack);
        }

        private function showCreateAllianceInfo(_arg_1:Object=null):void
        {
            var _local_3:CityState;
            var _local_2:Boolean;
            for each (_local_3 in MainScreen.getCities())
            {
                if (_local_3.cityManager.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_EMBASSY, 2) > 0)
                {
                    _local_2 = true;
                    break;
                };
            };
            if (!_local_2)
            {
                this.noAllianceCreateSelector.selectedIndex = 0;
            }
            else
            {
                this.noAllianceCreateSelector.selectedIndex = 1;
            };
        }

        private function handleAllianceManagementResponse(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.updateData();
            };
        }

        public function set noAllianceInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._792861762noAllianceInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._792861762noAllianceInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAllianceInfoStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceInfo():Canvas
        {
            return (this._1606004101allianceInfo);
        }

        public function ___AllianceView_Button4_click(_arg_1:MouseEvent):void
        {
            this.showEditIntroWin();
        }

        public function set enemyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1429287501enemyListArray;
            if (_local_2 !== _arg_1)
            {
                this._1429287501enemyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyListArray", _local_2, _arg_1));
            };
        }

        public function set noAllianceCreate(_arg_1:Canvas):void
        {
            var _local_2:Object = this._183090124noAllianceCreate;
            if (_local_2 !== _arg_1)
            {
                this._183090124noAllianceCreate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAllianceCreate", _local_2, _arg_1));
            };
        }

        public function set allianceWanted(_arg_1:String):void
        {
            var _local_2:Object = this._1865730502allianceWanted;
            if (_local_2 !== _arg_1)
            {
                this._1865730502allianceWanted = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceWanted", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AllianceView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AllianceView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil");
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

        public function set cancelApplicationForAllianceBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1324451378cancelApplicationForAllianceBtn;
            if (_local_2 !== _arg_1)
            {
                this._1324451378cancelApplicationForAllianceBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelApplicationForAllianceBtn", _local_2, _arg_1));
            };
        }

        public function set middleListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1900069446middleListArray;
            if (_local_2 !== _arg_1)
            {
                this._1900069446middleListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleListArray", _local_2, _arg_1));
            };
        }

        public function set indexAllianceInfoBean(_arg_1:IndexAllianceInfoBean):void
        {
            var _local_2:Object = this._1672186937indexAllianceInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._1672186937indexAllianceInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "indexAllianceInfoBean", _local_2, _arg_1));
            };
        }

        public function onHasAlliance(_arg_1:HasAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.friendlyListArray = _arg_1.friendlyListArray;
                this.middleListArray = _arg_1.middleListArray;
                this.enemyListArray = _arg_1.enemyListArray;
                this.indexAllianceInfoBean = _arg_1.indexAllianceInfoBean;
            };
        }

        private function _AllianceView_DataGridColumn10_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige";
            _local_1.itemRenderer = this._AllianceView_ClassFactory3_i();
            return (_local_1);
        }

        public function acceptInvitationForAlliance(_arg_1:Object):void
        {
            var _local_3:CityState;
            var _local_2:Boolean;
            for each (_local_3 in MainScreen.getCities())
            {
                if (_local_3.cityManager.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_EMBASSY, 1) > 0)
                {
                    _local_2 = true;
                    break;
                };
            };
            if (_local_2)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByUser(_local_3.castle.id, (_arg_1 as AllianceAddPlayerByLeaderInfoBean).allianceName);
            };
        }

        public function __createAlliance_click(_arg_1:MouseEvent):void
        {
            this.onCreateAlliance();
        }

        private function _AllianceView_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Alliance";
            _local_1.dataField = "allianceName";
            _local_1.width = 0.25;
            return (_local_1);
        }

        public function set createAlliance(_arg_1:Button):void
        {
            var _local_2:Object = this._1565453997createAlliance;
            if (_local_2 !== _arg_1)
            {
                this._1565453997createAlliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createAlliance", _local_2, _arg_1));
            };
        }

        private function showEditIntroWin():void
        {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_EDIT_INTRO));
        }

        private function set showInAlliance(_arg_1:int):void
        {
            var _local_2:Object = this._1239866535showInAlliance;
            if (_local_2 !== _arg_1)
            {
                this._1239866535showInAlliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showInAlliance", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn9_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank";
            _local_1.width = 80;
            return (_local_1);
        }

        public function set allianceDiplo(_arg_1:Diplomacy):void
        {
            var _local_2:Object = this._1758237353allianceDiplo;
            if (_local_2 !== _arg_1)
            {
                this._1758237353allianceDiplo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceDiplo", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Action";
            _local_1.dataField = "allianceName";
            _local_1.width = 0.25;
            _local_1.itemRenderer = this._AllianceView_ClassFactory1_i();
            return (_local_1);
        }

        public function set _allianceList(_arg_1:AllianceList):void
        {
            var _local_2:Object = this._497392812_allianceList;
            if (_local_2 !== _arg_1)
            {
                this._497392812_allianceList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_allianceList", _local_2, _arg_1));
            };
        }

        public function set selector(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1191572447selector;
            if (_local_2 !== _arg_1)
            {
                this._1191572447selector = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selector", _local_2, _arg_1));
            };
        }

        public function set noAllianceInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._463978545noAllianceInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._463978545noAllianceInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAllianceInfoTab", _local_2, _arg_1));
            };
        }

        public function set allianceInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1467420720allianceInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._1467420720allianceInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfoTab", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._1223883875_AllianceInfo_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._1223883875_AllianceInfo_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_ClassFactory0", _local_2, _arg_1));
            };
        }

        private function _AllianceView_ClassFactory3_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceView_ClassFactory3 = _local_1;
            BindingManager.executeBindings(this, "_AllianceView_ClassFactory3", this._AllianceView_ClassFactory3);
            return (_local_1);
        }

        public function toDebugString():String
        {
            return ("fields: myAlliance members events warreport");
        }

        private function _AllianceView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.showInAlliance);
            }, function (_arg_1:int):void
            {
                selector.selectedIndex = _arg_1;
            }, "selector.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("  Application for:  " + this.allianceWanted);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyAlliance_Label1.text = _arg_1;
            }, "_MyAlliance_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.allianceWanted.length > 0);
            }, function (_arg_1:Boolean):void
            {
                cancelApplicationForAllianceBtn.visible = _arg_1;
            }, "cancelApplicationForAllianceBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.allianceAddPlayerByLeaderInfoBeanListArray);
            }, function (_arg_1:Object):void
            {
                _noAllianceInfo_DataGrid.dataProvider = _arg_1;
            }, "_noAllianceInfo_DataGrid.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():Class
            {
                return (JoinButton_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceInfo_ClassFactory0.generator = _arg_1;
            }, "_AllianceInfo_ClassFactory0.generator");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.indexAllianceInfoBean);
            }, function (_arg_1:Object):void
            {
                _AllianceView_DataGrid2.dataProvider = _arg_1;
            }, "_AllianceView_DataGrid2.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():Class
            {
                return (Info_inlineComponent1);
            }, function (_arg_1:Class):void
            {
                _AllianceView_ClassFactory2.generator = _arg_1;
            }, "_AllianceView_ClassFactory2.generator");
            result[6] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPrestige_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceView_ClassFactory3.generator = _arg_1;
            }, "_AllianceView_ClassFactory3.generator");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.indexAllianceInfoBean.allianceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceView_TextArea1.text = _arg_1;
            }, "_AllianceView_TextArea1.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceView_Button3.visible = _arg_1;
            }, "_AllianceView_Button3.visible");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.indexAllianceInfoBean.allianceNote;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceView_TextArea2.text = _arg_1;
            }, "_AllianceView_TextArea2.text");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                _AllianceView_Button4.visible = _arg_1;
            }, "_AllianceView_Button4.visible");
            result[11] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get allianceWanted():String
        {
            return (this._1865730502allianceWanted);
        }

        [Bindable(event="propertyChange")]
        public function get indexAllianceInfoBean():IndexAllianceInfoBean
        {
            return (this._1672186937indexAllianceInfoBean);
        }

        [Bindable(event="propertyChange")]
        public function get noAllianceInfoTab():TabBar
        {
            return (this._463978545noAllianceInfoTab);
        }

        public function applyForAlliance(_arg_1:Object):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance((_arg_1 as RankAllianceBean).name);
        }

        public function set noAllianceInfo(_arg_1:Canvas):void
        {
            var _local_2:Object = this._509512218noAllianceInfo;
            if (_local_2 !== _arg_1)
            {
                this._509512218noAllianceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAllianceInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get enemyListArray():ArrayCollection
        {
            return (this._1429287501enemyListArray);
        }

        private function handleAgreeComeinAllianceByUserResp(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.updateData();
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceInfoTab():TabBar
        {
            return (this._1467420720allianceInfoTab);
        }

        private function evtPlayerInfoUpdate(_arg_1:PlayerInfoUpdate):void
        {
            if (_arg_1.playerInfo.alliance != null)
            {
                if (this.showInAlliance != 1)
                {
                    this.showInAlliance = 1;
                };
                if (this.memberLevel != _arg_1.playerInfo.levelId)
                {
                    this.memberLevel = _arg_1.playerInfo.levelId;
                };
            }
            else
            {
                if (this.showInAlliance != 0)
                {
                    this.showInAlliance = 0;
                };
                if (this.memberLevel != 0)
                {
                    this.memberLevel = 0;
                };
            };
        }

        private function _AllianceView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.showInAlliance;
            _local_1 = ("  Application for:  " + this.allianceWanted);
            _local_1 = (this.allianceWanted.length > 0);
            _local_1 = this.allianceAddPlayerByLeaderInfoBeanListArray;
            _local_1 = JoinButton_inlineComponent0;
            _local_1 = this.indexAllianceInfoBean;
            _local_1 = Info_inlineComponent1;
            _local_1 = FormatPrestige_inlineComponent0;
            _local_1 = this.indexAllianceInfoBean.allianceInfo;
            _local_1 = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            _local_1 = this.indexAllianceInfoBean.allianceNote;
            _local_1 = ((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
        }

        [Bindable(event="propertyChange")]
        public function get selector():ViewStack
        {
            return (this._1191572447selector);
        }

        public function set createAllianceRespArea(_arg_1:Label):void
        {
            var _local_2:Object = this._289625360createAllianceRespArea;
            if (_local_2 !== _arg_1)
            {
                this._289625360createAllianceRespArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createAllianceRespArea", _local_2, _arg_1));
            };
        }

        private function handleAllianceInviteOnClientBeanResp(_arg_1:AllianceInviteOnClientBeanResponse):void
        {
            var _local_2:AllianceAddPlayerByLeaderInfoBean;
            if (_arg_1.ok != 1)
            {
                return;
            };
            this.allianceAddPlayerByLeaderInfoBeanListArray.removeAll();
            for each (_local_2 in _arg_1.allianceAddPlayerByLeaderInfoBeanListArray)
            {
                this.allianceAddPlayerByLeaderInfoBeanListArray.addItem(_local_2);
            };
        }

        public function set allianceAddPlayerByLeaderInfoBeanListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1047287310allianceAddPlayerByLeaderInfoBeanListArray;
            if (_local_2 !== _arg_1)
            {
                this._1047287310allianceAddPlayerByLeaderInfoBeanListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceAddPlayerByLeaderInfoBeanListArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get noAllianceInfo():Canvas
        {
            return (this._509512218noAllianceInfo);
        }

        public function set friendlyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2145012720friendlyListArray;
            if (_local_2 !== _arg_1)
            {
                this._2145012720friendlyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendlyListArray", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige";
            _local_1.width = 0.35;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get showInAlliance():int
        {
            return (this._1239866535showInAlliance);
        }

        public function set _noAllianceList(_arg_1:AllianceList):void
        {
            var _local_2:Object = this._974073845_noAllianceList;
            if (_local_2 !== _arg_1)
            {
                this._974073845_noAllianceList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_noAllianceList", _local_2, _arg_1));
            };
        }

        private function _AllianceView_DataGridColumn8_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Members";
            _local_1.dataField = "memberCount";
            _local_1.width = 80;
            _local_1.itemRenderer = this._AllianceView_ClassFactory2_i();
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _noAllianceList():AllianceList
        {
            return (this._974073845_noAllianceList);
        }

        [Bindable(event="propertyChange")]
        public function get createAllianceRespArea():Label
        {
            return (this._289625360createAllianceRespArea);
        }

        [Bindable(event="propertyChange")]
        public function get allianceAddPlayerByLeaderInfoBeanListArray():ArrayCollection
        {
            return (this._1047287310allianceAddPlayerByLeaderInfoBeanListArray);
        }

        [Bindable(event="propertyChange")]
        public function get _MyAlliance_Label1():Label
        {
            return (this._1849660678_MyAlliance_Label1);
        }

        public function set _MyAlliance_Label1(_arg_1:Label):void
        {
            var _local_2:Object = this._1849660678_MyAlliance_Label1;
            if (_local_2 !== _arg_1)
            {
                this._1849660678_MyAlliance_Label1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_MyAlliance_Label1", _local_2, _arg_1));
            };
        }

        private function handleAllianceWantedResp(_arg_1:Object):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                return;
            };
            if ((_arg_1 is WantedAllianceResponse))
            {
                if (_arg_1.allianceName == null)
                {
                    this.allianceWanted = "";
                }
                else
                {
                    this.allianceWanted = _arg_1.allianceName;
                };
            }
            else
            {
                if ((_arg_1 is AllianceManagementResponse))
                {
                    if (_arg_1.waitIntoAllianceName == null)
                    {
                        this.allianceWanted = "";
                    }
                    else
                    {
                        this.allianceWanted = _arg_1.waitIntoAllianceName;
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get friendlyListArray():ArrayCollection
        {
            return (this._2145012720friendlyListArray);
        }


    }
}//package autoevony.gui.info.Alliance

