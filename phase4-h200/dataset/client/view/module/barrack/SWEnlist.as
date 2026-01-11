// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.barrack.SWEnlist

package view.module.barrack
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.CheckBox;
    import com.evony.common.beans.TroopProduceListBean;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.Image;
    import com.evony.util.ProduceBuildingResourceData;
    import mx.controls.Text;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.eum.TroopEum;
    import view.ui.NumberRegulate;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import view.ui.MyHRule;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import mx.core.Application;
    import flash.display.DisplayObject;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.binding.BindingManager;
    import flash.events.Event;
    import com.evony.common.constants.TFConstants;
    import com.evony.Context;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.eum.TroopEumDefine;
    import com.evony.factory.ImageManager;
    import com.evony.util.UIUtil;
    import com.evony.common.beans.TroopBean;
    import mx.binding.utils.BindingUtils;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.ImageSmooth;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.events.CommonProduceEvent;
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

    public class SWEnlist extends Canvas implements IBindingClient 
    {

        private static var instance:SWEnlist;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _SWEnlist_Label1:Label;
        public var _SWEnlist_Label2:Label;
        public var _SWEnlist_Label4:Label;
        public var _SWEnlist_Label6:Label;
        public var _SWEnlist_Label7:Label;
        public var _SWEnlist_Label8:Label;
        public var _SWEnlist_Label9:Label;
        public var _SWEnlist_Label3:Label;
        private var _1122029toIdleBtn:CheckBox;
        public var _SWEnlist_Label5:Label;
        private var troopBean:TroopProduceListBean;
        private var _1537057465isShareBtn:CheckBox;
        public var _SWEnlist_Label10:Label;
        public var _SWEnlist_Label11:Label;
        public var _SWEnlist_Label12:Label;
        public var _SWEnlist_Label13:Label;
        public var _SWEnlist_Label14:Label;
        public var _SWEnlist_Label15:Label;
        public var _SWEnlist_Label16:Label;
        public var _SWEnlist_Label17:Label;
        public var _SWEnlist_Label18:Label;
        public var _SWEnlist_Label19:Label;
        public var _SWEnlist_Label20:Label;
        public var _SWEnlist_Label21:Label;
        public var _SWEnlist_Label22:Label;
        public var _SWEnlist_Label23:Label;
        public var _SWEnlist_Label24:Label;
        private var _1482921390condiction_DG:DataGrid;
        private var conditionTime:Number;
        public var _SWEnlist_Button1:Button;
        public var _SWEnlist_Image1:Image;
        private var _737800520curAmount:int;
        private var _1185090783imgSrc:Object;
        private var produceBuildingResourceData:ProduceBuildingResourceData;
        public var _SWEnlist_Text1:Text;
        public var _SWEnlist_DataGridColumn1:DataGridColumn;
        public var _SWEnlist_DataGridColumn2:DataGridColumn;
        public var _SWEnlist_DataGridColumn3:DataGridColumn;
        private var _1682493707troopEum:TroopEum;
        private var _3525ns:NumberRegulate;
        private var _1752545926produceNum:int = 1;
        private var _426538114produceMaxNum:int;
        private var _1418324210produceAllTime:String;
        private var changeWatcher:ChangeWatcher;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":480,
                    "height":560,
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
                        "type":Image,
                        "id":"_SWEnlist_Image1",
                        "events":{"complete":"___SWEnlist_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.left = "30";
                            this.top = "53";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":64,
                                "height":64
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_SWEnlist_Button1",
                        "events":{"click":"___SWEnlist_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "27";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"condiction_DG",
                        "stylesFactory":function ():void
                        {
                            this.top = "217";
                            this.left = "30";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "styleName":"style2",
                                "horizontalScrollPolicy":"off",
                                "rowCount":4,
                                "rowHeight":30,
                                "height":147,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_SWEnlist_DataGridColumn1_i(), _SWEnlist_DataGridColumn2_i(), _SWEnlist_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "122";
                            this.left = "30";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":90,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":26,
                                            "width":359,
                                            "height":2
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":52,
                                            "width":359,
                                            "height":2
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
                                            "width":80,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":80,
                                            "y":8,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":110,
                                            "y":8,
                                            "width":100,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":210,
                                            "y":8,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":240,
                                            "y":8,
                                            "width":100,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":340,
                                            "y":8,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":33,
                                            "width":80,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label8",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":80,
                                            "y":33,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":110,
                                            "y":33,
                                            "width":100,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label10",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":210,
                                            "y":33,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label11",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":240,
                                            "y":33,
                                            "width":100,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label12",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":340,
                                            "y":33,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label13",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":58,
                                            "width":80,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label14",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":80,
                                            "y":58,
                                            "width":55
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label15",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":110,
                                            "y":58,
                                            "width":100,
                                            "height":20,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label16",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":210,
                                            "y":58,
                                            "width":55
                                        });
                                    }
                                })]
                            });
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
                                    "id":"_SWEnlist_Label17",
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
                            this.left = "30";
                            this.right = "30";
                            this.bottom = "81";
                            this.top = "369";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":NumberRegulate,
                                    "id":"ns",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "295";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":10,
                                            "isProduce":true,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label18",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":10.45,
                                            "styleName":"focusColor",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label19",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":10,
                                            "styleName":"focusColor",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label20",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":45,
                                            "styleName":"focusColor",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label21",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":45,
                                            "styleName":"focusColor",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "100";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":7,
                                            "width":90,
                                            "height":30,
                                            "styleName":"canvasGroupBackGround",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_SWEnlist_Label22",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":88});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "100";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":42,
                                            "width":90,
                                            "height":30,
                                            "styleName":"canvasGroupBackGround",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_SWEnlist_Label23",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":88});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWEnlist_Label24",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.left = "295";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":46,
                                            "width":100
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "99";
                            this.right = "30";
                            this.top = "53";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":64,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_SWEnlist_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "styleName":"canvasGroupBackGround",
                                            "percentWidth":100,
                                            "selectable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"isShareBtn",
                        "events":{"change":"__isShareBtn_change"},
                        "stylesFactory":function ():void
                        {
                            this.left = "30";
                            this.bottom = "82";
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"toIdleBtn",
                        "events":{"change":"__toIdleBtn_change"},
                        "stylesFactory":function ():void
                        {
                            this.left = "30";
                            this.bottom = "57";
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SWEnlist_Button2_click"},
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
        private var _1443166814dataAry:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SWEnlist()
        {
            mx_internal::_document = this;
            this.width = 480;
            this.height = 560;
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SWEnlist._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:DisplayObject, _arg_2:TroopProduceListBean):void
        {
            if (instance == null)
            {
                instance = new (SWEnlist)();
            };
            PopUpManager.addPopUp(instance, _arg_1, true);
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
            instance.setBean(_arg_2);
            instance.produceNum = 1;
            if (instance.isShareBtn != null)
            {
                instance.isShareBtn.selected = false;
            };
            if (instance.toIdleBtn != null)
            {
                instance.toIdleBtn.selected = false;
            };
        }


        private function set produceMaxNum(_arg_1:int):void
        {
            var _local_2:Object = this._426538114produceMaxNum;
            if (_local_2 !== _arg_1)
            {
                this._426538114produceMaxNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceMaxNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get troopEum():TroopEum
        {
            return (this._1682493707troopEum);
        }

        private function set produceNum(_arg_1:int):void
        {
            var _local_2:Object = this._1752545926produceNum;
            if (_local_2 !== _arg_1)
            {
                this._1752545926produceNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceNum", _local_2, _arg_1));
            };
        }

        private function _SWEnlist_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSrc;
            _local_1 = Lang.msg("确定");
            _local_1 = this.dataAry;
            _local_1 = Lang.msg("招募条件");
            _local_1 = Lang.msg("需要数量");
            _local_1 = Lang.msg("当前数量");
            _local_1 = (Lang.msg("攻击") + ": ");
            _local_1 = this.troopEum.attack;
            _local_1 = (Lang.msg("防御") + ": ");
            _local_1 = this.troopEum.defence;
            _local_1 = (Lang.msg("射程") + ": ");
            _local_1 = this.troopEum.range;
            _local_1 = (Lang.msg("速度") + ": ");
            _local_1 = this.troopEum.speed;
            _local_1 = (Lang.msg("负重") + ": ");
            _local_1 = this.troopEum.load;
            _local_1 = (Lang.msg("生命") + ": ");
            _local_1 = this.troopEum.life;
            _local_1 = (Lang.msg("粮食") + ": ");
            _local_1 = this.troopEum.foodRequest;
            _local_1 = (Lang.msg("人口") + ": ");
            _local_1 = this.troopEum.population;
            _local_1 = this.troopEum.name;
            _local_1 = onChange;
            _local_1 = this.produceMaxNum;
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = (Lang.msg("建造数量") + ": ");
            _local_1 = (Lang.msg("最大建造") + ": ");
            _local_1 = (Lang.msg("建造时间") + ": ");
            _local_1 = this.curAmount;
            _local_1 = this.produceMaxNum;
            _local_1 = this.produceAllTime;
            _local_1 = this.troopEum.desc;
            _local_1 = Lang.msg("是否把生产平均到各军营");
            _local_1 = Lang.msg("只分配到空闲军营");
        }

        [Bindable(event="propertyChange")]
        public function get toIdleBtn():CheckBox
        {
            return (this._1122029toIdleBtn);
        }

        private function _SWEnlist_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWEnlist_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_SWEnlist_DataGridColumn1", _SWEnlist_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        private function set produceAllTime(_arg_1:String):void
        {
            var _local_2:Object = this._1418324210produceAllTime;
            if (_local_2 !== _arg_1)
            {
                this._1418324210produceAllTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceAllTime", _local_2, _arg_1));
            };
        }

        private function set troopEum(_arg_1:TroopEum):void
        {
            var _local_2:Object = this._1682493707troopEum;
            if (_local_2 !== _arg_1)
            {
                this._1682493707troopEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopEum", _local_2, _arg_1));
            };
        }

        public function __toIdleBtn_change(_arg_1:Event):void
        {
            change_toIdle();
        }

        private function troopProduce(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            switch (_arg_2)
            {
                case TFConstants.T_ARCHER:
                    _local_3 = int(Math.floor((_arg_1 / 2)));
                    break;
                case TFConstants.T_BALLISTA:
                    _local_3 = int(Math.floor((_arg_1 / 5)));
                    break;
                case TFConstants.T_BATTERINGRAM:
                    _local_3 = int(Math.floor((_arg_1 / 10)));
                    break;
                case TFConstants.T_CARRIAGE:
                    _local_3 = int(Math.floor((_arg_1 / 4)));
                    break;
                case TFConstants.T_CATAPULT:
                    _local_3 = int(Math.floor((_arg_1 / 8)));
                    break;
                case TFConstants.T_HEAVYCAVALRY:
                    _local_3 = int(Math.floor((_arg_1 / 6)));
                    break;
                case TFConstants.T_LIGHTCAVALRY:
                    _local_3 = int(Math.floor((_arg_1 / 3)));
                    break;
                case TFConstants.T_MILITIA:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
                case TFConstants.T_PEASANTS:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
                case TFConstants.T_PIKEMAN:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
                case TFConstants.T_SCOUTER:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
                case TFConstants.T_SWORDSMEN:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
            };
            return (_local_3);
        }

        private function checkResource():Boolean
        {
            var _local_3:Object;
            var _local_1:Boolean = true;
            var _local_2:int;
            while (_local_2 < this.dataAry.length)
            {
                _local_3 = this.dataAry.getItemAt(_local_2);
                if (_local_3.currentAmount < _local_3.needAmount)
                {
                    _local_1 = false;
                };
                _local_2++;
            };
            return (_local_1);
        }

        public function setBean(_arg_1:TroopProduceListBean):void
        {
            var _local_2:CastleResourceBean = Context.getInstance().getCurCastle().resource;
            this.troopBean = _arg_1;
            this.conditionTime = _arg_1.conditionBean.time;
            this.troopEum = TroopEumDefine.getTroopEumByType(this.troopBean.typeId);
            this.imgSrc = ImageManager.getTroopLargeLogo(this.troopBean.typeId);
            this.produceBuildingResourceData = new ProduceBuildingResourceData(_arg_1.conditionBean);
            this.dataAry = this.produceBuildingResourceData.dataArray;
            this.produceNum = this.ns.currentValue;
            this.produceBuildingResourceData.reCalcDataArray(this.produceNum);
            this.produceAllTime = UIUtil.timeToString((this.conditionTime * this.produceNum));
            if (((this.troopProduce(((_local_2.curPopulation - _local_2.buildPeople) - _local_2.workPeople), _arg_1.typeId) <= 0) || (this.produceBuildingResourceData.calcMaxProduce() <= 0)))
            {
                this.produceMaxNum = 0;
            }
            else
            {
                if (this.troopProduce(((_local_2.curPopulation - _local_2.buildPeople) - _local_2.workPeople), _arg_1.typeId) > this.produceBuildingResourceData.calcMaxProduce())
                {
                    this.produceMaxNum = this.produceBuildingResourceData.calcMaxProduce();
                }
                else
                {
                    this.produceMaxNum = this.troopProduce(((_local_2.curPopulation - _local_2.buildPeople) - _local_2.workPeople), _arg_1.typeId);
                };
            };
            if (this.initialized)
            {
                this.ns.refresh();
            };
            this.bind();
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:TroopBean = Context.getInstance().getCurCastle().troop;
            switch (this.troopBean.typeId)
            {
                case TFConstants.T_ARCHER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "archer");
                    return;
                case TFConstants.T_BALLISTA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "ballista");
                    return;
                case TFConstants.T_BATTERINGRAM:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "batteringRam");
                    return;
                case TFConstants.T_CARRIAGE:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "carriage");
                    return;
                case TFConstants.T_CATAPULT:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "catapult");
                    return;
                case TFConstants.T_HEAVYCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "heavyCavalry");
                    return;
                case TFConstants.T_LIGHTCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "lightCavalry");
                    return;
                case TFConstants.T_MILITIA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "militia");
                    return;
                case TFConstants.T_PEASANTS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "peasants");
                    return;
                case TFConstants.T_PIKEMAN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "pikemen");
                    return;
                case TFConstants.T_SCOUTER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "scouter");
                    return;
                case TFConstants.T_SWORDSMEN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "swordsmen");
                    return;
            };
        }

        private function onCheckIdleResponse(_arg_1:CommandResponse):void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TROOP_CHECK_IDLE_BARRACK, onCheckIdleResponse);
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("没有空闲兵营"));
                toIdleBtn.selected = false;
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

        private function change_isShare():void
        {
            if (!isShareBtn.selected)
            {
                toIdleBtn.selected = false;
            };
        }

        [Bindable(event="propertyChange")]
        public function get isShareBtn():CheckBox
        {
            return (this._1537057465isShareBtn);
        }

        [Bindable(event="propertyChange")]
        public function get condiction_DG():DataGrid
        {
            return (this._1482921390condiction_DG);
        }

        [Bindable(event="propertyChange")]
        private function get produceAllTime():String
        {
            return (this._1418324210produceAllTime);
        }

        private function onChange(_arg_1:int):void
        {
            this.produceNum = _arg_1;
            this.produceBuildingResourceData.reCalcDataArray(this.produceNum);
            this.produceAllTime = UIUtil.timeToString((this.conditionTime * this.produceNum));
        }

        private function change_toIdle():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_CHECK_IDLE_BARRACK, onCheckIdleResponse);
            ActionFactory.getInstance().getTroopCommands().checkIdleBarrack(Context.getInstance().getCurCastle().id, this.troopBean.typeId);
        }

        public function set curAmount(_arg_1:int):void
        {
            var _local_2:Object = this._737800520curAmount;
            if (_local_2 !== _arg_1)
            {
                this._737800520curAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curAmount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get produceMaxNum():int
        {
            return (this._426538114produceMaxNum);
        }

        private function needPopulation(_arg_1:int):int
        {
            var _local_2:int;
            switch (_arg_1)
            {
                case TFConstants.T_ARCHER:
                    _local_2 = (this.ns.currentValue * 2);
                    break;
                case TFConstants.T_BALLISTA:
                    _local_2 = (this.ns.currentValue * 5);
                    break;
                case TFConstants.T_BATTERINGRAM:
                    _local_2 = (this.ns.currentValue * 10);
                    break;
                case TFConstants.T_CARRIAGE:
                    _local_2 = (this.ns.currentValue * 4);
                    break;
                case TFConstants.T_CATAPULT:
                    _local_2 = (this.ns.currentValue * 8);
                    break;
                case TFConstants.T_HEAVYCAVALRY:
                    _local_2 = (this.ns.currentValue * 6);
                    break;
                case TFConstants.T_LIGHTCAVALRY:
                    _local_2 = (this.ns.currentValue * 3);
                    break;
                case TFConstants.T_MILITIA:
                    _local_2 = (this.ns.currentValue * 1);
                    break;
                case TFConstants.T_PEASANTS:
                    _local_2 = (this.ns.currentValue * 1);
                    break;
                case TFConstants.T_PIKEMAN:
                    _local_2 = (this.ns.currentValue * 1);
                    break;
                case TFConstants.T_SCOUTER:
                    _local_2 = (this.ns.currentValue * 1);
                    break;
                case TFConstants.T_SWORDSMEN:
                    _local_2 = (this.ns.currentValue * 1);
                    break;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get produceNum():int
        {
            return (this._1752545926produceNum);
        }

        public function ___SWEnlist_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set isShareBtn(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1537057465isShareBtn;
            if (_local_2 !== _arg_1)
            {
                this._1537057465isShareBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShareBtn", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:SWEnlist;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SWEnlist_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_barrack_SWEnlistWatcherSetupUtil");
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

        public function set ns(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._3525ns;
            if (_local_2 !== _arg_1)
            {
                this._3525ns = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ns", _local_2, _arg_1));
            };
        }

        private function closeOwner():void
        {
            PopUpManager.removePopUp(this);
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
        }

        private function _SWEnlist_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWEnlist_DataGridColumn3 = _local_1;
            _local_1.dataField = "currentAmount";
            BindingManager.executeBindings(this, "_SWEnlist_DataGridColumn3", _SWEnlist_DataGridColumn3);
            return (_local_1);
        }

        public function set condiction_DG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1482921390condiction_DG;
            if (_local_2 !== _arg_1)
            {
                this._1482921390condiction_DG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "condiction_DG", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        public function ___SWEnlist_Button1_click(_arg_1:MouseEvent):void
        {
            troopEnlist();
        }

        private function _SWEnlist_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _SWEnlist_Image1.source = _arg_1;
            }, "_SWEnlist_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Button1.label = _arg_1;
            }, "_SWEnlist_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.dataAry);
            }, function (_arg_1:Object):void
            {
                condiction_DG.dataProvider = _arg_1;
            }, "condiction_DG.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_DataGridColumn1.headerText = _arg_1;
            }, "_SWEnlist_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("需要数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_DataGridColumn2.headerText = _arg_1;
            }, "_SWEnlist_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_DataGridColumn3.headerText = _arg_1;
            }, "_SWEnlist_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("攻击") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label1.text = _arg_1;
            }, "_SWEnlist_Label1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.attack;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label2.text = _arg_1;
            }, "_SWEnlist_Label2.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("防御") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label3.text = _arg_1;
            }, "_SWEnlist_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.defence;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label4.text = _arg_1;
            }, "_SWEnlist_Label4.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("射程") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label5.text = _arg_1;
            }, "_SWEnlist_Label5.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.range;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label6.text = _arg_1;
            }, "_SWEnlist_Label6.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("速度") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label7.text = _arg_1;
            }, "_SWEnlist_Label7.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.speed;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label8.text = _arg_1;
            }, "_SWEnlist_Label8.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("负重") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label9.text = _arg_1;
            }, "_SWEnlist_Label9.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.load;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label10.text = _arg_1;
            }, "_SWEnlist_Label10.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("生命") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label11.text = _arg_1;
            }, "_SWEnlist_Label11.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.life;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label12.text = _arg_1;
            }, "_SWEnlist_Label12.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("粮食") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label13.text = _arg_1;
            }, "_SWEnlist_Label13.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.foodRequest;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label14.text = _arg_1;
            }, "_SWEnlist_Label14.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label15.text = _arg_1;
            }, "_SWEnlist_Label15.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.population;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label16.text = _arg_1;
            }, "_SWEnlist_Label16.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label17.text = _arg_1;
            }, "_SWEnlist_Label17.text");
            result[22] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                ns.onDataChange = _arg_1;
            }, "ns.onDataChange");
            result[23] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.produceMaxNum);
            }, function (_arg_1:int):void
            {
                ns.valueMax = _arg_1;
            }, "ns.valueMax");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label18.text = _arg_1;
            }, "_SWEnlist_Label18.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("建造数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label19.text = _arg_1;
            }, "_SWEnlist_Label19.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("最大建造") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label20.text = _arg_1;
            }, "_SWEnlist_Label20.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("建造时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label21.text = _arg_1;
            }, "_SWEnlist_Label21.text");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label22.text = _arg_1;
            }, "_SWEnlist_Label22.text");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.produceMaxNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label23.text = _arg_1;
            }, "_SWEnlist_Label23.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.produceAllTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Label24.text = _arg_1;
            }, "_SWEnlist_Label24.text");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWEnlist_Text1.text = _arg_1;
            }, "_SWEnlist_Text1.text");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("是否把生产平均到各军营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                isShareBtn.label = _arg_1;
            }, "isShareBtn.label");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("只分配到空闲军营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                toIdleBtn.label = _arg_1;
            }, "toIdleBtn.label");
            result[34] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        private function set dataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443166814dataAry;
            if (_local_2 !== _arg_1)
            {
                this._1443166814dataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataAry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ns():NumberRegulate
        {
            return (this._3525ns);
        }

        public function __isShareBtn_change(_arg_1:Event):void
        {
            change_isShare();
        }

        private function troopEnlist():void
        {
            var _local_1:Boolean = this.isShareBtn.selected;
            var _local_2:Boolean = this.toIdleBtn.selected;
            if (_local_2 == true)
            {
                _local_1 = true;
            };
            var _local_3:CastleResourceBean = Context.getInstance().getCurCastle().resource;
            if (!checkResource())
            {
                AlertWin.show(Lang.msg("资源不够"));
            }
            else
            {
                if (this.needPopulation(this.troopBean.typeId) > ((_local_3.curPopulation - _local_3.buildPeople) - _local_3.workPeople))
                {
                    AlertWin.show(Lang.msg("人口不够"));
                }
                else
                {
                    CommonProduceEvent.produce(Barrack.EVENT_PRODUCE, this.troopBean.typeId, this.ns.currentValue, _local_1, _local_2);
                };
            };
            this.closeOwner();
        }

        private function _SWEnlist_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWEnlist_DataGridColumn2 = _local_1;
            _local_1.dataField = "needAmount";
            BindingManager.executeBindings(this, "_SWEnlist_DataGridColumn2", _SWEnlist_DataGridColumn2);
            return (_local_1);
        }

        public function set toIdleBtn(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1122029toIdleBtn;
            if (_local_2 !== _arg_1)
            {
                this._1122029toIdleBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toIdleBtn", _local_2, _arg_1));
            };
        }

        public function ___SWEnlist_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }


    }
}//package view.module.barrack

