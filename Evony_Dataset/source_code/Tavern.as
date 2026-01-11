// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.tavern.Tavern

package view.module.tavern
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.guide.GuideArrow;
    import mx.collections.ArrayCollection;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import com.evony.common.beans.BuildingBean;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.common.beans.HeroBean;
    import mx.binding.BindingManager;
    import com.evony.client.response.ResponseDispatcher;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.core.ClassFactory;
    import mx.events.FlexEvent;
    import mx.binding.utils.BindingUtils;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import view.AllWindows;
    import com.evony.common.module.hero.HeroListResponse;
    import com.evony.common.module.CommandResponse;
    import view.module.guide.GuideStep;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import view.ui.AddFundWin;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.beans.CastleBean;
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

    public class Tavern extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Tavern.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1931793476recruidedArrow:GuideArrow;
        private var _95356390dataP:ArrayCollection;
        public var _Tavern_DataGrid1:DataGrid;
        public var _Tavern_Button1:Button;
        public var _Tavern_Button2:Button;
        private var _3019696bean:BuildingBean;
        public var _Tavern_DataGridColumn1:DataGridColumn;
        public var _Tavern_DataGridColumn2:DataGridColumn;
        public var _Tavern_DataGridColumn3:DataGridColumn;
        public var _Tavern_DataGridColumn4:DataGridColumn;
        public var _Tavern_DataGridColumn5:DataGridColumn;
        public var _Tavern_DataGridColumn7:DataGridColumn;
        public var _Tavern_DataGridColumn8:DataGridColumn;
        public var _Tavern_DataGridColumn6:DataGridColumn;
        private var cw:ChangeWatcher;
        private var curHeroStr:String;
        private var curRemianCount:int;
        private var _1132515501isShowFlag:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":0,
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_Tavern_Button1",
                                    "events":{"click":"___Tavern_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_Tavern_Button2",
                                    "events":{"click":"___Tavern_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":104,
                                            "height":25,
                                            "styleName":"b95",
                                            "y":5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_Tavern_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "32";
                                        this.left = "1";
                                        this.right = "1";
                                        this.bottom = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"auto",
                                            "sortableColumns":false,
                                            "selectable":false,
                                            "columns":[_Tavern_DataGridColumn1_i(), _Tavern_DataGridColumn2_i(), _Tavern_DataGridColumn3_i(), _Tavern_DataGridColumn4_i(), _Tavern_DataGridColumn5_i(), _Tavern_DataGridColumn6_i(), _Tavern_DataGridColumn7_i(), _Tavern_DataGridColumn8_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"recruidedArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "80";
                            this.right = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    })]});
            }
        });
        private var _925536925hireStr:String = Lang.msg("招募");
        private var hireHero:HireHero = new HireHero();
        private var subset:Array = new Array();
        private var fbobj:Object = new Object();
        private var heroList:Array = new Array();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Tavern()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("preinitialize", ___Tavern_BaseBuildingWindow1_preinitialize);
            this.addEventListener("creationComplete", ___Tavern_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Tavern._watcherSetupUtil = _arg_1;
        }


        public function onHireHero(_arg_1:Object):void
        {
            var _local_2:HeroBean;
            if (_arg_1.name == fbobj.newname)
            {
                trace(((this.className + ".onHireHero():") + _arg_1.name));
                _local_2 = (HeroBean(_arg_1) as HeroBean);
                HireHero.show(_local_2, curRemianCount, true, fbobj);
            }
            else
            {
                trace(((this.className + ".onHireHero():") + _arg_1.name));
                _local_2 = (HeroBean(_arg_1) as HeroBean);
                HireHero.show(_local_2, curRemianCount, false, fbobj);
            };
            curHeroStr = _local_2.name;
            recruidedArrow.visible = false;
        }

        private function _Tavern_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn3 = _local_1;
            _local_1.dataField = "management";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn3", _Tavern_DataGridColumn3);
            return (_local_1);
        }

        private function init():void
        {
            trace((this.className + " init()"));
            dataP = new ArrayCollection();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_GET_HEROS_LIST_FROM_TAVERN, onHerosListFromTavern);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_HIRE_HERO, onHireHeroResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_HIRE_FACEBOOK_FRIEND_HERO, onHireHeroResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_REFRESH_HEROS_LIST_FROM_TAVERN, onRefreshHeroList);
        }

        private function isUseHirePlot(_arg_1:MouseEvent):void
        {
            AlertWin.show(Lang.msg("是否使用招贤榜"), onUseHirePlot);
        }

        private function _Tavern_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn7 = _local_1;
            _local_1.dataField = "level";
            _local_1.labelFunction = itemChangeValue;
            _local_1.width = 130;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn7", _Tavern_DataGridColumn7);
            return (_local_1);
        }

        private function _Tavern_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Tavern_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___Tavern_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            initC();
        }

        public function set onBuildingStatusChange(_arg_1:int):void
        {
            if (bean != null)
            {
                this.refresh();
            };
        }

        private function initC():void
        {
            if (cw != null)
            {
                cw.unwatch();
            };
            cw = BindingUtils.bindProperty(this, "onBuildingStatusChange", bean, "level");
        }

        private function onUseHirePlot(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (hasItem())
                {
                    ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(Context.getInstance().getCurCastle().id);
                }
                else
                {
                    AlertWin.show(Lang.msg("物品不足确定购买"), doBuyItem, Lang.msg("确定"), Lang.msg("取消"));
                };
            };
        }

        public function set hireStr(_arg_1:String):void
        {
            var _local_2:Object = this._925536925hireStr;
            if (_local_2 !== _arg_1)
            {
                this._925536925hireStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hireStr", _local_2, _arg_1));
            };
        }

        private function onTavernNews(_arg_1:MouseEvent):void
        {
            if (isShowFlag)
            {
                AllWindows.switchToFuncWindow(TavernNewsWin.EVENT_SHOW);
            }
            else
            {
                AlertWin.show(Lang.msg("客栈等级不够"));
            };
        }

        private function _Tavern_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn2 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 55;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn2", _Tavern_DataGridColumn2);
            return (_local_1);
        }

        private function _Tavern_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn6 = _local_1;
            _local_1.dataField = "loyalty";
            _local_1.width = 70;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn6", _Tavern_DataGridColumn6);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get isShowFlag():Boolean
        {
            return (this._1132515501isShowFlag);
        }

        private function doAddCents(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                rechargeHandle();
            };
        }

        private function onHerosListFromTavern(_arg_1:HeroListResponse):void
        {
            trace(_arg_1.toDebugString((this.className + ".onHerosListFromTavern.")));
            dataP = this.FbInHeroList(_arg_1.herosArray);
            curRemianCount = _arg_1.posCount;
        }

        private function set bean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        public function ___Tavern_BaseBuildingWindow1_preinitialize(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onHireHeroResponse(_arg_1:CommandResponse):void
        {
            var _local_2:int;
            var _local_3:HeroBean;
            trace((this.className + "onHireHeroResponse:"));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = 0;
                while (_local_2 < dataP.length)
                {
                    _local_3 = dataP[_local_2];
                    if (_local_3.name == curHeroStr)
                    {
                        dataP.removeItemAt(_local_2);
                    };
                    _local_2++;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set recruidedArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1931793476recruidedArrow;
            if (_local_2 !== _arg_1)
            {
                this._1931793476recruidedArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "recruidedArrow", _local_2, _arg_1));
            };
        }

        private function _Tavern_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("招贤纳士");
            _local_1 = Lang.msg("市井传闻");
            _local_1 = dataP;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("内政");
            _local_1 = Lang.msg("勇武");
            _local_1 = Lang.msg("智谋");
            _local_1 = Lang.msg("忠诚");
            _local_1 = Lang.msg("招募费用");
            _local_1 = Lang.msg("行为");
            _local_1 = (GuideStep.getInstance().currentStep == 11);
            _local_1 = (GuideStep.getInstance().currentStep == 11);
        }

        private function _Tavern_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 120;
            _local_1.itemRenderer = _Tavern_ClassFactory1_c();
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn1", _Tavern_DataGridColumn1);
            return (_local_1);
        }

        private function itemChangeValue(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            var _local_3:String;
            return (String((_arg_1.level * 1000)));
        }

        override public function initialize():void
        {
            var target:Tavern;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Tavern_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_tavern_TavernWatcherSetupUtil");
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

        private function _Tavern_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn5 = _local_1;
            _local_1.dataField = "stratagem";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn5", _Tavern_DataGridColumn5);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get hireStr():String
        {
            return (this._925536925hireStr);
        }

        public function ___Tavern_Button1_click(_arg_1:MouseEvent):void
        {
            isUseHirePlot(_arg_1);
        }

        private function set isShowFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1132515501isShowFlag;
            if (_local_2 !== _arg_1)
            {
                this._1132515501isShowFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShowFlag", _local_2, _arg_1));
            };
        }

        private function _Tavern_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招贤纳士");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_Button1.label = _arg_1;
            }, "_Tavern_Button1.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("市井传闻");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_Button2.label = _arg_1;
            }, "_Tavern_Button2.label");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataP);
            }, function (_arg_1:Object):void
            {
                _Tavern_DataGrid1.dataProvider = _arg_1;
            }, "_Tavern_DataGrid1.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn1.headerText = _arg_1;
            }, "_Tavern_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn2.headerText = _arg_1;
            }, "_Tavern_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("内政");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn3.headerText = _arg_1;
            }, "_Tavern_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("勇武");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn4.headerText = _arg_1;
            }, "_Tavern_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn5.headerText = _arg_1;
            }, "_Tavern_DataGridColumn5.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("忠诚");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn6.headerText = _arg_1;
            }, "_Tavern_DataGridColumn6.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募费用");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn7.headerText = _arg_1;
            }, "_Tavern_DataGridColumn7.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("行为");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Tavern_DataGridColumn8.headerText = _arg_1;
            }, "_Tavern_DataGridColumn8.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 11);
            }, function (_arg_1:Boolean):void
            {
                recruidedArrow.includeInLayout = _arg_1;
            }, "recruidedArrow.includeInLayout");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 11);
            }, function (_arg_1:Boolean):void
            {
                recruidedArrow.visible = _arg_1;
            }, "recruidedArrow.visible");
            result[12] = binding;
            return (result);
        }

        private function rechargeHandle():void
        {
            AddFundWin.gotoPurchasePage();
        }

        [Bindable(event="propertyChange")]
        private function get bean():BuildingBean
        {
            return (this._3019696bean);
        }

        private function doBuyItem(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(Context.getInstance().getCurCastle().id);
            };
        }

        [Bindable(event="propertyChange")]
        public function get recruidedArrow():GuideArrow
        {
            return (this._1931793476recruidedArrow);
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        private function hasItem():Boolean
        {
            var _local_3:ItemBean;
            var _local_1:Boolean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_3 = Context.getInstance().getPlayerBean().getItems(_local_2);
                if (((_local_3.id == "consume.refreshtavern.1") && (_local_3.count > 0)))
                {
                    _local_1 = true;
                    break;
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function onRefreshHeroList(_arg_1:HeroListResponse):void
        {
            trace(_arg_1.toDebugString((this.className + "onRefreshHeroList")));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                dataP = this.FbInHeroList(_arg_1.herosArray);
            }
            else
            {
                if (_arg_1.errorMsg == "Insufficient game coins.")
                {
                    AlertWin.show(_arg_1.errorMsg, doAddCents, Lang.msg("元宝充值"), Lang.msg("取消"));
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function _Tavern_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn4 = _local_1;
            _local_1.dataField = "power";
            _local_1.width = 75;
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn4", _Tavern_DataGridColumn4);
            return (_local_1);
        }

        private function _Tavern_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Tavern_DataGridColumn8 = _local_1;
            _local_1.dataField = "level";
            _local_1.itemRenderer = _Tavern_ClassFactory2_c();
            BindingManager.executeBindings(this, "_Tavern_DataGridColumn8", _Tavern_DataGridColumn8);
            return (_local_1);
        }

        public function ___Tavern_Button2_click(_arg_1:MouseEvent):void
        {
            onTavernNews(_arg_1);
        }

        override public function refresh():void
        {
            super.refresh();
            this.bean = this.getBuildingBean();
            ActionFactory.getInstance().getHeroCommand().getHerosListFromTavern(Context.getInstance().getCurCastle().id);
            isShowFlag = ((this.bean.level >= 5) ? true : false);
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }

        private function _Tavern_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Tavern_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function FbInHeroList(_arg_1:ArrayCollection):ArrayCollection
        {
            var _local_3:CastleBean;
            var _local_4:Array;
            var _local_5:Object;
            var _local_6:HeroBean;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:Object;
            var _local_11:HeroBean;
            var _local_2:int = Context.getInstance().getPlayerBean().playerInfo.userId;
            if ((((Context.getInstance().facebookUser) && ((_local_2 % 10) == 3)) && ((_local_2 % 100) >= 50)))
            {
                this.heroList = [];
                for each (_local_3 in Context.getInstance().getPlayerBean().castlesArray)
                {
                    for each (_local_6 in _local_3.herosArray)
                    {
                        this.heroList.push(_local_6);
                    };
                };
                this.subset = [];
                _local_4 = Context.getInstance().FbFriendArr;
                for each (_local_5 in _local_4)
                {
                    this.subset.push(_local_5);
                };
                trace(this.subset);
                if (this.subset.length != 0)
                {
                    _local_7 = 0;
                    while (_local_7 < _local_4.length)
                    {
                        _local_9 = 0;
                        while (_local_9 < this.heroList.length)
                        {
                            _local_10 = _local_4[_local_7];
                            _local_11 = this.heroList[_local_9];
                            if (_local_10.name == _local_11.name)
                            {
                                this.subset.splice(_local_7, 1);
                            };
                            _local_9++;
                        };
                        _local_7++;
                    };
                    trace(this.subset);
                    _local_8 = int(Math.round((Math.random() * (this.subset.length - 1))));
                    this.fbobj.heroname = _arg_1[0].name;
                    this.fbobj.fbid = this.subset[_local_8].id;
                    _arg_1[0].name = this.subset[_local_8].name;
                    _arg_1[0].attack = (_arg_1[0].attack + 10);
                    _arg_1[0].politics = (_arg_1[0].politics + 10);
                    _arg_1[0].intelligence = (_arg_1[0].intelligence + 10);
                    _arg_1[0].loyalty = (_arg_1[0].loyalty + 10);
                    this.fbobj.firstid = _arg_1[0].id;
                    this.fbobj.newname = _arg_1[0].name;
                };
                return (_arg_1);
            };
            return (_arg_1);
        }

        override public function destroy():void
        {
        }


    }
}//package view.module.tavern

