// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.UICallEscape

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.TextArea;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.common.beans.HeroBean;
    import com.evony.client.action.ActionFactory;
    import com.evony.Lang;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.module.hero.HeroListResponse;
    import mx.events.PropertyChangeEvent;
    import mx.core.ClassFactory;
    import com.evony.common.module.CommandResponse;
    import mx.events.FlexEvent;
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

    public class UICallEscape extends Canvas implements IBindingClient 
    {

        public static var instance:UICallEscape = new (UICallEscape)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const baseGoldNeed:uint = 1000;
        private var _2036223254goldNeed:int = 0;
        public var _UICallEscape_DataGridColumn2:DataGridColumn;
        public var _UICallEscape_DataGridColumn3:DataGridColumn;
        public var _UICallEscape_DataGridColumn1:DataGridColumn;
        public var _UICallEscape_Label1:Label;
        private var medalName:String = "";
        private var _1691032677rewardNeed:int = 0;
        private var _1431327195dbHeros:DataGrid;
        private var _878845122txtInfo:TextArea;
        private var _2095520559playerInfo:PlayerInfoBean;
        private var selectedIndex:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":442,
                    "height":388,
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
                                    "id":"_UICallEscape_Label1",
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
                        "type":VBox,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":20,
                                "y":44,
                                "height":334,
                                "percentWidth":90,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"txtInfo",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText2",
                                            "percentWidth":100,
                                            "percentHeight":25,
                                            "editable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"dbHeros",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":75,
                                            "styleName":"style2",
                                            "rowHeight":30,
                                            "columns":[_UICallEscape_DataGridColumn1_i(), _UICallEscape_DataGridColumn2_i(), _UICallEscape_DataGridColumn3_i(), _UICallEscape_DataGridColumn4_c()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UICallEscape_Button1_click"},
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
        private var _695942811mArrHeros:ArrayCollection = new ArrayCollection([]);
        private var mArrHeroBean:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UICallEscape()
        {
            mx_internal::_document = this;
            this.width = 442;
            this.height = 388;
            this.addEventListener("creationComplete", ___UICallEscape_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UICallEscape._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
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
            };
            instance.reFresh();
        }


        private function _UICallEscape_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UICallEscape_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            BindingManager.executeBindings(this, "_UICallEscape_DataGridColumn1", _UICallEscape_DataGridColumn1);
            return (_local_1);
        }

        private function _UICallEscape_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UICallEscape_DataGridColumn3 = _local_1;
            _local_1.dataField = "loyalty";
            BindingManager.executeBindings(this, "_UICallEscape_DataGridColumn3", _UICallEscape_DataGridColumn3);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:UICallEscape;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UICallEscape_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_UICallEscapeWatcherSetupUtil");
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

        public function ___UICallEscape_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        private function get goldNeed():int
        {
            return (this._2036223254goldNeed);
        }

        private function onHeroPersuadeCallBack(_arg_1:Boolean):void
        {
            var _local_2:HeroBean;
            if (_arg_1)
            {
                _local_2 = mArrHeroBean[dbHeros.selectedIndex];
                ActionFactory.getInstance().getHeroCommand().recruitFleeHero(Context.getInstance().getCurCastle().id, _local_2.name, onHeroRecruitResponse);
            };
        }

        private function _UICallEscape_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("召回旧部");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UICallEscape_Label1.text = _arg_1;
            }, "_UICallEscape_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当你的城池黄金不足以支付英雄的薪水时，英雄逃跑后将会暂时出现英雄馆内的召回旧部列表。花费一定的黄金和奖章即可以召回你的英雄，没有及时召回的英雄忠诚值会逐渐下降。当英雄的忠诚值降到0时，你将失去召回他的机会。");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                txtInfo.text = _arg_1;
            }, "txtInfo.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (mArrHeros);
            }, function (_arg_1:Object):void
            {
                dbHeros.dataProvider = _arg_1;
            }, "dbHeros.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UICallEscape_DataGridColumn1.headerText = _arg_1;
            }, "_UICallEscape_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("级别");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UICallEscape_DataGridColumn2.headerText = _arg_1;
            }, "_UICallEscape_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("忠诚");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UICallEscape_DataGridColumn3.headerText = _arg_1;
            }, "_UICallEscape_DataGridColumn3.headerText");
            result[5] = binding;
            return (result);
        }

        private function _UICallEscape_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("召回旧部");
            _local_1 = Lang.msg("当你的城池黄金不足以支付英雄的薪水时，英雄逃跑后将会暂时出现英雄馆内的召回旧部列表。花费一定的黄金和奖章即可以召回你的英雄，没有及时召回的英雄忠诚值会逐渐下降。当英雄的忠诚值降到0时，你将失去召回他的机会。");
            _local_1 = mArrHeros;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("级别");
            _local_1 = Lang.msg("忠诚");
        }

        private function onUpdateFleeHero(_arg_1:HeroListResponse):void
        {
            var _local_3:HeroBean;
            var _local_4:Object;
            mArrHeros.removeAll();
            mArrHeroBean = _arg_1.herosArray;
            var _local_2:int;
            while (_local_2 < _arg_1.herosArray.length)
            {
                _local_3 = mArrHeroBean[_local_2];
                _local_4 = new Object();
                _local_4["name"] = _local_3.name;
                _local_4["level"] = _local_3.level;
                _local_4["loyalty"] = _local_3.loyalty;
                if (_local_3.level > 50)
                {
                    medalName = ItemEumDefine.getItemEum(_local_3.itemId).name;
                    rewardNeed = _local_3.itemAmount;
                };
                mArrHeros.addItem(_local_4);
                _local_2++;
            };
            if (mArrHeros.length > 0)
            {
            };
        }

        private function init():void
        {
        }

        public function set dbHeros(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1431327195dbHeros;
            if (_local_2 !== _arg_1)
            {
                this._1431327195dbHeros = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dbHeros", _local_2, _arg_1));
            };
        }

        internal function onBtnHeroPersuade(_arg_1:MouseEvent):void
        {
            goldNeed = (parseInt(dbHeros.selectedItem.level) * baseGoldNeed);
            AlertWin.show(Lang.msg("劝说你的英雄回归需要花费{0}黄金和{1}{2}奖章。", goldNeed, rewardNeed, medalName), onHeroPersuadeCallBack);
        }

        private function reFresh():void
        {
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            ActionFactory.getInstance().getHeroCommand().getFleeHeroList(Context.getInstance().getCurCastle().id, onUpdateFleeHero);
        }

        private function _UICallEscape_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.itemRenderer = _UICallEscape_ClassFactory1_c();
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        private function _UICallEscape_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _UICallEscape_DataGridColumn2 = _local_1;
            _local_1.dataField = "level";
            BindingManager.executeBindings(this, "_UICallEscape_DataGridColumn2", _UICallEscape_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get txtInfo():TextArea
        {
            return (this._878845122txtInfo);
        }

        private function set goldNeed(_arg_1:int):void
        {
            var _local_2:Object = this._2036223254goldNeed;
            if (_local_2 !== _arg_1)
            {
                this._2036223254goldNeed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldNeed", _local_2, _arg_1));
            };
        }

        private function set mArrHeros(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._695942811mArrHeros;
            if (_local_2 !== _arg_1)
            {
                this._695942811mArrHeros = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mArrHeros", _local_2, _arg_1));
            };
        }

        private function _UICallEscape_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = UICallEscape_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get dbHeros():DataGrid
        {
            return (this._1431327195dbHeros);
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        private function set rewardNeed(_arg_1:int):void
        {
            var _local_2:Object = this._1691032677rewardNeed;
            if (_local_2 !== _arg_1)
            {
                this._1691032677rewardNeed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rewardNeed", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get mArrHeros():ArrayCollection
        {
            return (this._695942811mArrHeros);
        }

        private function onHeroRecruitResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != 1)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                ActionFactory.getInstance().getHeroCommand().getFleeHeroList(Context.getInstance().getCurCastle().id, onUpdateFleeHero);
            };
        }

        public function ___UICallEscape_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get rewardNeed():int
        {
            return (this._1691032677rewardNeed);
        }

        public function set txtInfo(_arg_1:TextArea):void
        {
            var _local_2:Object = this._878845122txtInfo;
            if (_local_2 !== _arg_1)
            {
                this._878845122txtInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtInfo", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

