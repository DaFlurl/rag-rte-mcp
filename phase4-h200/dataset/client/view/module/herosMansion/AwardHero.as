// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.AwardHero

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.Label;
    import mx.controls.ComboBox;
    import com.evony.common.beans.HeroBean;
    import mx.controls.TextArea;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import view.ui.AddFundWin;
    import mx.binding.BindingManager;
    import com.evony.client.response.ResponseDispatcher;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import mx.events.FlexEvent;
    import com.evony.Lang;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.beans.ItemBean;
    import com.evony.factory.ItemManager;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import mx.events.DropdownEvent;
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

    public class AwardHero extends Canvas implements IBindingClient 
    {

        public static var instance:AwardHero;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _250870057awardItemArray:ArrayCollection;
        public var _AwardHero_Label1:Label;
        public var _AwardHero_Label3:Label;
        public var _AwardHero_Label4:Label;
        public var _AwardHero_Label5:Label;
        public var _AwardHero_Label2:Label;
        private var _1457316394awardTypeCB:ComboBox;
        private var _811312001heroMes:HeroBean;
        public var _AwardHero_TextArea3:TextArea;
        public var _AwardHero_DataGrid1:DataGrid;
        public var _AwardHero_TextArea1:TextArea;
        public var _AwardHero_TextArea2:TextArea;
        public var _AwardHero_DataGridColumn1:DataGridColumn;
        public var _AwardHero_DataGridColumn2:DataGridColumn;
        private var _1645749137itemDescText:TextArea;
        private var _1621978433awardBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":360,
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
                                    "id":"_AwardHero_Label1",
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
                        "type":DataGrid,
                        "id":"_AwardHero_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.top = "33";
                            this.left = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "height":130,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_AwardHero_DataGridColumn1_i(), _AwardHero_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.left = "20";
                            this.top = "168";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":110,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AwardHero_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName2",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AwardHero_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName2",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AwardHero_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "72";
                                        this.textAlign = "right";
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName2",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_AwardHero_TextArea1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "80";
                                        this.right = "10";
                                        this.textAlign = "center";
                                        this.top = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "editable":false,
                                            "styleName":"PropertyValue2",
                                            "height":21,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_AwardHero_TextArea2",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "80";
                                        this.top = "40";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "editable":false,
                                            "width":95,
                                            "styleName":"PropertyValue2",
                                            "height":21,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_AwardHero_TextArea3",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "editable":false,
                                            "styleName":"PropertyValue2",
                                            "height":21,
                                            "width":95,
                                            "x":280,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AwardHero_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                        this.textAlign = "right";
                                        this.left = "200";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyName2",
                                            "width":80
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"awardBtn",
                                    "events":{"click":"__awardBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "13";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":95,
                                            "height":25,
                                            "styleName":"b95"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"awardTypeCB",
                                    "events":{"close":"__awardTypeCB_close"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "72";
                                        this.left = "80";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":180,
                                            "height":22
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"itemDescText",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":55,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AwardHero_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1268360731itemArrayCB:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AwardHero()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 360;
            this.addEventListener("creationComplete", ___AwardHero_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AwardHero._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:HeroBean):void
        {
            if (instance == null)
            {
                instance = new (AwardHero)();
            };
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
            };
            PopUpManager.centerPopUp(instance);
            instance.heroMes = _arg_1;
            instance.addAwardItemArray(_arg_1);
        }


        [Bindable(event="propertyChange")]
        private function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        private function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        private function set itemArrayCB(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1268360731itemArrayCB;
            if (_local_2 !== _arg_1)
            {
                this._1268360731itemArrayCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArrayCB", _local_2, _arg_1));
            };
        }

        public function set awardBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1621978433awardBtn;
            if (_local_2 !== _arg_1)
            {
                this._1621978433awardBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "awardBtn", _local_2, _arg_1));
            };
        }

        private function doExpenseGoods(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (((awardTypeCB.selectedItem.data == "gold") || (awardTypeCB.selectedItem.data == "jewelry")))
                {
                    ActionFactory.getInstance().getHeroCommand().useItem(Context.getInstance().getCurCastle().id, heroMes.id, awardTypeCB.selectedItem.data, onAwardItem);
                }
                else
                {
                    if (UIUtil.checkItem(awardTypeCB.selectedItem.data, 1))
                    {
                        ActionFactory.getInstance().getHeroCommand().useItem(Context.getInstance().getCurCastle().id, heroMes.id, awardTypeCB.selectedItem.data, onAwardItem);
                    }
                    else
                    {
                        AddFundWin.show();
                    };
                };
            };
        }

        private function _AwardHero_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AwardHero_DataGridColumn2 = _local_1;
            _local_1.dataField = "endTime";
            _local_1.itemRenderer = _AwardHero_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AwardHero_DataGridColumn2", _AwardHero_DataGridColumn2);
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_AWARD_GOLD, onAwardGold);
        }

        [Bindable(event="propertyChange")]
        public function get itemDescText():TextArea
        {
            return (this._1645749137itemDescText);
        }

        override public function initialize():void
        {
            var target:AwardHero;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AwardHero_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_AwardHeroWatcherSetupUtil");
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

        private function _AwardHero_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AwardHero_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onExit():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___AwardHero_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set itemDescText(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1645749137itemDescText;
            if (_local_2 !== _arg_1)
            {
                this._1645749137itemDescText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemDescText", _local_2, _arg_1));
            };
        }

        public function addAwardItemArray(_arg_1:HeroBean):void
        {
            itemArrayCB.removeAll();
            if (_arg_1.isHero != 2)
            {
                itemArrayCB.addItem({
                    "label":Lang.msg("黄金"),
                    "data":"gold"
                });
            };
            itemArrayCB.addItem({
                "label":ItemEumDefine.getItemEum("hero.intelligence.1").name,
                "data":"hero.intelligence.1"
            });
            itemArrayCB.addItem({
                "label":ItemEumDefine.getItemEum("hero.management.1").name,
                "data":"hero.management.1"
            });
            itemArrayCB.addItem({
                "label":ItemEumDefine.getItemEum("hero.power.1").name,
                "data":"hero.power.1"
            });
            if (_arg_1.isHero != 2)
            {
                itemArrayCB.addItem({
                    "label":Lang.msg("珠宝"),
                    "data":"jewelry"
                });
            };
        }

        private function _AwardHero_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("赏赐英雄");
            _local_1 = heroMes.buffsArray;
            _local_1 = Lang.msg("名称");
            _local_1 = Lang.msg("持续时间");
            _local_1 = (Lang.msg("名字") + ": ");
            _local_1 = (Lang.msg("等级") + ": ");
            _local_1 = (Lang.msg("赏赐") + ": ");
            _local_1 = heroMes.name;
            _local_1 = heroMes.level;
            _local_1 = ((heroMes.isHero == 2) ? "--" : heroMes.loyalty);
            _local_1 = (Lang.msg("忠诚") + ": ");
            _local_1 = Lang.msg("赏赐");
            _local_1 = itemArrayCB;
            _local_1 = Lang.msg("赏赐英雄{0}", (heroMes.level * 100));
        }

        [Bindable(event="propertyChange")]
        private function get awardItemArray():ArrayCollection
        {
            return (this._250870057awardItemArray);
        }

        private function onAwardGold(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("赏赐成功"));
                PopUpManager.removePopUp(this);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get awardBtn():Button
        {
            return (this._1621978433awardBtn);
        }

        public function set awardTypeCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1457316394awardTypeCB;
            if (_local_2 !== _arg_1)
            {
                this._1457316394awardTypeCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "awardTypeCB", _local_2, _arg_1));
            };
        }

        private function _AwardHero_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AwardHero_DataGridColumn1 = _local_1;
            _local_1.dataField = "descName";
            _local_1.width = 280;
            BindingManager.executeBindings(this, "_AwardHero_DataGridColumn1", _AwardHero_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get awardTypeCB():ComboBox
        {
            return (this._1457316394awardTypeCB);
        }

        private function hasJewelry():ArrayCollection
        {
            var _local_6:ItemBean;
            var _local_7:int;
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().itemsArray;
            var _local_2:ArrayCollection = ItemManager.jewelryItemArray;
            var _local_3:ArrayCollection = new ArrayCollection();
            var _local_4:int;
            while (_local_4 < _local_1.length)
            {
                _local_6 = ItemBean(_local_1[_local_4]);
                _local_7 = 0;
                while (_local_7 < _local_2.length)
                {
                    if (((_local_6.id == _local_2[_local_7]) && (_local_6.count > 0)))
                    {
                        _local_3.addItem(ItemBean(_local_1[_local_4]).id);
                        break;
                    };
                    _local_7++;
                };
                _local_4++;
            };
            var _local_5:Sort = new Sort();
            _local_5.fields = [new SortField()];
            _local_3.sort = _local_5;
            _local_3.refresh();
            return (_local_3);
        }

        private function onAwardHero():void
        {
            trace((this.className + " onAwardHero "));
            if (awardTypeCB.selectedItem.data == "gold")
            {
                ActionFactory.getInstance().getHeroCommand().awardGold(Context.getInstance().getCurCastle().id, heroMes.id);
            }
            else
            {
                if (awardTypeCB.selectedItem.data == "jewelry")
                {
                    if (hasJewelry().length > 0)
                    {
                        AwardJewelry.show(hasJewelry(), heroMes);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("缺乏可赏赐的珠宝"));
                    };
                }
                else
                {
                    if (hasGoods(awardTypeCB.selectedItem.data))
                    {
                        ActionFactory.getInstance().getHeroCommand().useItem(Context.getInstance().getCurCastle().id, heroMes.id, awardTypeCB.selectedItem.data, onAwardItem);
                        PopUpManager.removePopUp(this);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("物品不足确定购买"), doExpenseGoods);
                    };
                };
            };
        }

        private function hasGoods(_arg_1:String):Boolean
        {
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().itemsArray;
            var _local_3:Boolean;
            var _local_4:int;
            while (_local_4 < _local_2.length)
            {
                if (((_arg_1 == ItemBean(_local_2[_local_4]).id) && (ItemBean(_local_2[_local_4]).count > 0)))
                {
                    _local_3 = true;
                    break;
                };
                _local_4++;
            };
            return (_local_3);
        }

        private function onItemChange():void
        {
            switch (awardTypeCB.selectedItem.data)
            {
                case "gold":
                    itemDescText.text = Lang.msg("赏赐英雄{0}", (heroMes.level * 100));
                    return;
                case "jewelry":
                    itemDescText.text = Lang.msg("赏赐英雄珠宝");
                    return;
                default:
                    itemDescText.text = ItemEumDefine.getItemEum(awardTypeCB.selectedItem.data).desc;
            };
        }

        public function __awardBtn_click(_arg_1:MouseEvent):void
        {
            onAwardHero();
        }

        public function ___AwardHero_Button2_click(_arg_1:MouseEvent):void
        {
            onExit();
        }

        private function set awardItemArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._250870057awardItemArray;
            if (_local_2 !== _arg_1)
            {
                this._250870057awardItemArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "awardItemArray", _local_2, _arg_1));
            };
        }

        private function onAwardItem(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", awardTypeCB.selectedItem.data, awardTypeCB.selectedItem.label, ItemEumDefine.getItemEum(awardTypeCB.selectedItem.data).itemType, ItemEumDefine.getItemEum(awardTypeCB.selectedItem.data).price);
                };
                AlertWin.show(Lang.msg("赏赐成功"));
                PopUpManager.removePopUp(this);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemArrayCB():ArrayCollection
        {
            return (this._1268360731itemArrayCB);
        }

        private function _AwardHero_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_Label1.text = _arg_1;
            }, "_AwardHero_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroMes.buffsArray);
            }, function (_arg_1:Object):void
            {
                _AwardHero_DataGrid1.dataProvider = _arg_1;
            }, "_AwardHero_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_DataGridColumn1.headerText = _arg_1;
            }, "_AwardHero_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("持续时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_DataGridColumn2.headerText = _arg_1;
            }, "_AwardHero_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("名字") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_Label2.text = _arg_1;
            }, "_AwardHero_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_Label3.text = _arg_1;
            }, "_AwardHero_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("赏赐") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_Label4.text = _arg_1;
            }, "_AwardHero_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_TextArea1.text = _arg_1;
            }, "_AwardHero_TextArea1.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_TextArea2.text = _arg_1;
            }, "_AwardHero_TextArea2.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.isHero == 2) ? "--" : heroMes.loyalty);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_TextArea3.text = _arg_1;
            }, "_AwardHero_TextArea3.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("忠诚") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AwardHero_Label5.text = _arg_1;
            }, "_AwardHero_Label5.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                awardBtn.label = _arg_1;
            }, "awardBtn.label");
            result[11] = binding;
            binding = new Binding(this, function ():Object
            {
                return (itemArrayCB);
            }, function (_arg_1:Object):void
            {
                awardTypeCB.dataProvider = _arg_1;
            }, "awardTypeCB.dataProvider");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐英雄{0}", (heroMes.level * 100));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                itemDescText.text = _arg_1;
            }, "itemDescText.text");
            result[13] = binding;
            return (result);
        }

        public function __awardTypeCB_close(_arg_1:DropdownEvent):void
        {
            onItemChange();
        }


    }
}//package view.module.herosMansion

