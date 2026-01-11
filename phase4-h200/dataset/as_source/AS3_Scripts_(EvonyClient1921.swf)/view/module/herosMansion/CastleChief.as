// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.CastleChief

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import com.evony.common.beans.HeroBean;
    import view.module.guide.GuideArrow;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.controls.ComboBox;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import view.ui.MyHRule;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import mx.managers.PopUpManager;
    import view.ui.AlertWin;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import view.module.guide.GuideStep;
    import flash.events.MouseEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.Lang;
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

    public class CastleChief extends Canvas implements IBindingClient 
    {

        public static var instance:CastleChief;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CastleChief_Button1:Button;
        public var _CastleChief_Button2:Button;
        public var _CastleChief_TextArea1:TextArea;
        public var _CastleChief_TextArea2:TextArea;
        private var _811312001heroMes:HeroBean;
        public var _CastleChief_GuideArrow1:GuideArrow;
        public var _CastleChief_Text1:Text;
        public var _CastleChief_Label1:Label;
        private var _1826131045heroFreeCB:ComboBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":172,
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
                                    "id":"_CastleChief_Label1",
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
                        "id":"_CastleChief_Button1",
                        "events":{"click":"___CastleChief_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "18";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":231,
                                "width":75,
                                "height":25,
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_CastleChief_Button2",
                        "events":{"click":"___CastleChief_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "18";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":317,
                                "width":75,
                                "height":25,
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":32,
                                "y":53,
                                "width":370,
                                "height":70,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 2;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":1,
                                            "width":366,
                                            "height":27,
                                            "x":1,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_CastleChief_TextArea1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":26,
                                                        "styleName":"focusColor",
                                                        "editable":false,
                                                        "selectable":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_CastleChief_TextArea2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":26,
                                                        "styleName":"focusColor",
                                                        "editable":false,
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_CastleChief_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":1,
                                            "y":33,
                                            "width":182,
                                            "height":21,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"heroFreeCB",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":185,
                                            "y":31,
                                            "width":181,
                                            "height":25,
                                            "styleName":"ComboBox"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "1";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":98});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CastleChief_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_CastleChief_GuideArrow1",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "32";
                            this.right = "51";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    })]
                });
            }
        });
        private var _1729380540heroFreeList:ArrayCollection = new ArrayCollection();
        private var _1130461832heroBeanList:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleChief()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 172;
            this.addEventListener("creationComplete", ___CastleChief_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleChief._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object, _arg_2:ArrayCollection):void
        {
            if (instance == null)
            {
                instance = new (CastleChief)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.heroMes = HeroBean(_arg_1);
            instance._heroFreeList = _arg_2;
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

        private function set heroFreeList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1729380540heroFreeList;
            if (_local_2 !== _arg_1)
            {
                this._1729380540heroFreeList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroFreeList", _local_2, _arg_1));
            };
        }

        private function onPromoteToCHief(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                PopUpManager.removePopUp(this);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroBeanList():ArrayCollection
        {
            return (this._1130461832heroBeanList);
        }

        override public function initialize():void
        {
            var target:CastleChief;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleChief_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_CastleChiefWatcherSetupUtil");
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

        private function onHireChief(_arg_1:MouseEvent):void
        {
            var _local_2:HeroBean;
            var _local_3:int;
            while (_local_3 < heroBeanList.length)
            {
                _local_2 = heroBeanList[_local_3];
                if (_local_2.name == this.heroFreeCB.selectedLabel) break;
                _local_3++;
            };
            ActionFactory.getInstance().getHeroCommand().promoteToChief(Context.getInstance().getCurCastle().id, _local_2.id);
            GuideStep.getInstance().step12();
        }

        public function ___CastleChief_Button3_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        private function onExit():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___CastleChief_Button1_click(_arg_1:MouseEvent):void
        {
            onFireChief(_arg_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_DISCHARGE_CHIEF, onDischarchChief);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_PROMOTE_TO_CHIEF, onPromoteToCHief);
        }

        private function onFireChief(_arg_1:MouseEvent):void
        {
            ActionFactory.getInstance().getHeroCommand().dischargeChief(Context.getInstance().getCurCastle().id);
        }

        private function set heroBeanList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1130461832heroBeanList;
            if (_local_2 !== _arg_1)
            {
                this._1130461832heroBeanList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroBeanList", _local_2, _arg_1));
            };
        }

        private function onDischarchChief(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                PopUpManager.removePopUp(this);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroFreeList():ArrayCollection
        {
            return (this._1729380540heroFreeList);
        }

        public function set _heroFreeList(_arg_1:ArrayCollection):void
        {
            var _local_3:HeroBean;
            heroBeanList = _arg_1;
            heroFreeList.removeAll();
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = _arg_1[_local_2];
                heroFreeList.addItem({
                    "label":_local_3.name,
                    "data":_local_2
                });
                _local_2++;
            };
        }

        public function set heroFreeCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1826131045heroFreeCB;
            if (_local_2 !== _arg_1)
            {
                this._1826131045heroFreeCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroFreeCB", _local_2, _arg_1));
            };
        }

        public function ___CastleChief_Button2_click(_arg_1:MouseEvent):void
        {
            onHireChief(_arg_1);
        }

        private function _CastleChief_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更换城守");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_Label1.text = _arg_1;
            }, "_CastleChief_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_Button1.label = _arg_1;
            }, "_CastleChief_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任命");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_Button2.label = _arg_1;
            }, "_CastleChief_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroFreeList.length > 0);
            }, function (_arg_1:Boolean):void
            {
                _CastleChief_Button2.enabled = _arg_1;
            }, "_CastleChief_Button2.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前城守");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_TextArea1.text = _arg_1;
            }, "_CastleChief_TextArea1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任命将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_TextArea2.text = _arg_1;
            }, "_CastleChief_TextArea2.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleChief_Text1.text = _arg_1;
            }, "_CastleChief_Text1.text");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroFreeList);
            }, function (_arg_1:Object):void
            {
                heroFreeCB.dataProvider = _arg_1;
            }, "heroFreeCB.dataProvider");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 12);
            }, function (_arg_1:Boolean):void
            {
                _CastleChief_GuideArrow1.includeInLayout = _arg_1;
            }, "_CastleChief_GuideArrow1.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 12);
            }, function (_arg_1:Boolean):void
            {
                _CastleChief_GuideArrow1.visible = _arg_1;
            }, "_CastleChief_GuideArrow1.visible");
            result[9] = binding;
            return (result);
        }

        private function _CastleChief_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("更换城守");
            _local_1 = Lang.msg("解除");
            _local_1 = Lang.msg("任命");
            _local_1 = (heroFreeList.length > 0);
            _local_1 = Lang.msg("当前城守");
            _local_1 = Lang.msg("任命将领");
            _local_1 = heroMes.name;
            _local_1 = heroFreeList;
            _local_1 = (GuideStep.getInstance().currentStep == 12);
            _local_1 = (GuideStep.getInstance().currentStep == 12);
        }

        [Bindable(event="propertyChange")]
        public function get heroFreeCB():ComboBox
        {
            return (this._1826131045heroFreeCB);
        }

        public function ___CastleChief_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.herosMansion

