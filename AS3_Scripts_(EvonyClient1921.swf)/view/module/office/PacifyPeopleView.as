// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.PacifyPeopleView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.TextArea;
    import mx.controls.ComboBox;
    import mx.controls.Label;
    import mx.controls.Button;
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
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
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

    public class PacifyPeopleView extends Canvas implements IBindingClient 
    {

        public static var instancePopup:PacifyPeopleView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        private var _1539594266introduction:TextArea;
        private var _198268779actionCom:ComboBox;
        public var _PacifyPeopleView_Label1:Label;
        public var _PacifyPeopleView_Label2:Label;
        public var _PacifyPeopleView_Label3:Label;
        public var _PacifyPeopleView_Label6:Label;
        private var _2023558323population:Label;
        private var _348630820submitBtn:Button;
        private var _691506344curCastle:CastleBean;
        private var _1854767153support:Label;
        private var _1092797764closeBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":214,
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
                                            "height":26,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":30,
                                                        "height":26,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PacifyPeopleView_Label1",
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
                                                        "percentWidth":20,
                                                        "height":26,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PacifyPeopleView_Label2",
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
                                                        "percentWidth":50,
                                                        "height":26,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PacifyPeopleView_Label3",
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
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "54";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"population",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.top = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":117.3,
                                            "x":0,
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
                                        this.top = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":84.2,
                                            "x":117.3,
                                            "height":20,
                                            "styleName":"tableContent2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"actionCom",
                                    "events":{"change":"__actionCom_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.right = "5";
                                        this.top = "25";
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":190,
                                            "styleName":"ComboBox",
                                            "height":26
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"introduction",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "none";
                                        this.backgroundAlpha = 0;
                                        this.textAlign = "left";
                                        this.top = "55";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388,
                                            "alpha":1,
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
                                    "id":"_PacifyPeopleView_Label6",
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
                            this.bottom = "17";
                            this.right = "20";
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
                                        return ({"styleName":"b95"});
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
                        "events":{"click":"___PacifyPeopleView_Button3_click"},
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
            "label":Lang.msg("赈灾"),
            "data":1
        }, {
            "label":Lang.msg("祈福"),
            "data":2
        }, {
            "label":Lang.msg("祭天"),
            "data":3
        }, {
            "label":Lang.msg("增丁"),
            "data":4
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PacifyPeopleView()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 214;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PacifyPeopleView._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (PacifyPeopleView)();
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


        private function closeWindow(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        override public function initialize():void
        {
            var target:PacifyPeopleView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PacifyPeopleView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_PacifyPeopleViewWatcherSetupUtil");
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

        private function comChange(_arg_1:int):void
        {
            var _local_2:Number;
            var _local_3:int;
            switch (_arg_1)
            {
                case 1:
                    submitBtn.label = Lang.msg("赈灾");
                    _local_2 = ((Context.getInstance().getPlayerBean().playerInfo.prestige / 10) * Context.getInstance().getPlayerBean().playerInfo.castleCount);
                    _local_2 = (_local_2 * Context.getInstance().getCurCastle().usePACIFY_SUCCOUR_OR_PACIFY_PRAY);
                    _local_2 = Math.min(_local_2, 10000000);
                    _local_3 = _local_2;
                    introduction.text = ((("Disaster Relief costs Food " + _local_3.toString()) + ". ") + Lang.msg("提升民心5减少民怨15"));
                    return;
                case 2:
                    submitBtn.label = Lang.msg("祈福");
                    _local_2 = ((Context.getInstance().getPlayerBean().playerInfo.prestige / 10) * Context.getInstance().getPlayerBean().playerInfo.castleCount);
                    _local_2 = (_local_2 * Context.getInstance().getCurCastle().usePACIFY_SUCCOUR_OR_PACIFY_PRAY);
                    _local_2 = Math.min(_local_2, 10000000);
                    _local_3 = _local_2;
                    introduction.text = ((("praying costs Food " + _local_3.toString()) + ". ") + Lang.msg("提升民心25减少民怨5"));
                    return;
                case 3:
                    submitBtn.label = Lang.msg("祭天");
                    introduction.text = ((Lang.msg("祭天消耗粮食{0}和黄金{1}", this.curCastle.resource.maxPopulation, Math.ceil((this.curCastle.resource.maxPopulation * 0.1))) + " ") + Lang.msg("避免1次天灾有机会增加1次天赐"));
                    return;
                case 4:
                    submitBtn.label = Lang.msg("增丁");
                    introduction.text = ((((((((Lang.msg("增丁消耗粮食") + " ") + (this.curCastle.resource.maxPopulation * 0.5)) + ". ") + Lang.msg("增加人口")) + " ") + Math.floor((this.curCastle.resource.maxPopulation * 0.05))) + ". ") + Lang.msg("不超过人口上限"));
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get introduction():TextArea
        {
            return (this._1539594266introduction);
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

        public function set support(_arg_1:Label):void
        {
            var _local_2:Object = this._1854767153support;
            if (_local_2 !== _arg_1)
            {
                this._1854767153support = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "support", _local_2, _arg_1));
            };
        }

        public function init():void
        {
            comChange(1);
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

        public function set population(_arg_1:Label):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
            comChange(1);
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

        private function pacifyPeopleResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功安抚百姓"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
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
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            submitHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get support():Label
        {
            return (this._1854767153support);
        }

        [Bindable(event="propertyChange")]
        public function get population():Label
        {
            return (this._2023558323population);
        }

        public function set actionCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._198268779actionCom;
            if (_local_2 !== _arg_1)
            {
                this._198268779actionCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "actionCom", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        private function submitHandle(_arg_1:MouseEvent):void
        {
            instance = ResponseDispatcher.getInstance();
            instance.addEventListener(ResponseDispatcher.INTERIOR_PACIFY_PEOPLE, pacifyPeopleResponse, false, 0, true);
            ActionFactory.getInstance().getInteriorCommands().pacifyPeople(this.curCastle.id, actionCom.selectedItem.valueOf().data);
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        [Bindable(event="propertyChange")]
        private function get comData():Array
        {
            return (this._949173451comData);
        }

        public function __actionCom_change(_arg_1:ListEvent):void
        {
            comChange(_arg_1.target.selectedItem.data);
        }

        public function ___PacifyPeopleView_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get actionCom():ComboBox
        {
            return (this._198268779actionCom);
        }

        private function _PacifyPeopleView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PacifyPeopleView_Label1.text = _arg_1;
            }, "_PacifyPeopleView_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PacifyPeopleView_Label2.text = _arg_1;
            }, "_PacifyPeopleView_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("行为");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PacifyPeopleView_Label3.text = _arg_1;
            }, "_PacifyPeopleView_Label3.text");
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
                actionCom.dataProvider = _arg_1;
            }, "actionCom.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("安抚百姓");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PacifyPeopleView_Label6.text = _arg_1;
            }, "_PacifyPeopleView_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赈灾");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("关闭");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[8] = binding;
            return (result);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function _PacifyPeopleView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("民心");
            _local_1 = Lang.msg("行为");
            _local_1 = this.curCastle.resource.curPopulation;
            _local_1 = this.curCastle.resource.support;
            _local_1 = comData;
            _local_1 = Lang.msg("安抚百姓");
            _local_1 = Lang.msg("赈灾");
            _local_1 = Lang.msg("关闭");
        }


    }
}//package view.module.office

