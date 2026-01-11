// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyInfoWin

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.containers.HBox;
    import com.evony.common.beans.ColonyBean;
    import mx.controls.ToggleButtonBar;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Image;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import mx.events.ItemClickEvent;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import mx.events.ListEvent;
    import com.evony.Lang;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.common.beans.TroopStrBean;
    import flash.events.Event;
    import com.evony.Context;
    import view.module.playerInfo.UnlockSecurityCode;
    import view.module.playerInfo.ApplySecurityCode;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
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
    import view.module.playerInfo.*;
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

    public class ColonyInfoWin extends Canvas implements IBindingClient 
    {

        public static var instance:ColonyInfoWin = new (ColonyInfoWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2066322828_totalPage:int;
        private var _1962855648lordName:Label;
        private var _884325027allHerosView:ColonieAllHeros;
        public var _ColonyInfoWin_DataGrid1:DataGrid;
        private var _1421682026cityName:Label;
        private var _70341312levyBtn:HBox;
        private var _1197684682colonyBean:ColonyBean;
        private var _11548545buttonBar:ToggleButtonBar;
        private var _113836232castleBean:CastleBean;
        private var selectType:String = "";
        private var _810819664_curPage:int;
        private var levyType:String;
        private var isLogin:Boolean = false;
        private var endStr:String;
        private var _404873196allResourceView:ColonyResourceProduce;
        public var _ColonyInfoWin_Label11:Label;
        private var _1825239910currCastleBean:CastleBean;
        public var _ColonyInfoWin_Button3:Button;
        public var _ColonyInfoWin_Button4:Button;
        public var _ColonyInfoWin_Button5:Button;
        public var _ColonyInfoWin_Button6:Button;
        public var _ColonyInfoWin_Button7:Button;
        private var _816632312viewDg:Canvas;
        private var _856621278ArmyInColonieView:ArmyInColonie;
        private var _1712441462allTroopView:ColonyAllArmy;
        private var _94845685coord:Label;
        private var _1276224445prestige:Label;
        private var _1211586662abandBtn:Boolean = false;
        private var _1606140770allianceName:Label;
        private var _806798121colonyViewstack:ViewStack;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":650,
                    "height":500,
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
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"Colony Status",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "events":{"creationComplete":"___ColonyInfoWin_Image1_creationComplete"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":39,
                                "y":49,
                                "source":"images/EmbedImages/field/colonizationCity.png",
                                "width":98,
                                "height":98
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "150";
                            this.top = "50";
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
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"City: ",
                                                        "styleName":"PropertyName1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"cityName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"coord",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
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
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Lord: ",
                                                        "styleName":"PropertyName1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"lordName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
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
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Prestige: ",
                                                        "styleName":"PropertyName1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"prestige",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
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
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Alliance: ",
                                                        "styleName":"PropertyName1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"allianceName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                            this.right = "40";
                            this.verticalAlign = "middle";
                            this.top = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":174,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ColonyInfoWin_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ColonyInfoWin_Label11",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14f"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ColonyInfoWin_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"next"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_ColonyInfoWin_Button3",
                        "events":{"click":"___ColonyInfoWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.top = "90";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"y125"});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                            this.horizontalAlign = "left";
                            this.verticalAlign = "bottom";
                            this.left = "34";
                            this.right = "420";
                            this.top = "135";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ToggleButtonBar,
                                    "id":"buttonBar",
                                    "events":{"itemClick":"__buttonBar_itemClick"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":29,
                                            "percentWidth":100,
                                            "dataProvider":["Colonial  status", "Suppression setting"]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"colonyViewstack",
                        "stylesFactory":function ():void
                        {
                            this.left = "200";
                            this.right = "30";
                            this.bottom = "10";
                            this.top = "165";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ColonyResourceProduce,
                                    "id":"allResourceView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentHeight":100,
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonyAllArmy,
                                    "id":"allTroopView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentHeight":100,
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ColonieAllHeros,
                                    "id":"allHerosView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentHeight":100,
                                            "percentWidth":100
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ArmyInColonie,
                        "id":"ArmyInColonieView",
                        "stylesFactory":function ():void
                        {
                            this.left = "34";
                            this.top = "165";
                            this.bottom = "10";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"visible":false});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"levyBtn",
                        "stylesFactory":function ():void
                        {
                            this.left = "32";
                            this.right = "32";
                            this.bottom = "15";
                            this.horizontalAlign = "center";
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyInfoWin_Button4",
                                    "events":{"click":"___ColonyInfoWin_Button4_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyInfoWin_Button5",
                                    "events":{"click":"___ColonyInfoWin_Button5_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyInfoWin_Button6",
                                    "events":{"click":"___ColonyInfoWin_Button6_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyInfoWin_Button7",
                                    "events":{"click":"___ColonyInfoWin_Button7_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"viewDg",
                        "stylesFactory":function ():void
                        {
                            this.top = "165";
                            this.bottom = "50";
                            this.left = "34";
                            this.right = "460";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"tabwk",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "1";
                                                    this.right = "1";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tabnk",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_ColonyInfoWin_DataGrid1",
                                                            "events":{"itemClick":"___ColonyInfoWin_DataGrid1_itemClick"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "none";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "rowHeight":35.5,
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "styleName":"style2",
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "columns":[_ColonyInfoWin_DataGridColumn1_c()]
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
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ColonyInfoWin_Button8_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });
        private var _1443166807dataArr:Array = ["resource", "troops", "hero"];
        private var _1978297095colonyArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyInfoWin()
        {
            mx_internal::_document = this;
            this.width = 650;
            this.height = 500;
            this.addEventListener("render", ___ColonyInfoWin_Canvas1_render);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyInfoWin._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function getInstance():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        [Bindable(event="propertyChange")]
        public function get ArmyInColonieView():ArmyInColonie
        {
            return (this._856621278ArmyInColonieView);
        }

        [Bindable(event="propertyChange")]
        private function get colonyArr():ArrayCollection
        {
            return (this._1978297095colonyArr);
        }

        [Bindable(event="propertyChange")]
        public function get viewDg():Canvas
        {
            return (this._816632312viewDg);
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

        private function set colonyArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1978297095colonyArr;
            if (_local_2 !== _arg_1)
            {
                this._1978297095colonyArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyArr", _local_2, _arg_1));
            };
        }

        private function sowDiscord():void
        {
            selectType = "hero";
            ActionFactory.getInstance().getColonyCommands().sowDiscord(castleBean.id, colonyBean.castleId, sowDiscordResponse);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.selectedItem(_arg_1);
        }

        private function init():void
        {
            if (!isLogin)
            {
                if (colonyBean.isCanOverview)
                {
                    getColonyInfo();
                };
                isLogin = true;
                showResourcePage();
                buttonBar.selectedIndex = 0;
            };
        }

        [Bindable(event="propertyChange")]
        public function get lordName():Label
        {
            return (this._1962855648lordName);
        }

        public function ___ColonyInfoWin_Button4_click(_arg_1:MouseEvent):void
        {
            levyPopulation();
        }

        public function set allResourceView(_arg_1:ColonyResourceProduce):void
        {
            var _local_2:Object = this._404873196allResourceView;
            if (_local_2 !== _arg_1)
            {
                this._404873196allResourceView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allResourceView", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyViewstack():ViewStack
        {
            return (this._806798121colonyViewstack);
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = _curPage;
            this._curPage = (this._curPage + _arg_1);
            if (((this._curPage >= 1) && (this._curPage <= this._totalPage)))
            {
                this.getColonyInfoFromServer();
            }
            else
            {
                this._curPage = _local_2;
            };
        }

        public function ___ColonyInfoWin_Button8_click(_arg_1:MouseEvent):void
        {
            close();
        }

        public function set viewDg(_arg_1:Canvas):void
        {
            var _local_2:Object = this._816632312viewDg;
            if (_local_2 !== _arg_1)
            {
                this._816632312viewDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewDg", _local_2, _arg_1));
            };
        }

        public function set lordName(_arg_1:Label):void
        {
            var _local_2:Object = this._1962855648lordName;
            if (_local_2 !== _arg_1)
            {
                this._1962855648lordName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lordName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allResourceView():ColonyResourceProduce
        {
            return (this._404873196allResourceView);
        }

        [Bindable(event="propertyChange")]
        public function get prestige():Label
        {
            return (this._1276224445prestige);
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

        private function set currCastleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1825239910currCastleBean;
            if (_local_2 !== _arg_1)
            {
                this._1825239910currCastleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currCastleBean", _local_2, _arg_1));
            };
        }

        private function selectedItem(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    showResourcePage();
                    return;
                case 1:
                    showArmyPage();
                    return;
            };
        }

        public function set colonyViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._806798121colonyViewstack;
            if (_local_2 !== _arg_1)
            {
                this._806798121colonyViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyViewstack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataArr():Array
        {
            return (this._1443166807dataArr);
        }

        private function showResourcePage():void
        {
            levyBtn.visible = true;
            viewDg.visible = true;
            colonyViewstack.visible = true;
            this.ArmyInColonieView.visible = false;
            this.colonyViewstack.selectedChild = this.allResourceView;
        }

        public function ___ColonyInfoWin_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        private function set _curPage(_arg_1:int):void
        {
            var _local_2:Object = this._810819664_curPage;
            if (_local_2 !== _arg_1)
            {
                this._810819664_curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_curPage", _local_2, _arg_1));
            };
        }

        public function ___ColonyInfoWin_Button5_click(_arg_1:MouseEvent):void
        {
            levyArmy();
        }

        [Bindable(event="propertyChange")]
        private function get abandBtn():Boolean
        {
            return (this._1211586662abandBtn);
        }

        private function levyPopulation():void
        {
            selectType = "resource";
            levyType = "Population redeployed!";
            ActionFactory.getInstance().getColonyCommands().levyPopulation(castleBean.id, this.colonyBean.castleId, levyResponse);
        }

        private function levyResponse(_arg_1:ColonyLevyeRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.colonyBean.isCanLevy = false;
                switch (selectType)
                {
                    case "resource":
                        AlertWin.show(((String(_arg_1.amount) + " amount of ") + levyType));
                        break;
                    case "army":
                        AlertWin.show(((((levyType + String(_arg_1.amount)) + " ") + _arg_1.armyType) + endStr));
                        break;
                };
                getColonyInfo();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():Label
        {
            return (this._1606140770allianceName);
        }

        public function abandon():void
        {
            ActionFactory.getInstance().getColonyCommands().abandonColony(castleBean.id, colonyBean.castleId, abandonResponse);
        }

        public function ___ColonyInfoWin_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function sowDiscordResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.colonyBean.isCanLevy = false;
                AlertWin.show("You have cast Sow Discord on the city and successfully decreased all heroes' loyalty by some amount in it.");
                getColonyInfo();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        private function levyFood():void
        {
            selectType = "resource";
            levyType = "Food Levied!";
            ActionFactory.getInstance().getColonyCommands().levyFood(castleBean.id, this.colonyBean.castleId, levyResponse);
        }

        [Bindable(event="propertyChange")]
        private function get _totalPage():int
        {
            return (this._2066322828_totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get allHerosView():ColonieAllHeros
        {
            return (this._884325027allHerosView);
        }

        public function set levyBtn(_arg_1:HBox):void
        {
            var _local_2:Object = this._70341312levyBtn;
            if (_local_2 !== _arg_1)
            {
                this._70341312levyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levyBtn", _local_2, _arg_1));
            };
        }

        private function _ColonyInfoWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Select View";
            _local_1.itemRenderer = _ColonyInfoWin_ClassFactory1_c();
            return (_local_1);
        }

        public function set prestige(_arg_1:Label):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allTroopView():ColonyAllArmy
        {
            return (this._1712441462allTroopView);
        }

        override public function initialize():void
        {
            var target:ColonyInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyInfoWinWatcherSetupUtil");
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

        private function _ColonyInfoWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = ColonyInfoWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get currCastleBean():CastleBean
        {
            return (this._1825239910currCastleBean);
        }

        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cityName():Label
        {
            return (this._1421682026cityName);
        }

        public function ___ColonyInfoWin_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        private function clickHandler(_arg_1:ListEvent):void
        {
            switch (_arg_1.rowIndex)
            {
                case 0:
                    this.colonyViewstack.selectedChild = this.allResourceView;
                    return;
                case 1:
                    this.colonyViewstack.selectedChild = this.allTroopView;
                    return;
                case 2:
                    this.colonyViewstack.selectedChild = this.allHerosView;
                    return;
            };
        }

        private function _ColonyInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.cityName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityName.text = _arg_1;
            }, "cityName.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + this.colonyBean.position) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                coord.text = _arg_1;
            }, "coord.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.lordName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lordName.text = _arg_1;
            }, "lordName.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                prestige.text = _arg_1;
            }, "prestige.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.allianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceName.text = _arg_1;
            }, "allianceName.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._curPage + "/") + this._totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Label11.text = _arg_1;
            }, "_ColonyInfoWin_Label11.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("放弃");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button3.label = _arg_1;
            }, "_ColonyInfoWin_Button3.label");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (abandBtn);
            }, function (_arg_1:Boolean):void
            {
                _ColonyInfoWin_Button3.enabled = _arg_1;
            }, "_ColonyInfoWin_Button3.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():CastleResourceBean
            {
                return (this.currCastleBean.resource);
            }, function (_arg_1:CastleResourceBean):void
            {
                allResourceView.setResourceBean = _arg_1;
            }, "allResourceView.setResourceBean");
            result[8] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.castleBean);
            }, function (_arg_1:CastleBean):void
            {
                allResourceView.setCastleBean = _arg_1;
            }, "allResourceView.setCastleBean");
            result[9] = binding;
            binding = new Binding(this, function ():ColonyBean
            {
                return (this.colonyBean);
            }, function (_arg_1:ColonyBean):void
            {
                allResourceView.setColony = _arg_1;
            }, "allResourceView.setColony");
            result[10] = binding;
            binding = new Binding(this, function ():TroopStrBean
            {
                return (this.currCastleBean.strTroop);
            }, function (_arg_1:TroopStrBean):void
            {
                allTroopView.setTroopStrBean = _arg_1;
            }, "allTroopView.setTroopStrBean");
            result[11] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.castleBean);
            }, function (_arg_1:CastleBean):void
            {
                allTroopView.setCastleBean = _arg_1;
            }, "allTroopView.setCastleBean");
            result[12] = binding;
            binding = new Binding(this, function ():ColonyBean
            {
                return (this.colonyBean);
            }, function (_arg_1:ColonyBean):void
            {
                allTroopView.setColony = _arg_1;
            }, "allTroopView.setColony");
            result[13] = binding;
            binding = new Binding(this, function ():ArrayCollection
            {
                return (this.currCastleBean.herosArray);
            }, function (_arg_1:ArrayCollection):void
            {
                allHerosView.setHeroArray = _arg_1;
            }, "allHerosView.setHeroArray");
            result[14] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.castleBean);
            }, function (_arg_1:CastleBean):void
            {
                allHerosView.setCastleBean = _arg_1;
            }, "allHerosView.setCastleBean");
            result[15] = binding;
            binding = new Binding(this, function ():ColonyBean
            {
                return (this.colonyBean);
            }, function (_arg_1:ColonyBean):void
            {
                allHerosView.setColony = _arg_1;
            }, "allHerosView.setColony");
            result[16] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.castleBean);
            }, function (_arg_1:CastleBean):void
            {
                ArmyInColonieView.setCastleBean = _arg_1;
            }, "ArmyInColonieView.setCastleBean");
            result[17] = binding;
            binding = new Binding(this, function ():ColonyBean
            {
                return (this.colonyBean);
            }, function (_arg_1:ColonyBean):void
            {
                ArmyInColonieView.showArmyInColony = _arg_1;
            }, "ArmyInColonieView.showArmyInColony");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("抽丁");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button4.label = _arg_1;
            }, "_ColonyInfoWin_Button4.label");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("抽丁的描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button4.toolTip = _arg_1;
            }, "_ColonyInfoWin_Button4.toolTip");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (colonyBean.isCanLevy);
            }, function (_arg_1:Boolean):void
            {
                _ColonyInfoWin_Button4.enabled = _arg_1;
            }, "_ColonyInfoWin_Button4.enabled");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button5.label = _arg_1;
            }, "_ColonyInfoWin_Button5.label");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征兵的描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button5.toolTip = _arg_1;
            }, "_ColonyInfoWin_Button5.toolTip");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (colonyBean.isCanLevy);
            }, function (_arg_1:Boolean):void
            {
                _ColonyInfoWin_Button5.enabled = _arg_1;
            }, "_ColonyInfoWin_Button5.enabled");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("裁军");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button6.label = _arg_1;
            }, "_ColonyInfoWin_Button6.label");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("裁军的描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button6.toolTip = _arg_1;
            }, "_ColonyInfoWin_Button6.toolTip");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (colonyBean.isCanLevy);
            }, function (_arg_1:Boolean):void
            {
                _ColonyInfoWin_Button6.enabled = _arg_1;
            }, "_ColonyInfoWin_Button6.enabled");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("挑拨");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button7.label = _arg_1;
            }, "_ColonyInfoWin_Button7.label");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("挑拨的描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyInfoWin_Button7.toolTip = _arg_1;
            }, "_ColonyInfoWin_Button7.toolTip");
            result[29] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (colonyBean.isCanLevy);
            }, function (_arg_1:Boolean):void
            {
                _ColonyInfoWin_Button7.enabled = _arg_1;
            }, "_ColonyInfoWin_Button7.enabled");
            result[30] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.dataArr);
            }, function (_arg_1:Object):void
            {
                _ColonyInfoWin_DataGrid1.dataProvider = _arg_1;
            }, "_ColonyInfoWin_DataGrid1.dataProvider");
            result[31] = binding;
            return (result);
        }

        public function ___ColonyInfoWin_Canvas1_render(_arg_1:Event):void
        {
            init();
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

        private function reduceArmaments():void
        {
            selectType = "army";
            levyType = "You have disarmed ";
            endStr = " in the city.";
            ActionFactory.getInstance().getColonyCommands().reduceArmaments(castleBean.id, colonyBean.castleId, levyResponse);
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        [Bindable(event="propertyChange")]
        private function get _curPage():int
        {
            return (this._810819664_curPage);
        }

        public function ___ColonyInfoWin_Button6_click(_arg_1:MouseEvent):void
        {
            reduceArmaments();
        }

        private function set dataArr(_arg_1:Array):void
        {
            var _local_2:Object = this._1443166807dataArr;
            if (_local_2 !== _arg_1)
            {
                this._1443166807dataArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataArr", _local_2, _arg_1));
            };
        }

        public function set ArmyInColonieView(_arg_1:ArmyInColonie):void
        {
            var _local_2:Object = this._856621278ArmyInColonieView;
            if (_local_2 !== _arg_1)
            {
                this._856621278ArmyInColonieView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ArmyInColonieView", _local_2, _arg_1));
            };
        }

        private function levyArmy():void
        {
            selectType = "army";
            levyType = "You have drafted ";
            endStr = " from the city.";
            ActionFactory.getInstance().getColonyCommands().levyArmy(castleBean.id, colonyBean.castleId, levyResponse);
        }

        public function set allHerosView(_arg_1:ColonieAllHeros):void
        {
            var _local_2:Object = this._884325027allHerosView;
            if (_local_2 !== _arg_1)
            {
                this._884325027allHerosView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allHerosView", _local_2, _arg_1));
            };
        }

        private function _ColonyInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.colonyBean.cityName;
            _local_1 = (("(" + this.colonyBean.position) + ")");
            _local_1 = this.colonyBean.lordName;
            _local_1 = this.colonyBean.prestige;
            _local_1 = this.colonyBean.allianceName;
            _local_1 = ((this._curPage + "/") + this._totalPage);
            _local_1 = Lang.msg("放弃");
            _local_1 = abandBtn;
            _local_1 = this.currCastleBean.resource;
            _local_1 = this.castleBean;
            _local_1 = this.colonyBean;
            _local_1 = this.currCastleBean.strTroop;
            _local_1 = this.castleBean;
            _local_1 = this.colonyBean;
            _local_1 = this.currCastleBean.herosArray;
            _local_1 = this.castleBean;
            _local_1 = this.colonyBean;
            _local_1 = this.castleBean;
            _local_1 = this.colonyBean;
            _local_1 = Lang.msg("抽丁");
            _local_1 = Lang.msg("抽丁的描述");
            _local_1 = colonyBean.isCanLevy;
            _local_1 = Lang.msg("征兵");
            _local_1 = Lang.msg("征兵的描述");
            _local_1 = colonyBean.isCanLevy;
            _local_1 = Lang.msg("裁军");
            _local_1 = Lang.msg("裁军的描述");
            _local_1 = colonyBean.isCanLevy;
            _local_1 = Lang.msg("挑拨");
            _local_1 = Lang.msg("挑拨的描述");
            _local_1 = colonyBean.isCanLevy;
            _local_1 = this.dataArr;
        }

        [Bindable(event="propertyChange")]
        public function get levyBtn():HBox
        {
            return (this._70341312levyBtn);
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        public function set allianceName(_arg_1:Label):void
        {
            var _local_2:Object = this._1606140770allianceName;
            if (_local_2 !== _arg_1)
            {
                this._1606140770allianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _local_2, _arg_1));
            };
        }

        private function set abandBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1211586662abandBtn;
            if (_local_2 !== _arg_1)
            {
                this._1211586662abandBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "abandBtn", _local_2, _arg_1));
            };
        }

        private function abandonResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                abandBtn = false;
                AlertWin.show("Abandon successfully!");
            }
            else
            {
                if (_arg_1.ok == -200)
                {
                    if (Context.getInstance().bLoginSecurityCode)
                    {
                        UnlockSecurityCode.show(1);
                    }
                    else
                    {
                        ApplySecurityCode.show(1);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg, null);
                };
            };
        }

        private function setColonyInfo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                currCastleBean = null;
                currCastleBean = _arg_1.castleBean;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }

        public function ___ColonyInfoWin_Button7_click(_arg_1:MouseEvent):void
        {
            sowDiscord();
        }

        public function ___ColonyInfoWin_Button3_click(_arg_1:MouseEvent):void
        {
            abandon();
        }

        private function set _totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._2066322828_totalPage;
            if (_local_2 !== _arg_1)
            {
                this._2066322828_totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_totalPage", _local_2, _arg_1));
            };
        }

        private function showArmyPage():void
        {
            levyBtn.visible = false;
            viewDg.visible = false;
            colonyViewstack.visible = false;
            this.ArmyInColonieView.visible = true;
            this.ArmyInColonieView.init();
        }

        public function set coord(_arg_1:Label):void
        {
            var _local_2:Object = this._94845685coord;
            if (_local_2 !== _arg_1)
            {
                this._94845685coord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "coord", _local_2, _arg_1));
            };
        }

        private function getColonyInfoFromServer():void
        {
            setColony(this.colonyArr[(_curPage - 1)].cbean, this.castleBean, _totalPage, _curPage, this.colonyArr);
            init();
        }

        public function ___ColonyInfoWin_DataGrid1_itemClick(_arg_1:ListEvent):void
        {
            clickHandler(_arg_1);
        }

        public function set allTroopView(_arg_1:ColonyAllArmy):void
        {
            var _local_2:Object = this._1712441462allTroopView;
            if (_local_2 !== _arg_1)
            {
                this._1712441462allTroopView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allTroopView", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get coord():Label
        {
            return (this._94845685coord);
        }

        private function getColonyInfo():void
        {
            ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(castleBean.id, this.colonyBean.castleId, setColonyInfo);
        }

        public function setColony(_arg_1:ColonyBean, _arg_2:CastleBean, _arg_3:int, _arg_4:int, _arg_5:ArrayCollection):void
        {
            colonyBean = _arg_1;
            castleBean = _arg_2;
            this._curPage = _arg_4;
            this._totalPage = _arg_3;
            this.colonyArr = _arg_5;
            this.isLogin = false;
            if (colonyBean.status == ColonyConstants.COLONY_STATUS_ABANDON)
            {
                abandBtn = false;
            }
            else
            {
                abandBtn = true;
            };
        }

        private function levyTaxes():void
        {
            selectType = "resource";
            levyType = "Gold imposed!";
            ActionFactory.getInstance().getColonyCommands().levyTaxes(castleBean.id, this.colonyBean.castleId, levyResponse);
        }


    }
}//package view.castleList

