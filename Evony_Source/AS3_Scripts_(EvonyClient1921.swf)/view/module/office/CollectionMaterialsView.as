// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.CollectionMaterialsView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import view.ui.MyHRule;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.ListEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
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

    public class CollectionMaterialsView extends Canvas implements IBindingClient 
    {

        public static var instancePopup:CollectionMaterialsView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        private var _1539594266introduction:TextArea;
        private var _1525254222worning:TextArea;
        private var _2023558323population:Label;
        private var _348630820submitBtn:Button;
        private var _853116953typeCom:ComboBox;
        private var _691506344curCastle:CastleBean;
        private var _1854767153support:Label;
        private var _1092797764closeBtn:Button;
        private var _1724546052description:Label;
        public var _CollectionMaterialsView_Label1:Label;
        public var _CollectionMaterialsView_Label2:Label;
        public var _CollectionMaterialsView_Label3:Label;
        public var _CollectionMaterialsView_Label7:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":204.33333,
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
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                        this.left = "1";
                                        this.top = "1";
                                        this.right = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CollectionMaterialsView_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
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
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CollectionMaterialsView_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
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
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":33.33,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CollectionMaterialsView_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
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
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":58,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":109,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"introduction",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "none";
                                        this.backgroundAlpha = 0;
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":62,
                                            "width":388,
                                            "alpha":1,
                                            "height":43
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"population",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":132.5,
                                            "x":0,
                                            "y":30,
                                            "height":20,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"support",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":132.5,
                                            "x":133,
                                            "y":30,
                                            "height":20,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"typeCom",
                                    "events":{"change":"__typeCom_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":29,
                                            "width":120,
                                            "styleName":"ComboBox"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"description",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":62,
                                            "width":388,
                                            "height":22,
                                            "styleName":"PropertyName2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"worning",
                                    "stylesFactory":function ():void
                                    {
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":87,
                                            "width":388,
                                            "height":22,
                                            "selectable":false,
                                            "styleName":"PropertyName2"
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
                                    "id":"_CollectionMaterialsView_Label7",
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
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.bottom = "17";
                            this.horizontalAlign = "right";
                            this.horizontalGap = 8;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"submitBtn",
                                    "events":{"click":"__submitBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b40"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"closeBtn",
                                    "events":{"click":"__closeBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b40"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CollectionMaterialsView_Button3_click"},
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
        private var _949173451comData:Array = new Array({
            "label":Lang.msg("黄金"),
            "data":1
        }, {
            "label":Lang.msg("粮食"),
            "data":2
        }, {
            "label":Lang.msg("木材"),
            "data":3
        }, {
            "label":Lang.msg("石料"),
            "data":4
        }, {
            "label":Lang.msg("铁矿"),
            "data":5
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CollectionMaterialsView()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 204.33333;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CollectionMaterialsView._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (CollectionMaterialsView)();
            };
            PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            if ((Application.application.width - instancePopup.width) > 0)
            {
                instancePopup.x = (((Application.application.width - instancePopup.width) / 2) - 150);
                instancePopup.y = (((Application.application.height - instancePopup.height) / 2) - 30);
                PopUpManager.bringToFront(instancePopup);
            }
            else
            {
                PopUpManager.centerPopUp(instancePopup);
            };
            instancePopup.castleBean = CastleBean(_arg_1);
        }


        [Bindable(event="propertyChange")]
        public function get description():Label
        {
            return (this._1724546052description);
        }

        private function closeWindow(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        public function set closeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1092797764closeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1092797764closeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeBtn", _local_2, _arg_1));
            };
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
            comChange(1);
        }

        private function comChange(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 1:
                    this.description.text = (((Lang.msg("可征收黄金") + " ") + int((this.curCastle.resource.curPopulation * 0.1))) + ".");
                    return;
                case 2:
                    this.description.text = (((Lang.msg("可征收粮食") + " ") + int(this.curCastle.resource.curPopulation)) + ".");
                    return;
                case 3:
                    this.description.text = (((Lang.msg("可征收木材") + " ") + int(this.curCastle.resource.curPopulation)) + ".");
                    return;
                case 4:
                    this.description.text = (((Lang.msg("可征收石料") + " ") + int((this.curCastle.resource.curPopulation * 0.5))) + ".");
                    return;
                case 5:
                    this.description.text = (((Lang.msg("可征收铁矿") + " ") + int((this.curCastle.resource.curPopulation * 0.4))) + ".");
                    return;
            };
        }

        public function init():void
        {
            comChange(1);
        }

        [Bindable(event="propertyChange")]
        public function get introduction():TextArea
        {
            return (this._1539594266introduction);
        }

        public function set worning(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1525254222worning;
            if (_local_2 !== _arg_1)
            {
                this._1525254222worning = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "worning", _local_2, _arg_1));
            };
        }

        private function set comData(_arg_1:Array):void
        {
            var _local_2:Object = this._949173451comData;
            if (_local_2 !== _arg_1)
            {
                this._949173451comData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comData", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:CollectionMaterialsView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CollectionMaterialsView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_CollectionMaterialsViewWatcherSetupUtil");
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

        public function set population(_arg_1:Label):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        private function _CollectionMaterialsView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CollectionMaterialsView_Label1.text = _arg_1;
            }, "_CollectionMaterialsView_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CollectionMaterialsView_Label2.text = _arg_1;
            }, "_CollectionMaterialsView_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征收");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CollectionMaterialsView_Label3.text = _arg_1;
            }, "_CollectionMaterialsView_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.resource.curPopulation;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                population.text = _arg_1;
            }, "population.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curCastle.resource.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                support.text = _arg_1;
            }, "support.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (comData);
            }, function (_arg_1:Object):void
            {
                typeCom.dataProvider = _arg_1;
            }, "typeCom.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("临时征收物资会降低民心20");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                worning.text = _arg_1;
            }, "worning.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征收物资");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CollectionMaterialsView_Label7.text = _arg_1;
            }, "_CollectionMaterialsView_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征收");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("关闭");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[9] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            closeWindow(_arg_1);
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        public function set introduction(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1539594266introduction;
            if (_local_2 !== _arg_1)
            {
                this._1539594266introduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "introduction", _local_2, _arg_1));
            };
        }

        public function set support(_arg_1:Label):void
        {
            var _local_2:Object = this._1854767153support;
            if (_local_2 !== _arg_1)
            {
                this._1854767153support = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "support", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function set submitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._348630820submitBtn;
            if (_local_2 !== _arg_1)
            {
                this._348630820submitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get comData():Array
        {
            return (this._949173451comData);
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            chargeHandle(_arg_1);
        }

        public function set typeCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._853116953typeCom;
            if (_local_2 !== _arg_1)
            {
                this._853116953typeCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeCom", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get support():Label
        {
            return (this._1854767153support);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get worning():TextArea
        {
            return (this._1525254222worning);
        }

        private function _CollectionMaterialsView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("民心");
            _local_1 = Lang.msg("征收");
            _local_1 = this.curCastle.resource.curPopulation;
            _local_1 = this.curCastle.resource.support;
            _local_1 = comData;
            _local_1 = Lang.msg("临时征收物资会降低民心20");
            _local_1 = Lang.msg("征收物资");
            _local_1 = Lang.msg("征收");
            _local_1 = Lang.msg("关闭");
        }

        [Bindable(event="propertyChange")]
        public function get population():Label
        {
            return (this._2023558323population);
        }

        public function ___CollectionMaterialsView_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get typeCom():ComboBox
        {
            return (this._853116953typeCom);
        }

        public function __typeCom_change(_arg_1:ListEvent):void
        {
            comChange(_arg_1.target.selectedItem.data);
        }

        private function taxationHandle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功征收物资"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set description(_arg_1:Label):void
        {
            var _local_2:Object = this._1724546052description;
            if (_local_2 !== _arg_1)
            {
                this._1724546052description = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _local_2, _arg_1));
            };
        }

        private function chargeHandle(_arg_1:MouseEvent):void
        {
            instance = ResponseDispatcher.getInstance();
            instance.addEventListener(ResponseDispatcher.INTERIOR_TAXATION, taxationHandle, false, 0, true);
            ActionFactory.getInstance().getInteriorCommands().taxation(this.curCastle.id, typeCom.selectedItem.valueOf().data);
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }


    }
}//package view.module.office

