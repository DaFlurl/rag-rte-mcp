// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.PoliciesView

package view.castle.world
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
    import view.ui.MyHRule;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.capital.CapitalCommandResponse;
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

    public class PoliciesView extends Canvas implements IBindingClient 
    {

        public static var instancePopup:PoliciesView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        private var dstCastleId:int;
        private var preId:int = 1;
        private var _1539594266introduction:TextArea;
        private var _198268779actionCom:ComboBox;
        private var _2023558323population:Label;
        private var _348630820submitBtn:Button;
        private var _1269462998policiesTimes:int = 0;
        private var _691506344curCastle:CastleBean;
        private var _1092797764closeBtn:Button;
        private var _1765469883strIntro:String;
        public var _PoliciesView_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":194.33333,
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
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PoliciesView_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
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
                            this.top = "33";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "51";
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
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":140,
                                            "x":0,
                                            "height":20,
                                            "text":"Policies"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"actionCom",
                                    "events":{"change":"__actionCom_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "51";
                                        this.top = "25";
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":190});
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
                            this.bottom = "17";
                            this.right = "20";
                            this.horizontalAlign = "center";
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
                                        return ({"styleName":"b95"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___PoliciesView_Button3_click"},
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
        private var _949173451comData:Array = new Array();
        private var _640394041comData2:Array = new Array({
            "label":Lang.msg("收税"),
            "data":1
        }, {
            "label":Lang.msg("抽丁"),
            "data":2
        }, {
            "label":Lang.msg("征粮"),
            "data":3
        }, {
            "label":Lang.msg("征兵"),
            "data":4
        }, {
            "label":Lang.msg("裁军"),
            "data":5
        });
        private var _640394040comData3:Array = new Array({
            "label":Lang.msg("收税"),
            "data":1
        }, {
            "label":Lang.msg("抽丁"),
            "data":2
        }, {
            "label":Lang.msg("征粮"),
            "data":3
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PoliciesView()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 194.33333;
            this.addEventListener("creationComplete", ___PoliciesView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PoliciesView._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object, _arg_2:String, _arg_3:int):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (PoliciesView)();
            };
            PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            PopUpManager.centerPopUp(instancePopup);
            instancePopup.dstCastleId = int(_arg_1);
            if (((_arg_2 == null) && (_arg_3 < 4)))
            {
                instancePopup.comData = instancePopup.comData3;
            }
            else
            {
                instancePopup.comData = instancePopup.comData2;
            };
            instancePopup.comChange(1);
        }


        private function set comData2(_arg_1:Array):void
        {
            var _local_2:Object = this._640394041comData2;
            if (_local_2 !== _arg_1)
            {
                this._640394041comData2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comData2", _local_2, _arg_1));
            };
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

        override public function initialize():void
        {
            var target:PoliciesView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PoliciesView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_world_PoliciesViewWatcherSetupUtil");
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
            preId = _arg_1;
            switch (_arg_1)
            {
                case 1:
                    submitBtn.label = Lang.msg("收税");
                    introduction.text = Lang.msg("可对目标城池收取一定比例的黄金税收。这是您今天第{0}次下达政令", this.policiesTimes);
                    return;
                case 4:
                    submitBtn.label = Lang.msg("征兵");
                    introduction.text = Lang.msg("可对目标城池某一类兵种抽取一定比例的数量。这是您今天第{0}次下达政令", this.policiesTimes);
                    return;
                case 5:
                    submitBtn.label = Lang.msg("裁军");
                    introduction.text = Lang.msg("可将目标城池某一类兵种裁减一定比例的数量。这是您今天第{0}次下达政令", this.policiesTimes);
                    return;
                case 2:
                    submitBtn.label = Lang.msg("抽丁");
                    introduction.text = Lang.msg("可向目标城池抽取一定比例的人口数。这是您今天第{0}次下达政令", this.policiesTimes);
                    return;
                case 3:
                    submitBtn.label = Lang.msg("征粮");
                    introduction.text = Lang.msg("可向目标城池征收一定比例的粮食。这是您今天第{0}次下达政令", this.policiesTimes);
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get introduction():TextArea
        {
            return (this._1539594266introduction);
        }

        public function init():void
        {
            ActionFactory.getInstance().getCapitalCommands().getLeftPoliciesTimes(Context.getInstance().getCurCastle().id, PoliciesTimesResponse);
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

        private function _PoliciesView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("政令");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PoliciesView_Label1.text = _arg_1;
            }, "_PoliciesView_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (comData);
            }, function (_arg_1:Object):void
            {
                actionCom.dataProvider = _arg_1;
            }, "actionCom.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("功能取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[3] = binding;
            return (result);
        }

        private function PoliciesTimesResponse(_arg_1:CapitalCommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                policiesTimes = _arg_1.amount;
                instancePopup.comChange(preId);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set comData3(_arg_1:Array):void
        {
            var _local_2:Object = this._640394040comData3;
            if (_local_2 !== _arg_1)
            {
                this._640394040comData3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comData3", _local_2, _arg_1));
            };
        }

        public function ___PoliciesView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
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

        public function ___PoliciesView_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function policiesResponse(_arg_1:CapitalCommandResponse):void
        {
            init();
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                switch (actionCom.selectedIndex)
                {
                    case 0:
                        AlertWin.show(Lang.msg("使用政令成功。得到{0}黄金", _arg_1.amount));
                        break;
                    case 1:
                        AlertWin.show(Lang.msg("使用政令成功。得到{0}人口", _arg_1.amount));
                        break;
                    case 2:
                        AlertWin.show(Lang.msg("使用政令成功。得到{0}粮食", _arg_1.amount));
                        break;
                    case 3:
                        AlertWin.show(Lang.msg("使用政令成功。得到{0}数量的{1}兵种", _arg_1.amount, _arg_1.armyType));
                        break;
                    case 4:
                        AlertWin.show(Lang.msg("使用政令成功。裁去了该城池{0}数量的{1}兵种", _arg_1.amount, _arg_1.armyType));
                        break;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
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

        private function set comData(_arg_1:Array):void
        {
            var _local_2:Object = this._949173451comData;
            if (_local_2 !== _arg_1)
            {
                this._949173451comData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comData", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get strIntro():String
        {
            return (this._1765469883strIntro);
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

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            submitHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get comData2():Array
        {
            return (this._640394041comData2);
        }

        [Bindable(event="propertyChange")]
        private function get comData3():Array
        {
            return (this._640394040comData3);
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

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
            instancePopup = null;
        }

        [Bindable(event="propertyChange")]
        private function get policiesTimes():int
        {
            return (this._1269462998policiesTimes);
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

        private function set policiesTimes(_arg_1:int):void
        {
            var _local_2:Object = this._1269462998policiesTimes;
            if (_local_2 !== _arg_1)
            {
                this._1269462998policiesTimes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "policiesTimes", _local_2, _arg_1));
            };
        }

        private function submitHandle(_arg_1:MouseEvent):void
        {
            switch (actionCom.selectedIndex)
            {
                case 0:
                    ActionFactory.getInstance().getCapitalCommands().levyTaxes(Context.getInstance().getCurCastle().id, dstCastleId, policiesResponse);
                    if (this.parent != null)
                    {
                        PopUpManager.removePopUp(this);
                    };
                    return;
                case 3:
                    ActionFactory.getInstance().getCapitalCommands().levyArmy(Context.getInstance().getCurCastle().id, dstCastleId, policiesResponse);
                    if (this.parent != null)
                    {
                        PopUpManager.removePopUp(this);
                    };
                    return;
                case 4:
                    ActionFactory.getInstance().getCapitalCommands().reduceArmaments(Context.getInstance().getCurCastle().id, dstCastleId, policiesResponse);
                    if (this.parent != null)
                    {
                        PopUpManager.removePopUp(this);
                    };
                    return;
                case 1:
                    ActionFactory.getInstance().getCapitalCommands().levyPopulation(Context.getInstance().getCurCastle().id, dstCastleId, policiesResponse);
                    if (this.parent != null)
                    {
                        PopUpManager.removePopUp(this);
                    };
                    return;
                case 2:
                    ActionFactory.getInstance().getCapitalCommands().levyFood(Context.getInstance().getCurCastle().id, dstCastleId, policiesResponse);
                    if (this.parent != null)
                    {
                        PopUpManager.removePopUp(this);
                    };
                    return;
            };
        }

        private function _PoliciesView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("政令");
            _local_1 = comData;
            _local_1 = Lang.msg("使用");
            _local_1 = Lang.msg("功能取消");
        }

        [Bindable(event="propertyChange")]
        public function get actionCom():ComboBox
        {
            return (this._198268779actionCom);
        }

        private function set strIntro(_arg_1:String):void
        {
            var _local_2:Object = this._1765469883strIntro;
            if (_local_2 !== _arg_1)
            {
                this._1765469883strIntro = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strIntro", _local_2, _arg_1));
            };
        }


    }
}//package view.castle.world

