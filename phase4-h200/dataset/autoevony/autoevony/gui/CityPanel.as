// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.core.ClassFactory;
    import mx.controls.CheckBox;
    import mx.controls.Button;
    import mx.controls.Text;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import com.evony.common.beans.CastleBean;
    import flash.utils.Timer;
    import mx.containers.ViewStack;
    import mx.controls.TabBar;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HDividedBox;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Image;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import autoevony.scripts.CityState;
    import autoevony.management.CityManager;
    import flash.events.Event;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.binding.BindingManager;
    import autoevony.scripts.Script;
    import mx.controls.tabBarClasses.Tab;
    import mx.events.PropertyChangeEvent;
    import autoevony.event.popUpWinShowEvent;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import autoevony.gui.controls.popup.PopUpWinManager;
    import flash.events.TimerEvent;
    import autoevony.common.Utils;
    import com.as3xls.xls.ExcelFile;
    import com.as3xls.xls.Sheet;
    import autoevony.gui.newarmy.NewArmyWin;
    import flash.net.SharedObject;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import com.evony.client.action.ActionFactory;
    import flash.net.FileReference;
    import flash.events.IOErrorEvent;
    import autoevony.player.Map;
    import mx.core.UITextField;
    import autoevony.common.CityStateCommands;
    import com.evony.common.beans.ColonyBean;
    import mx.binding.Binding;
    import flash.net.FileFilter;
    import autoevony.gui.controls.themes.ThemeManager;
    import com.evony.common.module.CommandResponse;
    import autoevony.common.GearType;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.beans.HeroBean;
    import flash.utils.getDefinitionByName;
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

    public class CityPanel extends Canvas implements IBindingClient 
    {

        internal static const SAVEALLEVENT:String = "SaveAll";
        internal static const SETALLGOALS:String = "SetAllGoals";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CityPanel_ClassFactory1:ClassFactory;
        public var _CityPanel_ClassFactory2:ClassFactory;
        public var _CityPanel_ClassFactory3:ClassFactory;
        public var _CityPanel_ClassFactory4:ClassFactory;
        public var _CityPanel_ClassFactory5:ClassFactory;
        public var _CityPanel_ClassFactory6:ClassFactory;
        public var _CityPanel_ClassFactory7:ClassFactory;
        public var _CityPanel_ClassFactory8:ClassFactory;
        public var _CityPanel_ClassFactory9:ClassFactory;
        private var _1405697728_buildings:Canvas;
        private var _1188674855_showEnemiesC:CheckBox;
        private var _1299164186_armies:Canvas;
        private var _1487717191_heroes:Canvas;
        private var _260377862_research:Canvas;
        public var _CityPanel_RowColorDataGrid1:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid2:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid3:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid4:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid5:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid6:RowColorDataGrid;
        public var _CityPanel_RowColorDataGrid7:RowColorDataGrid;
        private var _1476969531_gears:Canvas;
        private var _1188674836_showEnemiesV:CheckBox;
        private var _1839459670_showEnemies:CheckBox;
        public var _CityPanel_Button1:Button;
        public var _CityPanel_Button2:Button;
        public var _CityPanel_Button3:Button;
        public var _CityPanel_Button4:Button;
        public var _CityPanel_Button5:Button;
        public var _CityPanel_Button6:Button;
        public var _CityPanel_Button7:Button;
        private var _250546835_resource:Canvas;
        public var _CityPanel_Text1:Text;
        public var _CityPanel_Text2:Text;
        private var _1820295151_goalsTxt:TextArea;
        public var _CityPanel_Label1:Label;
        public var _CityPanel_Label3:Label;
        public var _CityPanel_Label4:Label;
        public var _CityPanel_Label5:Label;
        public var _CityPanel_Label7:Label;
        private var _1647526287_cityInfoProd:Label;
        private var _1884649598_valley:Canvas;
        private var _496434264_inputNewCastleName:TextInput;
        private var _1202148967_castleBean:CastleBean = null;
        private var _1127919786_cityPanelBean:CityPanelBean;
        private var _1353628185_colony:Canvas;
        private var _746461325_stopButton:Button;
        private var _1464576923_trade:Canvas;
        private var _1238975450_scriptTxt:TextArea;
        private var _752649447_enemies:Canvas;
        private var _1507357726_runButton:Button;
        private var _623064501_troopQueues:Canvas;
        private var timer:Timer = null;
        internal var isInitialized:Boolean = false;
        public var _CityPanel_ClassFactory10:ClassFactory;
        public var _CityPanel_ClassFactory11:ClassFactory;
        private var _1446694032_allinfo:ViewStack;
        private var _248346296_showSelf:CheckBox;
        private var _1942092334_innheroes:Canvas;
        private var _1742425533_goalTab:TabBar;
        private var _8659656_infoTab:TabBar;
        private var _271816895_renameBtn:Button;
        private var _749805761_clearTextBtn:Button;
        public var _CityPanel_DataGrid1:DataGrid;
        public var _CityPanel_DataGrid2:DataGrid;
        public var _CityPanel_DataGrid3:DataGrid;
        public var _CityPanel_DataGrid4:DataGrid;
        public var _CityPanel_DataGrid5:DataGrid;
        public var _CityPanel_DataGrid6:DataGrid;
        public var _CityPanel_DataGrid7:DataGrid;
        private var _1907625964_alltasks:ViewStack;
        private var _1321633669_showFriendlies:CheckBox;
        private var _1472639233_fortifications:Canvas;
        private var _1843183744_troops:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":1200,
                    "height":300,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HDividedBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
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
                                        this.paddingLeft = 0;
                                        this.paddingRight = 0;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "bottom";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":22,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TabBar,
                                                            "id":"_goalTab",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.tabStyleName = "REtabBarTab";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "dataProvider":"_alltasks",
                                                                    "styleName":"REtabBar"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"_alltasks",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "none";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "creationPolicy":"all",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Goals",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 0;
                                                                            this.paddingLeft = 0;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentHeight":100,
                                                                                "percentWidth":100,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":TextArea,
                                                                                    "id":"_goalsTxt",
                                                                                    "events":{"change":"___goalsTxt_change"},
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "percentHeight":100,
                                                                                            "styleName":"txtAreaStyle"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 0;
                                                                                        this.verticalAlign = "middle";
                                                                                        this.paddingLeft = 5;
                                                                                        this.paddingRight = 5;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "height":28,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button1",
                                                                                                "events":{"click":"___CityPanel_Button1_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "label":"March",
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "toolTip":"Open a New Army window to manually customize and dispatch troops"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"percentWidth":100});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":50});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button2",
                                                                                                "events":{"click":"___CityPanel_Button2_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Save File",
                                                                                                        "toolTip":"Save this town's currently entered goals to a text file"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button3",
                                                                                                "events":{"click":"___CityPanel_Button3_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Load File",
                                                                                                        "toolTip":"Load goals from a text file into this town's goals window"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":60});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button4",
                                                                                                "events":{"click":"___CityPanel_Button4_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Set Goals",
                                                                                                        "toolTip":"Set this town's currently entered goals"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":15});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button5",
                                                                                                "events":{"click":"___CityPanel_Button5_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Save",
                                                                                                        "toolTip":"Save this town's currently entered goals"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button6",
                                                                                                "events":{"click":"___CityPanel_Button6_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Load",
                                                                                                        "toolTip":"Load last saved goals for this town"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":15});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_CityPanel_Button7",
                                                                                                "events":{"click":"___CityPanel_Button7_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Save All",
                                                                                                        "toolTip":"Save all goals and scripts for all towns"
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
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Script",
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 0;
                                                                            this.paddingLeft = 0;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":TextArea,
                                                                                    "id":"_scriptTxt",
                                                                                    "events":{"change":"___scriptTxt_change"},
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "percentHeight":100,
                                                                                            "styleName":"txtAreaStyle"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 0;
                                                                                        this.verticalAlign = "middle";
                                                                                        this.paddingLeft = 5;
                                                                                        this.paddingRight = 5;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "height":28,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button8_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "label":"March",
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "toolTip":"Open a New Army window to manually customize and dispatch troops"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"percentWidth":100});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":50});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button9_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Save File",
                                                                                                        "toolTip":"Save this town's currently entered script to a text file"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button10_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Load File",
                                                                                                        "toolTip":"Load a script from a text file into this town's script window"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":60});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_runButton",
                                                                                                "events":{"click":"___runButton_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "label":"Run",
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "toolTip":"Run currently entered script for this town"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "id":"_stopButton",
                                                                                                "events":{"click":"___stopButton_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "label":"Stop",
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "toolTip":"Stop currently running script for this town"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":HBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":15});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button13_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Save",
                                                                                                        "toolTip":"Save currently entered script for this town"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":5});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button14_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "label":"Load",
                                                                                                        "toolTip":"Load last saved script for this town"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":HBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":15});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Button,
                                                                                                "events":{"click":"___CityPanel_Button15_click"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "label":"Save All",
                                                                                                        "styleName":"REwinBtn",
                                                                                                        "toolTip":"Save all goals and scripts for all towns"
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
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 0;
                                        this.paddingLeft = 0;
                                        this.paddingRight = 0;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "width":603,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.verticalGap = 0;
                                                    this.borderColor = 0x222222;
                                                    this.borderStyle = "solid";
                                                    this.borderThickness = 1;
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":47,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 1;
                                                                this.paddingBottom = 2;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":45,
                                                                    "styleName":"cityTopInfoDarkFadedBackground",
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                            this.paddingLeft = 10;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "height":20,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "left";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":220,
                                                                                            "height":20,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Canvas,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":220,
                                                                                                        "height":20,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":HBox,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.left = "0";
                                                                                                                this.horizontalAlign = "left";
                                                                                                                this.paddingLeft = 0;
                                                                                                                this.paddingRight = 0;
                                                                                                                this.paddingTop = 0;
                                                                                                                this.paddingBottom = 0;
                                                                                                                this.horizontalGap = 20;
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "width":220,
                                                                                                                    "height":20,
                                                                                                                    "horizontalScrollPolicy":"off",
                                                                                                                    "verticalScrollPolicy":"off",
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":Text,
                                                                                                                        "id":"_CityPanel_Text1",
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "styleName":"cityTopInfoText",
                                                                                                                                "toolTip":"City Name"
                                                                                                                            });
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Button,
                                                                                                                        "id":"_renameBtn",
                                                                                                                        "events":{"click":"___renameBtn_click"},
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "width":16,
                                                                                                                                "height":16,
                                                                                                                                "toolTip":"Change castle name",
                                                                                                                                "styleName":"editBtn"
                                                                                                                            });
                                                                                                                        }
                                                                                                                    })]
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":TextInput,
                                                                                                            "id":"_inputNewCastleName",
                                                                                                            "events":{
                                                                                                                "enter":"___inputNewCastleName_enter",
                                                                                                                "keyDown":"___inputNewCastleName_keyDown"
                                                                                                            },
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.left = "0";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "width":170,
                                                                                                                    "height":20,
                                                                                                                    "text":"",
                                                                                                                    "maxChars":10,
                                                                                                                    "restrict":" A-Za-z0-9",
                                                                                                                    "visible":false,
                                                                                                                    "styleName":"textInput"
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Button,
                                                                                                            "id":"_clearTextBtn",
                                                                                                            "events":{"click":"___clearTextBtn_click"},
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.left = "149";
                                                                                                                this.top = "2";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "width":16,
                                                                                                                    "height":16,
                                                                                                                    "toolTip":"Clear text",
                                                                                                                    "styleName":"clearTextBtn"
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
                                                                                        this.horizontalAlign = "center";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":30,
                                                                                            "height":17,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Image,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"source":_embed_mxml_autoevony_gui_images_loyGrieve_png_471597483});
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_CityPanel_Label1",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":43,
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Loyalty"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                        this.fontSize = 12;
                                                                                        this.color = 0xFFFFFF;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":16,
                                                                                            "text":"/"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_CityPanel_Label3",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":105,
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Public Grievance"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":30,
                                                                                            "height":17,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Image,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"source":_embed_mxml_autoevony_gui_images_taxes_png_499416011});
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_CityPanel_Label4",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":50,
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Tax Rate"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "height":2,
                                                                                "styleName":"horizontalSeparator2pxLine"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                            this.paddingLeft = 10;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 1;
                                                                            this.paddingBottom = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "height":20,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_CityPanel_Text2",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.color = 0xFFFFFF;
                                                                                        this.fontFamily = "DejaVu Sans";
                                                                                        this.fontThickness = 20;
                                                                                        this.fontSize = 13;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":220,
                                                                                            "toolTip":"Location"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":30,
                                                                                            "height":17,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Image,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"source":_embed_mxml_autoevony_gui_images_pop_png_1631794581});
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_CityPanel_Label5",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":63,
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Current Population"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                        this.fontSize = 12;
                                                                                        this.color = 0xFFFFFF;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":16,
                                                                                            "text":"/"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_CityPanel_Label7",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":85,
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Idle Population"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":VBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":30,
                                                                                            "height":17,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Image,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"source":_embed_mxml_autoevony_gui_images_prod_png_99042219});
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_cityInfoProd",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":50,
                                                                                            "text":"",
                                                                                            "styleName":"cityTopInfoText",
                                                                                            "toolTip":"Production Rate"
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
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":2,
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "bottom";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":22,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TabBar,
                                                            "id":"_infoTab",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.tabStyleName = "REtabBarTab";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "dataProvider":"_allinfo",
                                                                    "percentWidth":100,
                                                                    "styleName":"REtabBar"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"_allinfo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_resource",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"R",
                                                                    "toolTip":"Resources Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid1",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn1_c(), _CityPanel_DataGridColumn2_c(), _CityPanel_DataGridColumn3_c(), _CityPanel_DataGridColumn4_c(), _CityPanel_DataGridColumn5_c(), _CityPanel_DataGridColumn6_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_valley",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"V",
                                                                    "toolTip":"Valleys Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid1",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn7_c(), _CityPanel_DataGridColumn8_c(), _CityPanel_DataGridColumn9_c(), _CityPanel_DataGridColumn10_c(), _CityPanel_DataGridColumn11_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_colony",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"C",
                                                                    "toolTip":"Colonies and Suzerain Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid2",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn12_c(), _CityPanel_DataGridColumn13_c(), _CityPanel_DataGridColumn14_c(), _CityPanel_DataGridColumn15_c(), _CityPanel_DataGridColumn16_c(), _CityPanel_DataGridColumn17_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_innheroes",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"I",
                                                                    "toolTip":"Inn Heroes Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid2",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn18_c(), _CityPanel_DataGridColumn19_c(), _CityPanel_DataGridColumn20_c(), _CityPanel_DataGridColumn21_c(), _CityPanel_DataGridColumn22_c(), _CityPanel_DataGridColumn23_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_heroes",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"H",
                                                                    "toolTip":"Heroes Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid3",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn24_c(), _CityPanel_DataGridColumn25_c(), _CityPanel_DataGridColumn26_c(), _CityPanel_DataGridColumn27_c(), _CityPanel_DataGridColumn28_c(), _CityPanel_DataGridColumn29_c(), _CityPanel_DataGridColumn30_c(), _CityPanel_DataGridColumn31_c(), _CityPanel_DataGridColumn32_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_buildings",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"B",
                                                                    "toolTip":"Buildings Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid3",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn33_c(), _CityPanel_DataGridColumn34_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_research",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"S",
                                                                    "toolTip":"Tech Research Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid4",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn35_c(), _CityPanel_DataGridColumn36_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_gears",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"G",
                                                                    "toolTip":"Gear Research and Star Level Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid5",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn37_c(), _CityPanel_DataGridColumn38_c(), _CityPanel_DataGridColumn39_c(), _CityPanel_DataGridColumn40_c(), _CityPanel_DataGridColumn41_c(), _CityPanel_DataGridColumn42_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_armies",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"A",
                                                                    "toolTip":"Armies Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid4",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn43_c(), _CityPanel_DataGridColumn44_c(), _CityPanel_DataGridColumn45_c(), _CityPanel_DataGridColumn46_c(), _CityPanel_DataGridColumn47_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_troops",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"T",
                                                                    "toolTip":"Troops Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid5",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn48_c(), _CityPanel_DataGridColumn49_c(), _CityPanel_DataGridColumn50_c(), _CityPanel_DataGridColumn51_c(), _CityPanel_DataGridColumn52_c(), _CityPanel_DataGridColumn53_c(), _CityPanel_DataGridColumn54_c(), _CityPanel_DataGridColumn55_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_troopQueues",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Q",
                                                                    "toolTip":"Troops Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":RowColorDataGrid,
                                                                        "id":"_CityPanel_RowColorDataGrid6",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn56_c(), _CityPanel_DataGridColumn57_c(), _CityPanel_DataGridColumn58_c(), _CityPanel_DataGridColumn59_c(), _CityPanel_DataGridColumn60_c(), _CityPanel_DataGridColumn61_c(), _CityPanel_DataGridColumn62_c(), _CityPanel_DataGridColumn63_c(), _CityPanel_DataGridColumn64_c(), _CityPanel_DataGridColumn65_c(), _CityPanel_DataGridColumn66_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_fortifications",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"F",
                                                                    "toolTip":"Wall Fortifications Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid6",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn67_c(), _CityPanel_DataGridColumn68_c(), _CityPanel_DataGridColumn69_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_trade",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"X",
                                                                    "toolTip":"Market Transactions Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DataGrid,
                                                                        "id":"_CityPanel_DataGrid7",
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
                                                                                "variableRowHeight":true,
                                                                                "selectable":false,
                                                                                "showHeaders":true,
                                                                                "sortableColumns":false,
                                                                                "visible":true,
                                                                                "wordWrap":false,
                                                                                "columns":[_CityPanel_DataGridColumn70_c(), _CityPanel_DataGridColumn71_c(), _CityPanel_DataGridColumn72_c(), _CityPanel_DataGridColumn73_c()]
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_enemies",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"E",
                                                                    "toolTip":"External Incoming Armies Info",
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":RowColorDataGrid,
                                                                                    "id":"_CityPanel_RowColorDataGrid7",
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
                                                                                            "variableRowHeight":true,
                                                                                            "selectable":false,
                                                                                            "showHeaders":true,
                                                                                            "sortableColumns":false,
                                                                                            "visible":true,
                                                                                            "wordWrap":false,
                                                                                            "columns":[_CityPanel_DataGridColumn74_c(), _CityPanel_DataGridColumn75_c(), _CityPanel_DataGridColumn76_c(), _CityPanel_DataGridColumn77_c(), _CityPanel_DataGridColumn78_c()]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                        this.verticalAlign = "middle";
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.borderColor = 592137;
                                                                                        this.borderStyle = "solid";
                                                                                        this.borderThickness = 1;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "height":27,
                                                                                            "styleName":"cityTopInfoDarkFadedBackground",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFF;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                    this.fontSize = 12;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "text":"Self:",
                                                                                                        "toolTip":"Mark to show incoming own armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":1,
                                                                                                        "toolTip":"Mark to show incoming own armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"_showSelf",
                                                                                                "events":{"change":"___showSelf_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "selected":true,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Mark to show incoming own armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":20});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFF;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                    this.fontSize = 12;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "text":"Ally:",
                                                                                                        "toolTip":"Mark to show incoming friendly armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":1,
                                                                                                        "toolTip":"Mark to show incoming friendly armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"_showFriendlies",
                                                                                                "events":{"change":"___showFriendlies_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "selected":true,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Mark to show incoming friendly armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":50});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFF;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                    this.fontSize = 12;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "text":"Enemy:",
                                                                                                        "toolTip":"Mark to show incoming enemy armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":1,
                                                                                                        "toolTip":"Mark to show incoming enemy armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"_showEnemies",
                                                                                                "events":{"change":"___showEnemies_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "selected":true,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Mark to show incoming enemy armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":20});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFF;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                    this.fontSize = 12;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "text":"Valley:",
                                                                                                        "toolTip":"Mark to show incoming enemy valley armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":1,
                                                                                                        "toolTip":"Mark to show incoming enemy valley armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"_showEnemiesV",
                                                                                                "events":{"change":"___showEnemiesV_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "selected":true,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Mark to show incoming enemy valley armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({"width":20});
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.color = 0xFFFFF;
                                                                                                    this.fontFamily = "DejaVu Sans";
                                                                                                    this.fontSize = 12;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "text":"Colony:",
                                                                                                        "toolTip":"Mark to show incoming enemy colony armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Spacer,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":1,
                                                                                                        "toolTip":"Mark to show incoming enemy colony armies"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"_showEnemiesC",
                                                                                                "events":{"change":"___showEnemiesC_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "selected":true,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Mark to show incoming enemy colony armies"
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
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var _384864040resourceData:ArrayCollection = new ArrayCollection();
        private var _1626662999valleyData:ArrayCollection = new ArrayCollection();
        private var _1197740996colonyData:ArrayCollection = new ArrayCollection();
        private var _1649235507innHeroData:ArrayCollection = new ArrayCollection();
        private var _619403580heroData:ArrayCollection = new ArrayCollection();
        private var _982909826buildingData:ArrayCollection = new ArrayCollection();
        private var _16113637researchData:ArrayCollection = new ArrayCollection();
        private var _2006530702gearsData:ArrayCollection = new ArrayCollection();
        private var _1415438617armyData:ArrayCollection = new ArrayCollection();
        private var _2009763499troopsData:ArrayCollection = new ArrayCollection();
        private var _1676058921troopQueueData:ArrayCollection = new ArrayCollection();
        private var _355347286fortificationsData:ArrayCollection = new ArrayCollection();
        private var _1892696025tradesData:ArrayCollection = new ArrayCollection();
        private var _35298671externalTroopData:ArrayCollection = new ArrayCollection();
        private var _embed_mxml_autoevony_gui_images_loyGrieve_png_471597483:Class = CityPanel__embed_mxml_autoevony_gui_images_loyGrieve_png_471597483;
        private var _embed_mxml_autoevony_gui_images_pop_png_1631794581:Class = CityPanel__embed_mxml_autoevony_gui_images_pop_png_1631794581;
        private var _embed_mxml_autoevony_gui_images_prod_png_99042219:Class = CityPanel__embed_mxml_autoevony_gui_images_prod_png_99042219;
        private var _embed_mxml_autoevony_gui_images_taxes_png_499416011:Class = CityPanel__embed_mxml_autoevony_gui_images_taxes_png_499416011;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CityPanel()
        {
            mx_internal::_document = this;
            this.width = 1200;
            this.height = 300;
            this.addEventListener("creationComplete", this.___CityPanel_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CityPanel._watcherSetupUtil = _arg_1;
        }


        internal function onSaveAll(_arg_1:Object=null):void
        {
            var _local_2:CityState;
            if (_arg_1 == null)
            {
                this.queueJobs.logMsg("Save all goals and scripts and various internal data");
                CityManager.cleanUpAndFlushAllTimingLists();
                this.queueJobs.dispatchEvent(new Event(SAVEALLEVENT));
            }
            else
            {
                for each (_local_2 in MainScreen.getCities())
                {
                    this.onSaveGoals(_local_2.castleId, true);
                    this.onSaveScript(_local_2.castleId, true);
                };
            };
        }

        private function _CityPanel_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Incoming";
            _local_1.dataField = "col5";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn31_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Recall";
            _local_1.width = 60;
            _local_1.itemRenderer = this._CityPanel_ClassFactory5_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn54_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Remain";
            _local_1.dataField = "col6";
            _local_1.width = 0.12;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn77_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Remain time";
            _local_1.dataField = "col3";
            _local_1.width = 95;
            return (_local_1);
        }

        private function _CityPanel_ClassFactory7_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory7 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory7", this._CityPanel_ClassFactory7);
            return (_local_1);
        }

        internal function onRunScript(_arg_1:int):void
        {
            var _local_2:CityPanelBean = this.queueJobs.getCityPanelBean(_arg_1);
            var _local_3:Script = MainScreen.getCityFromCastleId(_arg_1)._getScript();
            _local_2.scriptIsRunning = true;
            _local_3.set_m_script(_local_2.scriptTxt);
        }

        [Bindable(event="propertyChange")]
        public function get _runButton():Button
        {
            return (this._1507357726_runButton);
        }

        public function setSelectedInfoTab(_arg_1:String):void
        {
            var _local_3:Tab;
            var _local_2:int;
            for each (_local_3 in this._infoTab.getChildren())
            {
                if (_local_3.label == _arg_1)
                {
                    if (this._infoTab.selectedIndex != _local_2)
                    {
                        this._infoTab.selectedIndex = _local_2;
                    };
                    break;
                };
                _local_2++;
            };
        }

        private function _CityPanel_DataGridColumn42_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Upgrade";
            _local_1.width = 75;
            _local_1.itemRenderer = this._CityPanel_ClassFactory7_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Days left";
            _local_1.dataField = "col4";
            _local_1.width = 0.3;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        public function set _colony(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1353628185_colony;
            if (_local_2 !== _arg_1)
            {
                this._1353628185_colony = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_colony", _local_2, _arg_1));
            };
        }

        public function set _armies(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1299164186_armies;
            if (_local_2 !== _arg_1)
            {
                this._1299164186_armies = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_armies", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn65_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q9";
            _local_1.dataField = "col9";
            _local_1.width = 0.1;
            return (_local_1);
        }

        public function _onViewHeroBtn(_arg_1:Object):void
        {
            var _local_2:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.HERO_MANAGEMENT_WIN);
            _local_2.args = [_arg_1];
            dispatchEvent(_local_2);
        }

        public function ___showEnemiesV_change(_arg_1:Event):void
        {
            this.refresh_E_Tab();
        }

        public function ___CityPanel_Button4_click(_arg_1:MouseEvent):void
        {
            this.onSetGoals(this.castleId);
        }

        [Bindable(event="propertyChange")]
        public function get _armies():Canvas
        {
            return (this._1299164186_armies);
        }

        [Bindable(event="propertyChange")]
        public function get _scriptTxt():TextArea
        {
            return (this._1238975450_scriptTxt);
        }

        private function _CityPanel_ClassFactory6_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory6 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory6", this._CityPanel_ClassFactory6);
            return (_local_1);
        }

        internal function get castleId():int
        {
            return (this._cityPanelBean.castleId);
        }

        private function _CityPanel_DataGridColumn30_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Energy";
            _local_1.dataField = "col5";
            _local_1.width = 50;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn53_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Goal";
            _local_1.dataField = "col5";
            _local_1.width = 0.1;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn76_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "From";
            _local_1.dataField = "col2";
            _local_1.width = 285;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        public function ___inputNewCastleName_enter(_arg_1:FlexEvent):void
        {
            this.onRename();
        }

        public function set _scriptTxt(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1238975450_scriptTxt;
            if (_local_2 !== _arg_1)
            {
                this._1238975450_scriptTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_scriptTxt", _local_2, _arg_1));
            };
        }

        public function set _runButton(_arg_1:Button):void
        {
            var _local_2:Object = this._1507357726_runButton;
            if (_local_2 !== _arg_1)
            {
                this._1507357726_runButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_runButton", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _inputNewCastleName():TextInput
        {
            return (this._496434264_inputNewCastleName);
        }

        [Bindable(event="propertyChange")]
        public function get _trade():Canvas
        {
            return (this._1464576923_trade);
        }

        private function _CityPanel_DataGridColumn41_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Cooldown";
            _local_1.dataField = "col5";
            _local_1.width = 185;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Rate";
            _local_1.dataField = "col3";
            _local_1.width = 0.15;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn64_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q8";
            _local_1.dataField = "col8";
            _local_1.width = 0.1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _valley():Canvas
        {
            return (this._1884649598_valley);
        }

        [Bindable(event="propertyChange")]
        public function get _troops():Canvas
        {
            return (this._1843183744_troops);
        }

        [Bindable(event="propertyChange")]
        private function get buildingData():ArrayCollection
        {
            return (this._982909826buildingData);
        }

        public function set _goalTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1742425533_goalTab;
            if (_local_2 !== _arg_1)
            {
                this._1742425533_goalTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_goalTab", _local_2, _arg_1));
            };
        }

        private function _CityPanel_ClassFactory5_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory5 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory5", this._CityPanel_ClassFactory5);
            return (_local_1);
        }

        public function ___CityPanel_Button9_click(_arg_1:MouseEvent):void
        {
            this.onSaveToFile(this._scriptTxt);
        }

        private function _CityPanel_DataGridColumn52_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Queue";
            _local_1.dataField = "col4";
            _local_1.width = 0.1;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn75_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Mission Type";
            _local_1.dataField = "col1";
            _local_1.width = 100;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _allinfo():ViewStack
        {
            return (this._1446694032_allinfo);
        }

        public function ___clearTextBtn_click(_arg_1:MouseEvent):void
        {
            this._inputNewCastleName.text = "";
            this._inputNewCastleName.setFocus();
        }

        private function _CityPanel_DataGridColumn40_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Bonus";
            _local_1.dataField = "col4";
            _local_1.width = 65;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "All";
            _local_1.dataField = "col6";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function set _inputNewCastleName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._496434264_inputNewCastleName;
            if (_local_2 !== _arg_1)
            {
                this._496434264_inputNewCastleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputNewCastleName", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn63_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q7";
            _local_1.dataField = "col7";
            _local_1.width = 0.1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get _cityPanelBean():CityPanelBean
        {
            return (this._1127919786_cityPanelBean);
        }

        [Bindable(event="propertyChange")]
        public function get _renameBtn():Button
        {
            return (this._271816895_renameBtn);
        }

        [Bindable(event="propertyChange")]
        public function get _clearTextBtn():Button
        {
            return (this._749805761_clearTextBtn);
        }

        [Bindable(event="propertyChange")]
        private function get fortificationsData():ArrayCollection
        {
            return (this._355347286fortificationsData);
        }

        public function setScriptState(_arg_1:int, _arg_2:Boolean):void
        {
            this.queueJobs.getCityPanelBean(_arg_1).scriptIsRunning = _arg_2;
        }

        private function _CityPanel_ClassFactory4_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory4 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory4", this._CityPanel_ClassFactory4);
            return (_local_1);
        }

        public function set _trade(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1464576923_trade;
            if (_local_2 !== _arg_1)
            {
                this._1464576923_trade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_trade", _local_2, _arg_1));
            };
        }

        private function get script():Script
        {
            return (this.city._getScript());
        }

        private function _CityPanel_DataGridColumn74_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "";
            _local_1.width = 57;
            _local_1.itemRenderer = this._CityPanel_ClassFactory10_i();
            return (_local_1);
        }

        private function set _castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1202148967_castleBean;
            if (_local_2 !== _arg_1)
            {
                this._1202148967_castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_castleBean", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn51_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "All";
            _local_1.dataField = "col8";
            _local_1.width = 0.12;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get resourceData():ArrayCollection
        {
            return (this._384864040resourceData);
        }

        [Bindable(event="propertyChange")]
        public function get _enemies():Canvas
        {
            return (this._752649447_enemies);
        }

        private function _CityPanel_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Amount";
            _local_1.dataField = "col2";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn62_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q6";
            _local_1.dataField = "col6";
            _local_1.width = 0.1;
            return (_local_1);
        }

        public function set _valley(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1884649598_valley;
            if (_local_2 !== _arg_1)
            {
                this._1884649598_valley = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_valley", _local_2, _arg_1));
            };
        }

        private function onNewArmyBtn():void
        {
            if (this._cityPanelBean.marchWin == null)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.TRAINING_FIELD_WIN));
            }
            else
            {
                PopUpWinManager.bringToFrontAndCenter(this._cityPanelBean.marchWin);
            };
        }

        public function set _troops(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1843183744_troops;
            if (_local_2 !== _arg_1)
            {
                this._1843183744_troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_troops", _local_2, _arg_1));
            };
        }

        private function set buildingData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._982909826buildingData;
            if (_local_2 !== _arg_1)
            {
                this._982909826buildingData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingData", _local_2, _arg_1));
            };
        }

        public function ___CityPanel_Button3_click(_arg_1:MouseEvent):void
        {
            this.onLoadFromFile(this._goalsTxt);
        }

        private function _CityPanel_ClassFactory3_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory3 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory3", this._CityPanel_ClassFactory3);
            return (_local_1);
        }

        private function get queueJobs():MainScreen
        {
            return (parentDocument as MainScreen);
        }

        private function _CityPanel_DataGridColumn50_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Total";
            _local_1.dataField = "col3";
            _local_1.width = 0.1;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn73_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Arrival";
            _local_1.dataField = "col4";
            _local_1.width = 0.2;
            return (_local_1);
        }

        internal function init():void
        {
            var xls:ExcelFile;
            var sheet:Sheet;
            this.timer = new Timer(5000);
            this.timer.addEventListener(TimerEvent.TIMER, this.populateInfoArea);
            this.timer.start();
            Utils.callLater(50, function ():void
            {
                var _local_1:Object;
                for each (_local_1 in _allinfo.getChildren())
                {
                    _local_1.addEventListener(FlexEvent.SHOW, populateInfoArea);
                };
            });
            this.isInitialized = true;
        }

        public function setMarchWin(_arg_1:NewArmyWin):void
        {
            this._cityPanelBean.marchWin = _arg_1;
        }

        private function set gearsData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2006530702gearsData;
            if (_local_2 !== _arg_1)
            {
                this._2006530702gearsData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gearsData", _local_2, _arg_1));
            };
        }

        public function set _allinfo(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1446694032_allinfo;
            if (_local_2 !== _arg_1)
            {
                this._1446694032_allinfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_allinfo", _local_2, _arg_1));
            };
        }

        private function set externalTroopData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._35298671externalTroopData;
            if (_local_2 !== _arg_1)
            {
                this._35298671externalTroopData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "externalTroopData", _local_2, _arg_1));
            };
        }

        private function onSaveGoals(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:SharedObject = SharedObject.getLocal(("citygoals" + _arg_1));
            _local_3.data.now = this.queueJobs.getCityPanelBean(_arg_1).goalsTxt;
            var _local_4:String = _local_3.flush();
            if (_local_4 != "flushed")
            {
                this.city.cityManager.logMsg((("SAVING PROBLEM: " + _local_4) + ", you may need to increase flash local storage"));
            }
            else
            {
                if (!_arg_2)
                {
                    this.city.cityManager.logMsg("Goal has been saved successfully");
                };
            };
        }

        private function keyDownHandle(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                this._inputNewCastleName.text = "";
                this._inputNewCastleName.visible = false;
            };
        }

        private function _CityPanel_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Resource";
            _local_1.dataField = "col1";
            _local_1.width = 0.25;
            return (_local_1);
        }

        public function onMarchWinClosed(_arg_1:int):void
        {
            this.queueJobs.getCityPanelBean(_arg_1).marchWin = null;
        }

        [Bindable(event="propertyChange")]
        private function get troopQueueData():ArrayCollection
        {
            return (this._1676058921troopQueueData);
        }

        private function _CityPanel_DataGridColumn61_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q5";
            _local_1.dataField = "col5";
            _local_1.width = 0.1;
            return (_local_1);
        }

        private function _CityPanel_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory2", this._CityPanel_ClassFactory2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _showSelf():CheckBox
        {
            return (this._248346296_showSelf);
        }

        public function ___CityPanel_Button8_click(_arg_1:MouseEvent):void
        {
            this.onNewArmyBtn();
        }

        private function _CityPanel_DataGridColumn72_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Amount";
            _local_1.dataField = "col3";
            _local_1.width = 0.3;
            return (_local_1);
        }

        public function set cityPanelBean(_arg_1:CityPanelBean):void
        {
            this._cityPanelBean = _arg_1;
            if (this._cityPanelBean.marchWin != null)
            {
                PopUpWinManager.bringToFront(this._cityPanelBean.marchWin);
            };
        }

        public function set _showEnemies(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1839459670_showEnemies;
            if (_local_2 !== _arg_1)
            {
                this._1839459670_showEnemies = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showEnemies", _local_2, _arg_1));
            };
        }

        private function set troopsData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2009763499troopsData;
            if (_local_2 !== _arg_1)
            {
                this._2009763499troopsData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopsData", _local_2, _arg_1));
            };
        }

        private function set _cityPanelBean(_arg_1:CityPanelBean):void
        {
            var _local_2:Object = this._1127919786_cityPanelBean;
            if (_local_2 !== _arg_1)
            {
                this._1127919786_cityPanelBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_cityPanelBean", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn19_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Type";
            _local_1.dataField = "col2";
            _local_1.width = 0.1;
            return (_local_1);
        }

        public function _onRecallArmyBtn(_arg_1:int):void
        {
            if (_arg_1 == -1)
            {
                return;
            };
            this.city.cityManager.logMsg(("Recalling friendly army with armyId: " + _arg_1));
            ActionFactory.getInstance().getArmyCommands().callBackArmy(this.city.castleId, _arg_1);
            if (this.externalTroopData != null)
            {
                Utils.callLater(3000, this.city.cityManager._populate_E_Tab, [this.externalTroopData, ((this._showEnemies) ? this._showEnemies.selected : true), ((this._showEnemiesV) ? this._showEnemiesV.selected : true), ((this._showEnemiesC) ? this._showEnemiesC.selected : true), ((this._showFriendlies) ? this._showFriendlies.selected : true), ((this._showSelf) ? this._showSelf.selected : true)]);
            };
        }

        private function set fortificationsData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._355347286fortificationsData;
            if (_local_2 !== _arg_1)
            {
                this._355347286fortificationsData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortificationsData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn60_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q4";
            _local_1.dataField = "col4";
            _local_1.width = 0.1;
            return (_local_1);
        }

        internal function get city():CityState
        {
            return (MainScreen.getCityFromCastleId(this._cityPanelBean.castleId));
        }

        private function populateInfoArea(_arg_1:Object=null):void
        {
            var _local_2:CityManager = this.city.cityManager;
            this._cityInfoProd.text = ((_local_2.productionRate != -1) ? (_local_2.productionRate + "%") : "");
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._resource)))
            {
                _local_2._populate_R_Tab(this.resourceData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._valley)))
            {
                _local_2._populate_V_Tab(this.valleyData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._colony)))
            {
                _local_2._populate_C_Tab(this.colonyData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._innheroes)))
            {
                _local_2._populate_I_Tab(this.innHeroData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._heroes)))
            {
                _local_2._populate_H_Tab(this.heroData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._buildings)))
            {
                _local_2._populate_B_Tab(this.buildingData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._research)))
            {
                _local_2._populate_S_Tab(this.researchData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._gears)))
            {
                _local_2._populate_G_Tab(this.gearsData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._armies)))
            {
                _local_2._populate_A_Tab(this.armyData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._troops)))
            {
                _local_2._populate_T_Tab(this.troopsData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._troopQueues)))
            {
                _local_2._populate_Q_Tab(this.troopQueueData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._fortifications)))
            {
                _local_2._populate_F_Tab(this.fortificationsData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._trade)))
            {
                _local_2._populate_X_Tab(this.tradesData);
            };
            if (((_arg_1 == null) || (this._allinfo.selectedChild == this._enemies)))
            {
                if (!(((((this._showEnemies == null) || (this._showEnemiesV == null)) || (this._showEnemiesC == null)) || (this._showFriendlies == null)) || (this._showSelf == null)))
                {
                    _local_2._populate_E_Tab(this.externalTroopData, this._showEnemies.selected, this._showEnemiesV.selected, this._showEnemiesC.selected, this._showFriendlies.selected, this._showSelf.selected);
                }
                else
                {
                    _local_2._populate_E_Tab(this.externalTroopData);
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _resource():Canvas
        {
            return (this._250546835_resource);
        }

        public function set _renameBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._271816895_renameBtn;
            if (_local_2 !== _arg_1)
            {
                this._271816895_renameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_renameBtn", _local_2, _arg_1));
            };
        }

        public function set _buildings(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1405697728_buildings;
            if (_local_2 !== _arg_1)
            {
                this._1405697728_buildings = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_buildings", _local_2, _arg_1));
            };
        }

        private function _CityPanel_ClassFactory11_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory11 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory11", this._CityPanel_ClassFactory11);
            return (_local_1);
        }

        public function set _clearTextBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._749805761_clearTextBtn;
            if (_local_2 !== _arg_1)
            {
                this._749805761_clearTextBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_clearTextBtn", _local_2, _arg_1));
            };
        }

        private function _CityPanel_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory1", this._CityPanel_ClassFactory1);
            return (_local_1);
        }

        private function set heroData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._619403580heroData;
            if (_local_2 !== _arg_1)
            {
                this._619403580heroData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn71_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Resource";
            _local_1.dataField = "col2";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function ___showFriendlies_change(_arg_1:Event):void
        {
            this.refresh_E_Tab();
        }

        [Bindable(event="propertyChange")]
        public function get _cityInfoProd():Label
        {
            return (this._1647526287_cityInfoProd);
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this._castleBean = _arg_1;
            this.populateInfoArea();
        }

        public function set _infoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._8659656_infoTab;
            if (_local_2 !== _arg_1)
            {
                this._8659656_infoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_infoTab", _local_2, _arg_1));
            };
        }

        internal function onUseArmyItem(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            ActionFactory.getInstance().getShopCommands().useTrickItem(_arg_1, _arg_2, _arg_3);
        }

        private function logMsg(_arg_1:String, _arg_2:String="#000000"):void
        {
            this.queueJobs.logMsg(_arg_1, _arg_2);
        }

        private function _CityPanel_DataGridColumn18_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Hero";
            _local_1.dataField = "col1";
            _local_1.width = 0.2;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function set resourceData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._384864040resourceData;
            if (_local_2 !== _arg_1)
            {
                this._384864040resourceData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceData", _local_2, _arg_1));
            };
        }

        public function set _showEnemiesC(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1188674855_showEnemiesC;
            if (_local_2 !== _arg_1)
            {
                this._1188674855_showEnemiesC = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showEnemiesC", _local_2, _arg_1));
            };
        }

        private function onSaveToFile(source:TextArea):void
        {
            var saveFile:FileReference;
            var cP:CityPanelBean;
            var completedHandler:Function;
            var canceledHandler:Function;
            var errorHandler:Function;
            if (((source == null) || (source.text == "")))
            {
                return;
            };
            var outputText:String = source.text.replace(/\r\n?|\n/g, "\r\n");
            var outputFileName:String = "";
            saveFile = null;
            cP = this._cityPanelBean;
            if (source.id == this._scriptTxt.id)
            {
                if (((!(cP.lastSavedScriptFileName == null)) && (!(cP.lastSavedScriptFileName == ""))))
                {
                    outputFileName = cP.lastSavedScriptFileName;
                }
                else
                {
                    if (((!(cP.lastLoadedScriptFileName == null)) && (!(cP.lastLoadedScriptFileName == ""))))
                    {
                        outputFileName = cP.lastLoadedScriptFileName;
                    }
                    else
                    {
                        outputFileName = (((this.city.player.playerInfo.userName + "_") + this.city.castle.name) + "_script.txt");
                    };
                };
            };
            if (source.id == this._goalsTxt.id)
            {
                if (((!(cP.lastSavedGoalsFileName == null)) && (!(cP.lastSavedGoalsFileName == ""))))
                {
                    outputFileName = cP.lastSavedGoalsFileName;
                }
                else
                {
                    if (((!(cP.lastLoadedGoalsFileName == null)) && (!(cP.lastLoadedGoalsFileName == ""))))
                    {
                        outputFileName = cP.lastLoadedGoalsFileName;
                    }
                    else
                    {
                        outputFileName = (((this.city.player.playerInfo.userName + "_") + this.city.castle.name) + "_goals.txt");
                    };
                };
            };
            saveFile = new FileReference();
            completedHandler = function (_arg_1:Event):void
            {
                saveFile.removeEventListener(Event.COMPLETE, completedHandler);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                if (source.id == _scriptTxt.id)
                {
                    cP.lastSavedScriptFileName = saveFile.name;
                };
                if (source.id == _goalsTxt.id)
                {
                    cP.lastSavedGoalsFileName = saveFile.name;
                };
                city.cityManager.logMsg((('The file "' + saveFile.name) + '" has been saved successfully.'));
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("The file has been saved successfully. " + _arg_1));
                };
            };
            canceledHandler = function (_arg_1:Event):void
            {
                saveFile.removeEventListener(Event.COMPLETE, completedHandler);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("The file save has been canceled. " + _arg_1));
                };
            };
            errorHandler = function (_arg_1:IOErrorEvent):void
            {
                saveFile.removeEventListener(Event.COMPLETE, completedHandler);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("An error occured while saving the file. " + _arg_1));
                };
            };
            try
            {
                saveFile.addEventListener(Event.COMPLETE, completedHandler);
                saveFile.addEventListener(Event.CANCEL, canceledHandler);
                saveFile.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile.save(outputText, outputFileName);
            }
            catch(error:Error)
            {
                if (Version.isTraceOn())
                {
                    trace(error);
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _troopQueues():Canvas
        {
            return (this._623064501_troopQueues);
        }

        private function _CityPanel_DataGridColumn29_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Base";
            _local_1.dataField = "col4";
            _local_1.width = 45;
            return (_local_1);
        }

        private function _CityPanel_ClassFactory10_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory10 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory10", this._CityPanel_ClassFactory10);
            return (_local_1);
        }

        public function ___CityPanel_Button2_click(_arg_1:MouseEvent):void
        {
            this.onSaveToFile(this._goalsTxt);
        }

        private function _CityPanel_DataGridColumn70_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "eXchange";
            _local_1.dataField = "col1";
            _local_1.width = 0.2;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get innHeroData():ArrayCollection
        {
            return (this._1649235507innHeroData);
        }

        public function set _enemies(_arg_1:Canvas):void
        {
            var _local_2:Object = this._752649447_enemies;
            if (_local_2 !== _arg_1)
            {
                this._752649447_enemies = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_enemies", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _innheroes():Canvas
        {
            return (this._1942092334_innheroes);
        }

        internal function _onRecallHeroBtn(_arg_1:int):void
        {
            this.city.cityManager.logMsg(("Recalling hero with heroId: " + _arg_1));
            ActionFactory.getInstance().getHeroCommand().callBackHero(this.city.castleId, _arg_1);
            Utils.callLater(2500, this.city.cityManager._populate_H_Tab, [this.heroData]);
        }

        private function _CityPanel_DataGridColumn17_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Abandon";
            _local_1.width = 0.2;
            _local_1.itemRenderer = this._CityPanel_ClassFactory2_i();
            return (_local_1);
        }

        public function set _showEnemiesV(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1188674836_showEnemiesV;
            if (_local_2 !== _arg_1)
            {
                this._1188674836_showEnemiesV = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showEnemiesV", _local_2, _arg_1));
            };
        }

        public function ___stopButton_click(_arg_1:MouseEvent):void
        {
            this.onStopScript();
        }

        private function set armyData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1415438617armyData;
            if (_local_2 !== _arg_1)
            {
                this._1415438617armyData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyData", _local_2, _arg_1));
            };
        }

        public function ___goalsTxt_change(_arg_1:Event):void
        {
            this.onTxtChange(this._goalsTxt);
        }

        public function ___renameBtn_click(_arg_1:MouseEvent):void
        {
            this.onRenameBtn();
        }

        public function set _research(_arg_1:Canvas):void
        {
            var _local_2:Object = this._260377862_research;
            if (_local_2 !== _arg_1)
            {
                this._260377862_research = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_research", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn28_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Type";
            _local_1.dataField = "col3";
            _local_1.width = 80;
            return (_local_1);
        }

        private function onRename():void
        {
            if ((((this._inputNewCastleName.text.length < 1) || (this._inputNewCastleName.text == "")) || (this._inputNewCastleName.text == this._castleBean.name)))
            {
                return;
            };
            ActionFactory.getInstance().getCityCommands().modifyCastleName(this.castleId, this._inputNewCastleName.text, this._castleBean.logUrl, this.onChangeNameResponse);
        }

        public function set _fortifications(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1472639233_fortifications;
            if (_local_2 !== _arg_1)
            {
                this._1472639233_fortifications = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_fortifications", _local_2, _arg_1));
            };
        }

        public function ___CityPanel_Button10_click(_arg_1:MouseEvent):void
        {
            this.onLoadFromFile(this._scriptTxt);
        }

        public function ___CityPanel_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
        }

        public function ___runButton_click(_arg_1:MouseEvent):void
        {
            this.onRunScript(this.castleId);
        }

        public function ___CityPanel_Button7_click(_arg_1:MouseEvent):void
        {
            this.onSaveAll();
        }

        private function getIdlePopColor(_arg_1:int, _arg_2:int):String
        {
            return (((_arg_1 - _arg_2) >= 0) ? "0x00DA00" : (((_arg_1 - _arg_2) < -100) ? "0xEC0000" : "0xDBDB00"));
        }

        public function ___scriptTxt_change(_arg_1:Event):void
        {
            this.onTxtChange(this._scriptTxt);
        }

        private function _CityPanel_DataGridColumn16_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Event Time";
            _local_1.dataField = "col5";
            _local_1.width = 0.45;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn39_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Star";
            _local_1.dataField = "col3";
            _local_1.width = 50;
            return (_local_1);
        }

        private function refresh_E_Tab():void
        {
            this.city.cityManager._populate_E_Tab(this.externalTroopData, this._showEnemies.selected, this._showEnemiesV.selected, this._showEnemiesC.selected, this._showFriendlies.selected, this._showSelf.selected);
        }

        [Bindable(event="propertyChange")]
        public function get _colony():Canvas
        {
            return (this._1353628185_colony);
        }

        private function _CityPanel_DataGridColumn27_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level";
            _local_1.dataField = "col8";
            _local_1.width = 45;
            return (_local_1);
        }

        internal function _onAbandonFieldBtn(_arg_1:int):void
        {
            this.queueJobs.logMsg(("Abandon field: " + Map.fieldIdToString(_arg_1)));
            ActionFactory.getInstance().getFieldCommand().giveUpField(_arg_1);
            Utils.callLater(2500, this.city.cityManager._populate_V_Tab, [this.valleyData]);
        }

        [Bindable(event="propertyChange")]
        public function get _goalTab():TabBar
        {
            return (this._1742425533_goalTab);
        }

        public function ___CityPanel_Button15_click(_arg_1:MouseEvent):void
        {
            this.onSaveAll();
        }

        private function onConfirmFireHero(_arg_1:Boolean, _arg_2:int):void
        {
            if (!_arg_1)
            {
                return;
            };
            this.city.cityManager.logMsg(("Firing hero with heroId: " + _arg_2));
            ActionFactory.getInstance().getHeroCommand().fireHero(this.city.castleId, _arg_2);
            Utils.callLater(2500, this.city.cityManager._populate_H_Tab, [this.heroData]);
            this.city.cityManager.setHeroUpdateNeeded();
        }

        private function set troopQueueData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1676058921troopQueueData;
            if (_local_2 !== _arg_1)
            {
                this._1676058921troopQueueData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopQueueData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn15_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Relation";
            _local_1.dataField = "col4";
            _local_1.width = 0.16;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn38_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level";
            _local_1.dataField = "col2";
            _local_1.width = 55;
            return (_local_1);
        }

        internal function onHideRename(evtObj:Object):void
        {
            try
            {
                if (!this._inputNewCastleName.visible)
                {
                    return;
                };
                if (evtObj == null)
                {
                    return;
                };
                if ((evtObj is UITextField))
                {
                    if ((((evtObj.parent) && (evtObj.parent.id)) && (evtObj.parent.id == "_inputNewCastleName")))
                    {
                        return;
                    };
                }
                else
                {
                    if (((evtObj.id) && ((evtObj.id == "_inputNewCastleName") || (evtObj.id == "_clearTextBtn"))))
                    {
                        return;
                    };
                };
                this._inputNewCastleName.text = "";
                this._inputNewCastleName.visible = false;
            }
            catch(error:Error)
            {
                if (Version.isTraceOn())
                {
                    trace(error.message);
                };
            };
        }

        public function ___showSelf_change(_arg_1:Event):void
        {
            this.refresh_E_Tab();
        }

        internal function _hireHero(_arg_1:String):void
        {
            this.city.cityManager.logMsg(("Hiring hero with Name: " + _arg_1));
            CityStateCommands.hireHero(this.city.castleId, _arg_1, this.onHireHeroResponse);
            Utils.callLater(2500, this.city.cityManager._populate_I_Tab, [this.innHeroData]);
        }

        [Bindable(event="propertyChange")]
        private function get _castleBean():CastleBean
        {
            return (this._1202148967_castleBean);
        }

        private function _CityPanel_DataGridColumn26_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Status";
            _local_1.dataField = "col2";
            _local_1.width = 55;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn49_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Avail";
            _local_1.dataField = "col2";
            _local_1.width = 0.1;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        public function ___CityPanel_Button1_click(_arg_1:MouseEvent):void
        {
            this.onNewArmyBtn();
        }

        public function set _heroes(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1487717191_heroes;
            if (_local_2 !== _arg_1)
            {
                this._1487717191_heroes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_heroes", _local_2, _arg_1));
            };
        }

        public function set _showSelf(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._248346296_showSelf;
            if (_local_2 !== _arg_1)
            {
                this._248346296_showSelf = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showSelf", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get externalTroopData():ArrayCollection
        {
            return (this._35298671externalTroopData);
        }

        private function _CityPanel_DataGridColumn14_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "col3";
            _local_1.width = 0.21;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn37_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Gear Name";
            _local_1.dataField = "col1";
            _local_1.width = 115;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get gearsData():ArrayCollection
        {
            return (this._2006530702gearsData);
        }

        [Bindable(event="propertyChange")]
        public function get _showEnemies():CheckBox
        {
            return (this._1839459670_showEnemies);
        }

        internal function _onAbandonColonyBtn(_arg_1:int):void
        {
            var _local_2:ColonyBean = this.city.cityManager.getColony(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            this.queueJobs.logMsg((((((("Begin abandon colony " + _local_2.cityName) + Map.fieldIdToCoordString(_arg_1)) + " by ") + _local_2.lordName) + " of ") + _local_2.allianceName));
            ActionFactory.getInstance().getColonyCommands().abandonColony(this.city.castleId, _local_2.castleId);
            Utils.callLater(2500, this.city.cityManager._populate_C_Tab, [this.colonyData]);
        }

        private function onStopScript():void
        {
            this.queueJobs.logMsg("     Script Stopped");
            this.script.stop();
            this._cityPanelBean.scriptIsRunning = false;
        }

        private function _CityPanel_DataGridColumn25_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Hero";
            _local_1.dataField = "col1";
            _local_1.width = 90;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn48_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Troop";
            _local_1.dataField = "col1";
            _local_1.width = 0.24;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _buildings():Canvas
        {
            return (this._1405697728_buildings);
        }

        [Bindable(event="propertyChange")]
        private function get troopsData():ArrayCollection
        {
            return (this._2009763499troopsData);
        }

        [Bindable(event="propertyChange")]
        private function get heroData():ArrayCollection
        {
            return (this._619403580heroData);
        }

        public function ___CityPanel_Button6_click(_arg_1:MouseEvent):void
        {
            this._cityPanelBean.onLoadGoals();
        }

        private function _CityPanel_DataGridColumn13_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Lord";
            _local_1.dataField = "col2";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn36_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level";
            _local_1.dataField = "col2";
            _local_1.width = 0.35;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn59_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q3";
            _local_1.dataField = "col3";
            _local_1.width = 0.1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _infoTab():TabBar
        {
            return (this._8659656_infoTab);
        }

        private function _CityPanel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _goalTab.enabled = _arg_1;
            }, "_goalTab.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._cityPanelBean.goalsTxt;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _goalsTxt.text = _arg_1;
            }, "_goalsTxt.text");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button1.enabled = _arg_1;
            }, "_CityPanel_Button1.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button2.enabled = _arg_1;
            }, "_CityPanel_Button2.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button3.enabled = _arg_1;
            }, "_CityPanel_Button3.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button4.enabled = _arg_1;
            }, "_CityPanel_Button4.enabled");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button5.enabled = _arg_1;
            }, "_CityPanel_Button5.enabled");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button6.enabled = _arg_1;
            }, "_CityPanel_Button6.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _CityPanel_Button7.enabled = _arg_1;
            }, "_CityPanel_Button7.enabled");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._cityPanelBean.scriptTxt;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _scriptTxt.text = _arg_1;
            }, "_scriptTxt.text");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._cityPanelBean.scriptIsRunning));
            }, function (_arg_1:Boolean):void
            {
                _runButton.enabled = _arg_1;
            }, "_runButton.enabled");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._cityPanelBean.scriptIsRunning);
            }, function (_arg_1:Boolean):void
            {
                _stopButton.enabled = _arg_1;
            }, "_stopButton.enabled");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._castleBean.name.replace(new RegExp(String.fromCharCode(65279), "g"), "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Text1.text = _arg_1;
            }, "_CityPanel_Text1.text");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._castleBean.powerlevel == 4);
            }, function (_arg_1:Boolean):void
            {
                _renameBtn.visible = _arg_1;
            }, "_renameBtn.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._castleBean.powerlevel == 4);
            }, function (_arg_1:Boolean):void
            {
                _renameBtn.includeInLayout = _arg_1;
            }, "_renameBtn.includeInLayout");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._inputNewCastleName.text.length > 0);
            }, function (_arg_1:Boolean):void
            {
                _clearTextBtn.visible = _arg_1;
            }, "_clearTextBtn.visible");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._castleBean.resource.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Label1.text = _arg_1;
            }, "_CityPanel_Label1.text");
            result[16] = binding;
            binding = new Binding(this, function ():uint
            {
                return (this.getLoyColor(this._castleBean.resource.support));
            }, function (_arg_1:uint):void
            {
                _CityPanel_Label1.setStyle("color", _arg_1);
            }, "_CityPanel_Label1.color");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._castleBean.resource.complaint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Label3.text = _arg_1;
            }, "_CityPanel_Label3.text");
            result[18] = binding;
            binding = new Binding(this, function ():uint
            {
                return (this.getGrieveColor(this._castleBean.resource.complaint));
            }, function (_arg_1:uint):void
            {
                _CityPanel_Label3.setStyle("color", _arg_1);
            }, "_CityPanel_Label3.color");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this._castleBean.resource.texRate + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Label4.text = _arg_1;
            }, "_CityPanel_Label4.text");
            result[20] = binding;
            binding = new Binding(this, function ():uint
            {
                return (this.getTaxColor(this._castleBean.resource.texRate));
            }, function (_arg_1:uint):void
            {
                _CityPanel_Label4.setStyle("color", _arg_1);
            }, "_CityPanel_Label4.color");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Map.fieldIdToCoordString(this._castleBean.fieldId) + "  ") + Map.getRegionName(this._castleBean.fieldId));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Text2.text = _arg_1;
            }, "_CityPanel_Text2.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this._castleBean.resource.curPopulation);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Label5.text = _arg_1;
            }, "_CityPanel_Label5.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum((this._castleBean.resource.curPopulation - this._castleBean.resource.workPeople));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CityPanel_Label7.text = _arg_1;
            }, "_CityPanel_Label7.text");
            result[24] = binding;
            binding = new Binding(this, function ():uint
            {
                return (this.getIdlePopColor(this._castleBean.resource.curPopulation, this._castleBean.resource.workPeople));
            }, function (_arg_1:uint):void
            {
                _CityPanel_Label7.setStyle("color", _arg_1);
            }, "_CityPanel_Label7.color");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._castleBean == null));
            }, function (_arg_1:Boolean):void
            {
                _infoTab.enabled = _arg_1;
            }, "_infoTab.enabled");
            result[26] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.resourceData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid1.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid1.dataProvider");
            result[27] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.valleyData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid1.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid1.dataProvider");
            result[28] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent1);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory1.generator = _arg_1;
            }, "_CityPanel_ClassFactory1.generator");
            result[29] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.colonyData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid2.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid2.dataProvider");
            result[30] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory2.generator = _arg_1;
            }, "_CityPanel_ClassFactory2.generator");
            result[31] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.innHeroData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid2.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid2.dataProvider");
            result[32] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent5);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory3.generator = _arg_1;
            }, "_CityPanel_ClassFactory3.generator");
            result[33] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heroData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid3.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid3.dataProvider");
            result[34] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent2_3);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory4.generator = _arg_1;
            }, "_CityPanel_ClassFactory4.generator");
            result[35] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent2_1);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory5.generator = _arg_1;
            }, "_CityPanel_ClassFactory5.generator");
            result[36] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent2_2);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory6.generator = _arg_1;
            }, "_CityPanel_ClassFactory6.generator");
            result[37] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.buildingData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid3.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid3.dataProvider");
            result[38] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.researchData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid4.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid4.dataProvider");
            result[39] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.gearsData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid5.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid5.dataProvider");
            result[40] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent7);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory7.generator = _arg_1;
            }, "_CityPanel_ClassFactory7.generator");
            result[41] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.armyData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid4.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid4.dataProvider");
            result[42] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent6);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory8.generator = _arg_1;
            }, "_CityPanel_ClassFactory8.generator");
            result[43] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent3);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory9.generator = _arg_1;
            }, "_CityPanel_ClassFactory9.generator");
            result[44] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troopsData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid5.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid5.dataProvider");
            result[45] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troopQueueData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid6.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid6.dataProvider");
            result[46] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.fortificationsData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid6.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid6.dataProvider");
            result[47] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.tradesData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_DataGrid7.dataProvider = _arg_1;
            }, "_CityPanel_DataGrid7.dataProvider");
            result[48] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.externalTroopData);
            }, function (_arg_1:Object):void
            {
                _CityPanel_RowColorDataGrid7.dataProvider = _arg_1;
            }, "_CityPanel_RowColorDataGrid7.dataProvider");
            result[49] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent6);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory10.generator = _arg_1;
            }, "_CityPanel_ClassFactory10.generator");
            result[50] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CityPanel_inlineComponent4);
            }, function (_arg_1:Class):void
            {
                _CityPanel_ClassFactory11.generator = _arg_1;
            }, "_CityPanel_ClassFactory11.generator");
            result[51] = binding;
            return (result);
        }

        public function ___inputNewCastleName_keyDown(_arg_1:KeyboardEvent):void
        {
            this.keyDownHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get _showEnemiesC():CheckBox
        {
            return (this._1188674855_showEnemiesC);
        }

        public function set _resource(_arg_1:Canvas):void
        {
            var _local_2:Object = this._250546835_resource;
            if (_local_2 !== _arg_1)
            {
                this._250546835_resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_resource", _local_2, _arg_1));
            };
        }

        public function set _stopButton(_arg_1:Button):void
        {
            var _local_2:Object = this._746461325_stopButton;
            if (_local_2 !== _arg_1)
            {
                this._746461325_stopButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_stopButton", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyData():ArrayCollection
        {
            return (this._1415438617armyData);
        }

        [Bindable(event="propertyChange")]
        public function get _showEnemiesV():CheckBox
        {
            return (this._1188674836_showEnemiesV);
        }

        private function onLoadFromFile(target:TextArea):void
        {
            var loadFile:FileReference;
            var cP:CityPanelBean;
            var selectedHandler:Function;
            var canceledHandler:Function;
            var completeHandler:Function;
            var errorHandler:Function;
            loadFile = null;
            cP = this._cityPanelBean;
            selectedHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.SELECT, selectedHandler);
                loadFile.removeEventListener(Event.CANCEL, canceledHandler);
                loadFile.addEventListener(Event.COMPLETE, completeHandler);
                loadFile.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                loadFile.load();
            };
            canceledHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.SELECT, selectedHandler);
                loadFile.removeEventListener(Event.CANCEL, canceledHandler);
                if (Version.isTraceOn())
                {
                    trace(("The file load has been canceled. " + _arg_1));
                };
                loadFile = null;
            };
            completeHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.COMPLETE, completeHandler);
                loadFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                var _local_2:String = loadFile.data.readUTFBytes(loadFile.data.bytesAvailable).replace(/\r\n?|\n/g, "\n");
                if (target.id == _scriptTxt.id)
                {
                    cP.scriptTxt = _local_2;
                    cP.lastLoadedScriptFileName = loadFile.name;
                };
                if (target.id == _goalsTxt.id)
                {
                    cP.goalsTxt = _local_2;
                    cP.lastLoadedGoalsFileName = loadFile.name;
                };
                city.cityManager.logMsg((((('The contents of file "' + loadFile.name) + '" was loaded successfully to the ') + ((target.id == _scriptTxt.id) ? "Script" : ((target.id == _goalsTxt.id) ? "Goals" : ""))) + " window."));
                loadFile = null;
            };
            errorHandler = function (_arg_1:IOErrorEvent):void
            {
                loadFile.removeEventListener(Event.COMPLETE, completeHandler);
                loadFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                if (Version.isTraceOn())
                {
                    trace(("Error loading file : " + _arg_1.text));
                };
                city.cityManager.logMsg(("An error occured while loading the file. " + _arg_1), "#FF9933");
                loadFile = null;
            };
            loadFile = new FileReference();
            loadFile.addEventListener(Event.SELECT, selectedHandler);
            loadFile.addEventListener(Event.CANCEL, canceledHandler);
            loadFile.browse([new FileFilter("Text File", "*.txt;*.text")]);
        }

        private function _CityPanel_DataGridColumn24_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "";
            _local_1.width = 50;
            _local_1.itemRenderer = this._CityPanel_ClassFactory4_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn47_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Recall";
            _local_1.width = 65;
            _local_1.itemRenderer = this._CityPanel_ClassFactory9_i();
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _research():Canvas
        {
            return (this._260377862_research);
        }

        [Bindable(event="propertyChange")]
        public function get _fortifications():Canvas
        {
            return (this._1472639233_fortifications);
        }

        public function ___showEnemies_change(_arg_1:Event):void
        {
            this.refresh_E_Tab();
        }

        public function ___CityPanel_Button14_click(_arg_1:MouseEvent):void
        {
            this._cityPanelBean.onLoadScript();
        }

        private function _CityPanel_DataGridColumn12_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Coord";
            _local_1.dataField = "col1";
            _local_1.width = 0.18;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn35_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Research Name";
            _local_1.dataField = "col1";
            _local_1.width = 0.25;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn58_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q2";
            _local_1.dataField = "col2";
            _local_1.width = 0.1;
            return (_local_1);
        }

        public function set _showFriendlies(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1321633669_showFriendlies;
            if (_local_2 !== _arg_1)
            {
                this._1321633669_showFriendlies = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showFriendlies", _local_2, _arg_1));
            };
        }

        public function set _cityInfoProd(_arg_1:Label):void
        {
            var _local_2:Object = this._1647526287_cityInfoProd;
            if (_local_2 !== _arg_1)
            {
                this._1647526287_cityInfoProd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_cityInfoProd", _local_2, _arg_1));
            };
        }

        private function onRenameBtn():void
        {
            this._inputNewCastleName.visible = true;
            this._inputNewCastleName.text = this._castleBean.name;
            this._inputNewCastleName.setFocus();
            Utils.callLater(100, function ():void
            {
                _inputNewCastleName.selectionBeginIndex = 0;
                _inputNewCastleName.selectionEndIndex = _castleBean.name.length;
            });
        }

        private function onTxtChange(_arg_1:TextArea):void
        {
            var _local_2:String = ("." + _arg_1.styleName);
            _arg_1.setStyle("color", ("#" + int(ThemeManager.getStyle(_local_2, "color")).toString(16).toUpperCase()));
            _arg_1.setStyle("fontFamily", ("" + ThemeManager.getStyle(_local_2, "fontFamily")));
            this._cityPanelBean[_arg_1.id.substr(1)] = _arg_1.text;
        }

        private function getLoyColor(_arg_1:int):String
        {
            return ((_arg_1 == 100) ? "0x00DA00" : ((_arg_1 <= 25) ? "0xEC0000" : "0xDBDB00"));
        }

        private function onGearResearchResponse(_arg_1:ResearchResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.city.cityManager.logMsg(((("An error was received while upgrading gear: " + _arg_1.errorMsg) + ": ") + _arg_1.ok), "#CC0000");
                return;
            };
            if (_arg_1.tech.castleId != this.city.castleId)
            {
                return;
            };
            this.city.cityManager._handleGearCmdResponse(_arg_1);
            var _local_2:Date = new Date(_arg_1.tech.endTime);
            this.city.cityManager.logMsg(((((GearType.toNameString(_arg_1.tech.typeId) + " level ") + (_arg_1.tech.level + 1)) + " research started.  Estimated finish time ") + _local_2.toLocaleString()), "");
        }

        private function _CityPanel_DataGridColumn23_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Hire";
            _local_1.width = 0.12;
            _local_1.itemRenderer = this._CityPanel_ClassFactory3_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn9_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level";
            _local_1.dataField = "col3";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn69_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "In Queues";
            _local_1.dataField = "col3";
            _local_1.width = 0.25;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _heroes():Canvas
        {
            return (this._1487717191_heroes);
        }

        internal function unInit():void
        {
            var _local_1:Object;
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.populateInfoArea);
            this.timer = null;
            for each (_local_1 in this._allinfo.getChildren())
            {
                _local_1.removeEventListener(FlexEvent.SHOW, this.populateInfoArea);
            };
        }

        private function _CityPanel_DataGridColumn11_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Abandon";
            _local_1.width = 0.2;
            _local_1.itemRenderer = this._CityPanel_ClassFactory1_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn34_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Level(s)";
            _local_1.dataField = "col2";
            _local_1.width = 0.6;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn57_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q1";
            _local_1.dataField = "col1";
            _local_1.width = 0.1;
            return (_local_1);
        }

        private function set valleyData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1626662999valleyData;
            if (_local_2 !== _arg_1)
            {
                this._1626662999valleyData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "valleyData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn46_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Remain time";
            _local_1.dataField = "col3";
            _local_1.width = 95;
            return (_local_1);
        }

        public function set _troopQueues(_arg_1:Canvas):void
        {
            var _local_2:Object = this._623064501_troopQueues;
            if (_local_2 !== _arg_1)
            {
                this._623064501_troopQueues = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_troopQueues", _local_2, _arg_1));
            };
        }

        private function onHireHeroResponse(_arg_1:CommandResponse):void
        {
            this.city.cityManager.updateInn();
            if (_arg_1.ok != 1)
            {
                this.city.cityManager.logMsg(("An error occurred during hire hero: " + _arg_1.errorMsg));
            };
        }

        private function _CityPanel_DataGridColumn22_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Base";
            _local_1.dataField = "col5";
            _local_1.width = 0.16;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn45_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Target";
            _local_1.dataField = "col2";
            _local_1.width = 285;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn8_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Type";
            _local_1.dataField = "col2";
            _local_1.width = 0.2;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _stopButton():Button
        {
            return (this._746461325_stopButton);
        }

        public function onSetGoals(_arg_1:int):void
        {
            var _local_2:CityPanelBean = this.queueJobs.getCityPanelBean(_arg_1);
            if (Utils.trim(_local_2.goalsTxt) == "")
            {
                _local_2.goalsTxt = "include default";
            }
            else
            {
                _local_2.goalsTxt = _local_2.goalsTxt.replace(new RegExp(";", "g"), ":");
            };
            MainScreen.getCityFromCastleId(_arg_1).cityManager._readGoals(_local_2.goalsTxt);
            this.queueJobs.doCityTabLabel(_arg_1);
        }

        private function set colonyData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1197740996colonyData;
            if (_local_2 !== _arg_1)
            {
                this._1197740996colonyData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyData", _local_2, _arg_1));
            };
        }

        public function set _gears(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1476969531_gears;
            if (_local_2 !== _arg_1)
            {
                this._1476969531_gears = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_gears", _local_2, _arg_1));
            };
        }

        private function _CityPanel_ClassFactory9_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory9 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory9", this._CityPanel_ClassFactory9);
            return (_local_1);
        }

        internal function _onFireHeroBtn(_arg_1:int):void
        {
            var _local_2:HeroBean = this.city.findHeroById(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            if (((((_local_2.level >= 100) || (((_local_2.management - _local_2.level) + _local_2.remainPoint) > 65)) || (((_local_2.power - _local_2.level) + _local_2.remainPoint) > 65)) || (((_local_2.stratagem - _local_2.level) + _local_2.remainPoint) > 65)))
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((((((((("Are you sure you want to fire this hero?\n" + _local_2.name) + "(") + _local_2.level) + ") ") + _local_2.management) + "/") + _local_2.power) + "/") + _local_2.stratagem), this.onConfirmFireHero, "Yes", "No", [_arg_1]));
            }
            else
            {
                this.onConfirmFireHero(true, _arg_1);
            };
        }

        override public function initialize():void
        {
            var target:CityPanel;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._CityPanel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanelWatcherSetupUtil");
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
        public function get _showFriendlies():CheckBox
        {
            return (this._1321633669_showFriendlies);
        }

        private function _CityPanel_DataGridColumn10_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Distance";
            _local_1.dataField = "col4";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function ___CityPanel_Button5_click(_arg_1:MouseEvent):void
        {
            this.onSaveGoals(this.castleId);
        }

        private function set innHeroData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1649235507innHeroData;
            if (_local_2 !== _arg_1)
            {
                this._1649235507innHeroData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "innHeroData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn68_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Available";
            _local_1.dataField = "col2";
            _local_1.width = 0.25;
            return (_local_1);
        }

        public function set _innheroes(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1942092334_innheroes;
            if (_local_2 !== _arg_1)
            {
                this._1942092334_innheroes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_innheroes", _local_2, _arg_1));
            };
        }

        private function getGrieveColor(_arg_1:int):String
        {
            return ((_arg_1 == 0) ? "0x00DA00" : ((_arg_1 >= 75) ? "0xEC0000" : "0xDBDB00"));
        }

        private function _CityPanel_DataGridColumn56_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "B/Pos";
            _local_1.dataField = "col0";
            _local_1.width = 0.1;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get valleyData():ArrayCollection
        {
            return (this._1626662999valleyData);
        }

        internal function _onGearUpgradeBtn(_arg_1:int):void
        {
            this.city.cityManager.logMsg(((("Upgrade gear: " + GearType.toNameString(_arg_1)) + " to level ") + (this.city.cityManager.getGearLevel(_arg_1) + 1)));
            ActionFactory.getInstance().getEquipmenttechCommands().research(this.city.castleId, _arg_1, this.onGearResearchResponse);
            Utils.callLater(2500, this.city.cityManager._populate_G_Tab, [this.gearsData]);
        }

        private function _CityPanel_DataGridColumn21_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Stats";
            _local_1.dataField = "col4";
            _local_1.width = 0.16;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn44_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Army";
            _local_1.dataField = "col1";
            _local_1.width = 100;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Coord";
            _local_1.dataField = "col1";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn33_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Building";
            _local_1.dataField = "col1";
            _local_1.width = 0.3;
            return (_local_1);
        }

        private function set tradesData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1892696025tradesData;
            if (_local_2 !== _arg_1)
            {
                this._1892696025tradesData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradesData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_DataGridColumn67_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Fortification";
            _local_1.dataField = "col1";
            _local_1.width = 0.25;
            return (_local_1);
        }

        public function _onViewArmyBtn(_arg_1:int, _arg_2:Object):void
        {
            var _local_3:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ARMY_DETAILS_WIN);
            _local_3.args = [_arg_1, _arg_2.col5, _arg_2.col6, this.onUseArmyItem];
            dispatchEvent(_local_3);
        }

        [Bindable(event="propertyChange")]
        private function get colonyData():ArrayCollection
        {
            return (this._1197740996colonyData);
        }

        [Bindable(event="propertyChange")]
        public function get _gears():Canvas
        {
            return (this._1476969531_gears);
        }

        private function set researchData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._16113637researchData;
            if (_local_2 !== _arg_1)
            {
                this._16113637researchData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "researchData", _local_2, _arg_1));
            };
        }

        private function _CityPanel_ClassFactory8_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CityPanel_ClassFactory8 = _local_1;
            BindingManager.executeBindings(this, "_CityPanel_ClassFactory8", this._CityPanel_ClassFactory8);
            return (_local_1);
        }

        public function ___showEnemiesC_change(_arg_1:Event):void
        {
            this.refresh_E_Tab();
        }

        private function _CityPanel_DataGridColumn55_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Reinf.";
            _local_1.dataField = "col7";
            _local_1.width = 0.1;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn78_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Recall";
            _local_1.width = 65;
            _local_1.itemRenderer = this._CityPanel_ClassFactory11_i();
            return (_local_1);
        }

        public function ___CityPanel_Button13_click(_arg_1:MouseEvent):void
        {
            this.onSaveScript(this.castleId);
        }

        private function _CityPanel_DataGridColumn32_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Fire";
            _local_1.width = 48;
            _local_1.itemRenderer = this._CityPanel_ClassFactory6_i();
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get tradesData():ArrayCollection
        {
            return (this._1892696025tradesData);
        }

        public function set _goalsTxt(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1820295151_goalsTxt;
            if (_local_2 !== _arg_1)
            {
                this._1820295151_goalsTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_goalsTxt", _local_2, _arg_1));
            };
        }

        public function set _alltasks(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1907625964_alltasks;
            if (_local_2 !== _arg_1)
            {
                this._1907625964_alltasks = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_alltasks", _local_2, _arg_1));
            };
        }

        public function _onRecallSelfArmyBtn(_arg_1:int):void
        {
            if (_arg_1 == -1)
            {
                return;
            };
            this.city.cityManager.logMsg(("Recall self army with armyId: " + _arg_1));
            ActionFactory.getInstance().getArmyCommands().callBackArmy(this.city.castleId, _arg_1);
            Utils.callLater(2500, this.city.cityManager._populate_A_Tab, [this.armyData]);
        }

        [Bindable(event="propertyChange")]
        private function get researchData():ArrayCollection
        {
            return (this._16113637researchData);
        }

        private function onSaveScript(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:SharedObject = SharedObject.getLocal(("citytab" + _arg_1));
            _local_3.data.now = this.queueJobs.getCityPanelBean(_arg_1).scriptTxt;
            var _local_4:String = _local_3.flush();
            if (_local_4 != "flushed")
            {
                this.city.cityManager.logMsg((("SAVING PROBLEM: " + _local_4) + ", you may need to adjust flash settings to increase local storage"));
            }
            else
            {
                if (!_arg_2)
                {
                    this.city.cityManager.logMsg("Script has been saved successfully");
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _alltasks():ViewStack
        {
            return (this._1907625964_alltasks);
        }

        private function _CityPanel_DataGridColumn20_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Lvl";
            _local_1.dataField = "col3";
            _local_1.width = 0.08;
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn43_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "";
            _local_1.width = 57;
            _local_1.itemRenderer = this._CityPanel_ClassFactory8_i();
            return (_local_1);
        }

        private function _CityPanel_DataGridColumn66_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Q10";
            _local_1.dataField = "col10";
            _local_1.width = 0.1;
            return (_local_1);
        }

        private function getTaxColor(_arg_1:int):String
        {
            return ((_arg_1 == 0) ? "0x00DA00" : ((_arg_1 >= 75) ? "0xEC0000" : "0xDBDB00"));
        }

        [Bindable(event="propertyChange")]
        public function get _goalsTxt():TextArea
        {
            return (this._1820295151_goalsTxt);
        }

        private function onChangeNameResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ("Error renaming castle: " + _arg_1.errorMsg)));
            }
            else
            {
                this._castleBean.name = this._inputNewCastleName.text;
                this._inputNewCastleName.text = "";
                this._inputNewCastleName.visible = false;
                this.queueJobs.doCityTabLabel(this._castleBean.id);
            };
        }

        private function _CityPanel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (!(this._castleBean == null));
            _local_1 = this._cityPanelBean.goalsTxt;
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = (!(this._castleBean == null));
            _local_1 = this._cityPanelBean.scriptTxt;
            _local_1 = (!(this._cityPanelBean.scriptIsRunning));
            _local_1 = this._cityPanelBean.scriptIsRunning;
            _local_1 = this._castleBean.name.replace(new RegExp(String.fromCharCode(65279), "g"), "");
            _local_1 = (this._castleBean.powerlevel == 4);
            _local_1 = (this._castleBean.powerlevel == 4);
            _local_1 = (this._inputNewCastleName.text.length > 0);
            _local_1 = this._castleBean.resource.support;
            _local_1 = this.getLoyColor(this._castleBean.resource.support);
            _local_1 = this._castleBean.resource.complaint;
            _local_1 = this.getGrieveColor(this._castleBean.resource.complaint);
            _local_1 = (this._castleBean.resource.texRate + "%");
            _local_1 = this.getTaxColor(this._castleBean.resource.texRate);
            _local_1 = ((Map.fieldIdToCoordString(this._castleBean.fieldId) + "  ") + Map.getRegionName(this._castleBean.fieldId));
            _local_1 = Utils.formatNum(this._castleBean.resource.curPopulation);
            _local_1 = Utils.formatNum((this._castleBean.resource.curPopulation - this._castleBean.resource.workPeople));
            _local_1 = this.getIdlePopColor(this._castleBean.resource.curPopulation, this._castleBean.resource.workPeople);
            _local_1 = (!(this._castleBean == null));
            _local_1 = this.resourceData;
            _local_1 = this.valleyData;
            _local_1 = CityPanel_inlineComponent1;
            _local_1 = this.colonyData;
            _local_1 = CityPanel_inlineComponent0;
            _local_1 = this.innHeroData;
            _local_1 = CityPanel_inlineComponent5;
            _local_1 = this.heroData;
            _local_1 = CityPanel_inlineComponent2_3;
            _local_1 = CityPanel_inlineComponent2_1;
            _local_1 = CityPanel_inlineComponent2_2;
            _local_1 = this.buildingData;
            _local_1 = this.researchData;
            _local_1 = this.gearsData;
            _local_1 = CityPanel_inlineComponent7;
            _local_1 = this.armyData;
            _local_1 = CityPanel_inlineComponent6;
            _local_1 = CityPanel_inlineComponent3;
            _local_1 = this.troopsData;
            _local_1 = this.troopQueueData;
            _local_1 = this.fortificationsData;
            _local_1 = this.tradesData;
            _local_1 = this.externalTroopData;
            _local_1 = CityPanel_inlineComponent6;
            _local_1 = CityPanel_inlineComponent4;
        }


    }
}//package autoevony.gui

