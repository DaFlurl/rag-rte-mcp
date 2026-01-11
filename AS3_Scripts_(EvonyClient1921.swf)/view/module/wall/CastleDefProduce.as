// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.wall.CastleDefProduce

package view.module.wall
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.controls.DataGrid;
    import com.evony.common.beans.FortProduceListBean;
    import mx.controls.Button;
    import com.evony.util.ProduceBuildingResourceData;
    import mx.controls.Text;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.eum.FortificationEum;
    import view.ui.NumberRegulate;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import view.ui.MyHRule;
    import mx.containers.HBox;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.eum.FortificationEumDefine;
    import mx.binding.BindingManager;
    import com.evony.factory.ImageManager;
    import com.evony.util.UIUtil;
    import view.ui.AlertWin;
    import com.evony.events.CommonProduceEvent;
    import com.evony.common.beans.FortificationsBean;
    import mx.binding.utils.BindingUtils;
    import com.evony.common.constants.TFConstants;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
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

    public class CastleDefProduce extends Canvas implements IBindingClient 
    {

        private static var instance:CastleDefProduce;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CastleDefProduce_Label1:Label;
        public var _CastleDefProduce_Label2:Label;
        public var _CastleDefProduce_Label3:Label;
        public var _CastleDefProduce_Label4:Label;
        public var _CastleDefProduce_Label5:Label;
        public var _CastleDefProduce_Label6:Label;
        public var _CastleDefProduce_Label7:Label;
        public var _CastleDefProduce_Label8:Label;
        public var _CastleDefProduce_Label9:Label;
        private var _2127527410_produceTime:Label;
        public var _CastleDefProduce_Label10:Label;
        public var _CastleDefProduce_Label11:Label;
        public var _CastleDefProduce_Label12:Label;
        public var _CastleDefProduce_Label13:Label;
        public var _CastleDefProduce_Label14:Label;
        public var _CastleDefProduce_Label15:Label;
        public var _CastleDefProduce_Label16:Label;
        public var _CastleDefProduce_Label18:Label;
        private var _737800520curAmount:int;
        public var _CastleDefProduce_Image1:Image;
        private var _1482921390condiction_DG:DataGrid;
        private var conditionTime:Number;
        private var _479606555fortBean:FortProduceListBean;
        public var _CastleDefProduce_Button1:Button;
        private var _1185090783imgSrc:Object;
        private var produceBuildingResourceData:ProduceBuildingResourceData;
        public var _CastleDefProduce_Text1:Text;
        public var _CastleDefProduce_DataGridColumn1:DataGridColumn;
        public var _CastleDefProduce_DataGridColumn2:DataGridColumn;
        public var _CastleDefProduce_DataGridColumn3:DataGridColumn;
        private var _677262094fortEum:FortificationEum;
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
                    "width":440,
                    "height":460,
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
                        "id":"_CastleDefProduce_Image1",
                        "events":{"creationComplete":"___CastleDefProduce_Image1_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "33";
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
                        "id":"_CastleDefProduce_Button1",
                        "events":{"click":"___CastleDefProduce_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"y125",
                                "width":125
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"condiction_DG",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "187";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "styleName":"style2",
                                "rowCount":4,
                                "rowHeight":30,
                                "height":147,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_CastleDefProduce_DataGridColumn1_i(), _CastleDefProduce_DataGridColumn2_i(), _CastleDefProduce_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "102";
                            this.right = "20";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":80,
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
                                    "id":"_CastleDefProduce_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":3,
                                            "y":8,
                                            "width":80,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":83,
                                            "y":8,
                                            "width":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":3,
                                            "y":33,
                                            "width":80,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":83,
                                            "y":33,
                                            "width":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":133,
                                            "y":8,
                                            "width":80,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":213,
                                            "y":8,
                                            "width":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":263,
                                            "y":8,
                                            "width":80,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label8",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":343,
                                            "y":8,
                                            "width":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":133,
                                            "y":33,
                                            "width":80,
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label10",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":213,
                                            "y":33,
                                            "width":50
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
                            this.top = "338";
                            this.bottom = "44";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":NumberRegulate,
                                    "id":"ns",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "280";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "isProduce":true,
                                            "y":8,
                                            "width":94
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label11",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.left = "5";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":10.4,
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label12",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.left = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":10.4,
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label13",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.left = "5";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":46,
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleDefProduce_Label14",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.left = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":48,
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "85";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":6,
                                            "width":90,
                                            "height":30,
                                            "styleName":"canvasGroupBackGround",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleDefProduce_Label15",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.left = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":85,
                                                        "y":4
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "85";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":41.4,
                                            "width":90,
                                            "height":30,
                                            "styleName":"canvasGroupBackGround",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CastleDefProduce_Label16",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.left = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":85,
                                                        "y":5
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "280";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":42,
                                            "height":30,
                                            "styleName":"canvasGroupBackGround",
                                            "horizontalScrollPolicy":"off",
                                            "width":90,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_produceTime",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.left = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":85,
                                                        "y":5
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "89";
                            this.right = "20";
                            this.top = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":64,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_CastleDefProduce_Text1",
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
                                    "id":"_CastleDefProduce_Label18",
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
                        "type":Button,
                        "events":{"click":"___CastleDefProduce_Button2_click"},
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
        private var _resource:CastleResourceBean = Context.getInstance().getCurCastle().resource;
        private var amountAry:Array = new Array();
        private var _1443166814dataAry:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleDefProduce()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 460;
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleDefProduce._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():CastleDefProduce
        {
            if (instance == null)
            {
                instance = new (CastleDefProduce)();
            };
            return (instance);
        }

        public static function show(_arg_1:FortProduceListBean):void
        {
            if (instance == null)
            {
                instance = new (CastleDefProduce)();
            };
            PopUpManager.addPopUp(instance, MainFrame.instance, true);
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
            instance.setBean(_arg_1);
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

        private function set produceNum(_arg_1:int):void
        {
            var _local_2:Object = this._1752545926produceNum;
            if (_local_2 !== _arg_1)
            {
                this._1752545926produceNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceNum", _local_2, _arg_1));
            };
        }

        private function _CastleDefProduce_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSrc;
            _local_1 = Lang.msg("确定");
            _local_1 = this.dataAry;
            _local_1 = Lang.msg("建造条件");
            _local_1 = Lang.msg("需要数量");
            _local_1 = Lang.msg("当前数量");
            _local_1 = (Lang.msg("生命") + ": ");
            _local_1 = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).life == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).life);
            _local_1 = (Lang.msg("空间") + ": ");
            _local_1 = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).space == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).space);
            _local_1 = (Lang.msg("攻击") + ": ");
            _local_1 = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).attack == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).attack);
            _local_1 = (Lang.msg("射程") + ": ");
            _local_1 = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).range == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).range);
            _local_1 = (Lang.msg("防御") + ": ");
            _local_1 = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).defence == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).defence);
            _local_1 = onChange;
            _local_1 = this.produceMaxNum;
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = (Lang.msg("建造") + ": ");
            _local_1 = (Lang.msg("最大建造") + ": ");
            _local_1 = (Lang.msg("建造时间") + ": ");
            _local_1 = this.curAmount;
            _local_1 = this.produceMaxNum;
            _local_1 = this.produceAllTime;
            _local_1 = this.fortEum.desc;
            _local_1 = this.fortEum.name;
        }

        [Bindable(event="propertyChange")]
        private function get fortBean():FortProduceListBean
        {
            return (this._479606555fortBean);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        public function set _produceTime(_arg_1:Label):void
        {
            var _local_2:Object = this._2127527410_produceTime;
            if (_local_2 !== _arg_1)
            {
                this._2127527410_produceTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_produceTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _produceTime():Label
        {
            return (this._2127527410_produceTime);
        }

        private function _CastleDefProduce_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefProduce_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_CastleDefProduce_DataGridColumn1", _CastleDefProduce_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get produceAllTime():String
        {
            return (this._1418324210produceAllTime);
        }

        private function setBean(_arg_1:FortProduceListBean):void
        {
            this.fortBean = _arg_1;
            this.fortEum = FortificationEumDefine.getFortificationEumByType(this.fortBean.typeId);
            this.imgSrc = ImageManager.getFortBigLogo(this.fortBean.typeId);
            this.conditionTime = _arg_1.conditionBean.time;
            this.produceBuildingResourceData = new ProduceBuildingResourceData(_arg_1.conditionBean);
            this.dataAry = this.produceBuildingResourceData.dataArray;
            this.produceNum = this.ns.currentValue;
            this.produceBuildingResourceData.reCalcDataArray(this.produceNum);
            this.produceAllTime = UIUtil.timeToString((this.conditionTime * this.produceNum));
            if (this.fortProduce(Wall.wallInstance.leftSpace, _arg_1.typeId) > this.produceBuildingResourceData.calcMaxProduce())
            {
                this.produceMaxNum = this.produceBuildingResourceData.calcMaxProduce();
            }
            else
            {
                if (this.fortProduce(Wall.wallInstance.leftSpace, _arg_1.typeId) > 0)
                {
                    this.produceMaxNum = this.fortProduce(Wall.wallInstance.leftSpace, _arg_1.typeId);
                }
                else
                {
                    this.produceMaxNum = 0;
                };
            };
            if (this.initialized)
            {
                this.ns.refresh();
            };
            this.bind();
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

        private function castleDefProduce():void
        {
            if (this.countFortSpace(this.fortBean.typeId, this.ns.currentValue) > Wall.wallInstance.leftSpace)
            {
                AlertWin.show(Lang.msg("城防空间不够"));
            }
            else
            {
                if (!checkResource())
                {
                    AlertWin.show(Lang.msg("资源不够"));
                }
                else
                {
                    CommonProduceEvent.produce(Wall.EVENT_PRODUCE, this.fortBean.typeId, this.ns.currentValue, false, false);
                };
            };
            this.closeOwner();
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:FortificationsBean = Context.getInstance().getCurCastle().fortification;
            switch (this.fortBean.typeId)
            {
                case TFConstants.F_ABATIS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "abatis");
                    return;
                case TFConstants.F_ARROWTOWER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "arrowTower");
                    return;
                case TFConstants.F_ROCKFALL:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rockfall");
                    return;
                case TFConstants.F_ROLLINGLOGS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rollingLogs");
                    return;
                case TFConstants.F_TRAP:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "trap");
                    return;
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

        private function set fortBean(_arg_1:FortProduceListBean):void
        {
            var _local_2:Object = this._479606555fortBean;
            if (_local_2 !== _arg_1)
            {
                this._479606555fortBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get condiction_DG():DataGrid
        {
            return (this._1482921390condiction_DG);
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        private function onChange(_arg_1:int):void
        {
            this.produceNum = _arg_1;
            this.produceBuildingResourceData.reCalcDataArray(this.produceNum);
            this.produceAllTime = UIUtil.timeToString((this.conditionTime * this.produceNum));
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

        [Bindable(event="propertyChange")]
        private function get produceNum():int
        {
            return (this._1752545926produceNum);
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

        override public function initialize():void
        {
            var target:CastleDefProduce;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleDefProduce_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_wall_CastleDefProduceWatcherSetupUtil");
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

        private function fortProduce(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            switch (_arg_2)
            {
                case TFConstants.F_ABATIS:
                    _local_3 = int(Math.floor((_arg_1 / 2)));
                    break;
                case TFConstants.F_ARROWTOWER:
                    _local_3 = int(Math.floor((_arg_1 / 3)));
                    break;
                case TFConstants.F_ROCKFALL:
                    _local_3 = int(Math.floor((_arg_1 / 5)));
                    break;
                case TFConstants.F_ROLLINGLOGS:
                    _local_3 = int(Math.floor((_arg_1 / 4)));
                    break;
                case TFConstants.F_TRAP:
                    _local_3 = int(Math.floor((_arg_1 / 1)));
                    break;
            };
            return (_local_3);
        }

        public function ___CastleDefProduce_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function closeOwner():void
        {
            PopUpManager.removePopUp(this);
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

        private function _CastleDefProduce_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefProduce_DataGridColumn3 = _local_1;
            _local_1.dataField = "currentAmount";
            BindingManager.executeBindings(this, "_CastleDefProduce_DataGridColumn3", _CastleDefProduce_DataGridColumn3);
            return (_local_1);
        }

        public function countFortSpace(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            switch (_arg_1)
            {
                case TFConstants.F_ABATIS:
                    _local_3 = (_arg_2 * 2);
                    break;
                case TFConstants.F_ARROWTOWER:
                    _local_3 = (_arg_2 * 3);
                    break;
                case TFConstants.F_ROCKFALL:
                    _local_3 = (_arg_2 * 5);
                    break;
                case TFConstants.F_ROLLINGLOGS:
                    _local_3 = (_arg_2 * 4);
                    break;
                case TFConstants.F_TRAP:
                    _local_3 = (_arg_2 * 1);
                    break;
            };
            return (_local_3);
        }

        [Bindable(event="propertyChange")]
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        public function ___CastleDefProduce_Button1_click(_arg_1:MouseEvent):void
        {
            castleDefProduce();
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

        private function _CastleDefProduce_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _CastleDefProduce_Image1.source = _arg_1;
            }, "_CastleDefProduce_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Button1.label = _arg_1;
            }, "_CastleDefProduce_Button1.label");
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
                var _local_1:* = Lang.msg("建造条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_DataGridColumn1.headerText = _arg_1;
            }, "_CastleDefProduce_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("需要数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_DataGridColumn2.headerText = _arg_1;
            }, "_CastleDefProduce_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_DataGridColumn3.headerText = _arg_1;
            }, "_CastleDefProduce_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("生命") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label1.text = _arg_1;
            }, "_CastleDefProduce_Label1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).life == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).life);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label2.text = _arg_1;
            }, "_CastleDefProduce_Label2.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("空间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label3.text = _arg_1;
            }, "_CastleDefProduce_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).space == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).space);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label4.text = _arg_1;
            }, "_CastleDefProduce_Label4.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("攻击") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label5.text = _arg_1;
            }, "_CastleDefProduce_Label5.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).attack == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).attack);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label6.text = _arg_1;
            }, "_CastleDefProduce_Label6.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("射程") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label7.text = _arg_1;
            }, "_CastleDefProduce_Label7.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).range == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).range);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label8.text = _arg_1;
            }, "_CastleDefProduce_Label8.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("防御") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label9.text = _arg_1;
            }, "_CastleDefProduce_Label9.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((FortificationEumDefine.getFortificationEumByType(fortBean.typeId).defence == 0) ? "---" : FortificationEumDefine.getFortificationEumByType(fortBean.typeId).defence);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label10.text = _arg_1;
            }, "_CastleDefProduce_Label10.text");
            result[15] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                ns.onDataChange = _arg_1;
            }, "ns.onDataChange");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.produceMaxNum);
            }, function (_arg_1:int):void
            {
                ns.valueMax = _arg_1;
            }, "ns.valueMax");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label11.text = _arg_1;
            }, "_CastleDefProduce_Label11.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("建造") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label12.text = _arg_1;
            }, "_CastleDefProduce_Label12.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("最大建造") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label13.text = _arg_1;
            }, "_CastleDefProduce_Label13.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("建造时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label14.text = _arg_1;
            }, "_CastleDefProduce_Label14.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label15.text = _arg_1;
            }, "_CastleDefProduce_Label15.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.produceMaxNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label16.text = _arg_1;
            }, "_CastleDefProduce_Label16.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.produceAllTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _produceTime.text = _arg_1;
            }, "_produceTime.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fortEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Text1.text = _arg_1;
            }, "_CastleDefProduce_Text1.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fortEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefProduce_Label18.text = _arg_1;
            }, "_CastleDefProduce_Label18.text");
            result[26] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get ns():NumberRegulate
        {
            return (this._3525ns);
        }

        private function set fortEum(_arg_1:FortificationEum):void
        {
            var _local_2:Object = this._677262094fortEum;
            if (_local_2 !== _arg_1)
            {
                this._677262094fortEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortEum", _local_2, _arg_1));
            };
        }

        private function _CastleDefProduce_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefProduce_DataGridColumn2 = _local_1;
            _local_1.dataField = "needAmount";
            BindingManager.executeBindings(this, "_CastleDefProduce_DataGridColumn2", _CastleDefProduce_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get fortEum():FortificationEum
        {
            return (this._677262094fortEum);
        }

        public function ___CastleDefProduce_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }


    }
}//package view.module.wall

