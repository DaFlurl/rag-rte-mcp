// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.heroview.ChooseHeroItemWin

package autoevony.gui.heroview
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.Label;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.controls.ComboBox;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import autoevony.common.Items;
    import com.evony.common.beans.ItemBean;
    import autoevony.gui.MainScreen;
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

    public class ChooseHeroItemWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _971377469itemSelectInfo:ArrayCollection = null;
        public var _ChooseHeroItemWin_Button1:Button;
        private var closeFunc:Function = null;
        public var _ChooseHeroItemWin_Label1:Label;
        private var _2014132310heroLevel:int;
        private var useFunc:Function = null;
        private var _2025600524_baseWin:PopUpWinBase;
        private var _1220405362_itemSelect:ComboBox;
        public var _ChooseHeroItemWin_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":200,
                    "width":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "id":"_baseWin",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":""});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.top = "50";
                            this.bottom = "15";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "0";
                                        this.right = "0";
                                        this.bottom = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ChooseHeroItemWin_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "5";
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"newArmyTroop"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ChooseHeroItemWin_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"newArmyTroop"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.right = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":35,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "110";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"_itemSelect",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":180,
                                                                    "height":22,
                                                                    "styleName":"ComboBox"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "3";
                                                    this.right = "5";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":95,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_ChooseHeroItemWin_Button1",
                                                            "events":{"click":"___ChooseHeroItemWin_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Give Item",
                                                                    "styleName":"REwinBtn"
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
                        "type":Button,
                        "events":{"click":"___ChooseHeroItemWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ChooseHeroItemWin()
        {
            mx_internal::_document = this;
            this.height = 200;
            this.width = 400;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ChooseHeroItemWin._watcherSetupUtil = _arg_1;
        }


        private function set itemSelectInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._971377469itemSelectInfo;
            if (_local_2 !== _arg_1)
            {
                this._971377469itemSelectInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemSelectInfo", _local_2, _arg_1));
            };
        }

        public function ___ChooseHeroItemWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.onUseBtn();
        }

        public function ___ChooseHeroItemWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        [Bindable(event="propertyChange")]
        private function get itemSelectInfo():ArrayCollection
        {
            return (this._971377469itemSelectInfo);
        }

        private function _ChooseHeroItemWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._itemSelect.selectedItem.data != "gold") ? Items.getItemEumById(this._itemSelect.selectedItem.data).desc : (("Reward hero with " + (this.heroLevel * 100)) + " Gold to increase his/her Loyalty by 5."));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChooseHeroItemWin_Text1.text = _arg_1;
            }, "_ChooseHeroItemWin_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._itemSelect.selectedItem.data != "gold") ? Items.getItemEumById(this._itemSelect.selectedItem.data).itemDesc : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChooseHeroItemWin_Text1.toolTip = _arg_1;
            }, "_ChooseHeroItemWin_Text1.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._itemSelect.selectedItem.data != "gold") ? ("You own: " + this.getItemCount(this._itemSelect.selectedItem.data)) : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChooseHeroItemWin_Label1.text = _arg_1;
            }, "_ChooseHeroItemWin_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.itemSelectInfo);
            }, function (_arg_1:Object):void
            {
                _itemSelect.dataProvider = _arg_1;
            }, "_itemSelect.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.getItemCount(this._itemSelect.selectedItem.data) > 0) || (this._itemSelect.selectedItem.data == "gold"));
            }, function (_arg_1:Boolean):void
            {
                _ChooseHeroItemWin_Button1.enabled = _arg_1;
            }, "_ChooseHeroItemWin_Button1.enabled");
            result[4] = binding;
            return (result);
        }

        private function getItemCount(_arg_1:String):int
        {
            var _local_2:ItemBean;
            for each (_local_2 in MainScreen.getPlayer().itemsArray)
            {
                if (((!(_local_2.id == null)) && (_local_2.id == _arg_1)))
                {
                    return (Math.max(_local_2.count, 0));
                };
            };
            return (0);
        }

        [Bindable(event="propertyChange")]
        public function get _itemSelect():ComboBox
        {
            return (this._1220405362_itemSelect);
        }

        override public function initialize():void
        {
            var target:ChooseHeroItemWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ChooseHeroItemWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_heroview_ChooseHeroItemWinWatcherSetupUtil");
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
        public function get _baseWin():PopUpWinBase
        {
            return (this._2025600524_baseWin);
        }

        private function onUseBtn():void
        {
            this.useFunc.apply(null, [this._itemSelect.selectedItem.data]);
            this.close();
        }

        public function updateInfo(_arg_1:String, _arg_2:Object, _arg_3:Function=null):void
        {
            this._baseWin.windowTitle = _arg_1;
            switch (_arg_1)
            {
                case "Educate Hero":
                    this.itemSelectInfo = new ArrayCollection([{
                        "label":Items.getItemName("player.experience.1.a").split("_").join(" "),
                        "data":"player.experience.1.a"
                    }, {
                        "label":Items.getItemName("player.experience.1.b").split("_").join(" "),
                        "data":"player.experience.1.b"
                    }, {
                        "label":Items.getItemName("player.experience.1.c").split("_").join(" "),
                        "data":"player.experience.1.c"
                    }]);
                    break;
                case "Reward Hero":
                    this.itemSelectInfo = new ArrayCollection([{
                        "label":"Gold",
                        "data":"gold"
                    }, {
                        "label":Items.getItemName("hero.loyalty.1").split("_").join(" "),
                        "data":"hero.loyalty.1"
                    }, {
                        "label":Items.getItemName("hero.loyalty.2").split("_").join(" "),
                        "data":"hero.loyalty.2"
                    }, {
                        "label":Items.getItemName("hero.loyalty.3").split("_").join(" "),
                        "data":"hero.loyalty.3"
                    }, {
                        "label":Items.getItemName("hero.loyalty.4").split("_").join(" "),
                        "data":"hero.loyalty.4"
                    }, {
                        "label":Items.getItemName("hero.loyalty.5").split("_").join(" "),
                        "data":"hero.loyalty.5"
                    }, {
                        "label":Items.getItemName("hero.loyalty.6").split("_").join(" "),
                        "data":"hero.loyalty.6"
                    }, {
                        "label":Items.getItemName("hero.loyalty.7").split("_").join(" "),
                        "data":"hero.loyalty.7"
                    }, {
                        "label":Items.getItemName("hero.loyalty.8").split("_").join(" "),
                        "data":"hero.loyalty.8"
                    }, {
                        "label":Items.getItemName("hero.loyalty.9").split("_").join(" "),
                        "data":"hero.loyalty.9"
                    }]);
                    break;
                case "Recuperate Hero":
                    this.itemSelectInfo = new ArrayCollection([{
                        "label":Items.getItemName("hero.item.Tea").split("_").join(" "),
                        "data":"hero.item.Tea"
                    }, {
                        "label":Items.getItemName("hero.item.Lugui_Wine").split("_").join(" "),
                        "data":"hero.item.Lugui_Wine"
                    }, {
                        "label":Items.getItemName("hero.item.Panax_ginseng").split("_").join(" "),
                        "data":"hero.item.Panax_ginseng"
                    }, {
                        "label":Items.getItemName("hero.item.Essential_Oil").split("_").join(" "),
                        "data":"hero.item.Essential_Oil"
                    }]);
                    break;
                case "Award Hero":
                    this.itemSelectInfo = new ArrayCollection([{
                        "label":Items.getItemName("hero.management.1").split("_").join(" "),
                        "data":"hero.management.1"
                    }, {
                        "label":Items.getItemName("hero.power.1").split("_").join(" "),
                        "data":"hero.power.1"
                    }, {
                        "label":Items.getItemName("hero.intelligence.1").split("_").join(" "),
                        "data":"hero.intelligence.1"
                    }]);
                    break;
            };
            this.heroLevel = _arg_2.hLevel;
            this.useFunc = _arg_2.func;
            this.closeFunc = _arg_3;
        }

        public function set _itemSelect(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1220405362_itemSelect;
            if (_local_2 !== _arg_1)
            {
                this._1220405362_itemSelect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemSelect", _local_2, _arg_1));
            };
        }

        private function _ChooseHeroItemWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this._itemSelect.selectedItem.data != "gold") ? Items.getItemEumById(this._itemSelect.selectedItem.data).desc : (("Reward hero with " + (this.heroLevel * 100)) + " Gold to increase his/her Loyalty by 5."));
            _local_1 = ((this._itemSelect.selectedItem.data != "gold") ? Items.getItemEumById(this._itemSelect.selectedItem.data).itemDesc : "");
            _local_1 = ((this._itemSelect.selectedItem.data != "gold") ? ("You own: " + this.getItemCount(this._itemSelect.selectedItem.data)) : "");
            _local_1 = this.itemSelectInfo;
            _local_1 = ((this.getItemCount(this._itemSelect.selectedItem.data) > 0) || (this._itemSelect.selectedItem.data == "gold"));
        }

        public function set _baseWin(_arg_1:PopUpWinBase):void
        {
            var _local_2:Object = this._2025600524_baseWin;
            if (_local_2 !== _arg_1)
            {
                this._2025600524_baseWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_baseWin", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroLevel():int
        {
            return (this._2014132310heroLevel);
        }

        private function set heroLevel(_arg_1:int):void
        {
            var _local_2:Object = this._2014132310heroLevel;
            if (_local_2 !== _arg_1)
            {
                this._2014132310heroLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _local_2, _arg_1));
            };
        }

        private function close():void
        {
            if (this.itemSelectInfo != null)
            {
                this.itemSelectInfo.removeAll();
                this.itemSelectInfo = null;
            };
            if (this.useFunc != null)
            {
                this.useFunc = null;
            };
            this.closeFunc.apply(null, [this]);
        }


    }
}//package autoevony.gui.heroview

