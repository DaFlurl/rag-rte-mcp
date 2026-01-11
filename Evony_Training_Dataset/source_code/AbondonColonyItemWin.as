// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AbondonColonyItemWin

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.ItemEum;
    import com.evony.common.beans.ColonyBean;
    import mx.containers.VBox;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import view.ui.ItemUI;
    import com.evony.eum.ItemEumDefine;
    import com.evony.events.ItemSelectEvent;
    import com.evony.common.beans.ItemBean;
    import com.evony.Context;
    import com.evony.common.module.CommandResponse;
    import com.evony.MsgDispacther;
    import flash.events.Event;
    import view.ui.AlertWin;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import view.ui.AddFundWin;
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

    public class AbondonColonyItemWin extends Canvas implements IBindingClient 
    {

        private static var instance:AbondonColonyItemWin = new (AbondonColonyItemWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var selectedItem:ItemEum;
        private var targetBean:ColonyBean;
        private var _1177154070itemHbox:VBox;
        public var _AbondonColonyItemWin_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":400,
                    "width":610,
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
                                    "id":"_AbondonColonyItemWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":6,
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
                            this.top = "50";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"itemHbox",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.verticalGap = 2;
                                        this.right = "0";
                                        this.bottom = "0";
                                        this.top = "0";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AbondonColonyItemWin_Button1_click"},
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
        private var owerItemArray:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AbondonColonyItemWin()
        {
            mx_internal::_document = this;
            this.height = 400;
            this.width = 610;
            this.addEventListener("creationComplete", ___AbondonColonyItemWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AbondonColonyItemWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:ArrayCollection, _arg_2:ColonyBean):void
        {
            instance.owerItemArray = _arg_1;
            instance.targetBean = _arg_2;
            instance.height = ((_arg_1.length * 62) + 80);
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.onShowEvent();
        }


        public function ___AbondonColonyItemWin_Button1_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function _AbondonColonyItemWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AbondonColonyItemWin_Label1.text = _arg_1;
            }, "_AbondonColonyItemWin_Label1.text");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:AbondonColonyItemWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AbondonColonyItemWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AbondonColonyItemWinWatcherSetupUtil");
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

        public function set itemHbox(_arg_1:VBox):void
        {
            var _local_2:Object = this._1177154070itemHbox;
            if (_local_2 !== _arg_1)
            {
                this._1177154070itemHbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemHbox", _local_2, _arg_1));
            };
        }

        private function refresh():void
        {
            var _local_2:String;
            var _local_3:ItemEum;
            var _local_4:ItemUI;
            this.itemHbox.removeAllChildren();
            this.uiCache.reset();
            var _local_1:int;
            while (_local_1 < this.owerItemArray.length)
            {
                _local_2 = owerItemArray[_local_1];
                _local_3 = ItemEumDefine.getItemEum(_local_2);
                _local_4 = (this.uiCache.getUI(ItemUI) as ItemUI);
                _local_4.itemEum = _local_3;
                _local_4.bean = this.getItemBeanFromPlayer(_local_3.id);
                if (!_local_4.hasEventListener(ItemSelectEvent.NAME))
                {
                    _local_4.addEventListener(ItemSelectEvent.NAME, onSelect);
                };
                this.itemHbox.addChild(_local_4);
                _local_1++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemHbox():VBox
        {
            return (this._1177154070itemHbox);
        }

        private function init():void
        {
            this.refresh();
        }

        private function getItemBeanFromPlayer(_arg_1:String):ItemBean
        {
            var _local_3:ItemBean;
            var _local_2:ItemBean;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1)
                {
                    _local_2 = _local_3;
                };
            };
            return (_local_2);
        }

        private function onAbondon(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                MinePopupManager.instance.removePopup();
                MsgDispacther.getInstance().dispatchEvent(new Event(ColonyAbandonUI.ABAMDON_TIME_END));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _AbondonColonyItemWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("请选择");
        }

        public function ___AbondonColonyItemWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function close():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function onSelect(_arg_1:ItemSelectEvent):void
        {
            trace((((this.className + ".onSelect(") + _arg_1.item.name) + ")"));
            if (UIUtil.checkItem(_arg_1.item.id, 1))
            {
                ActionFactory.getInstance().getColonyCommands().speedUpAbandonColony(Context.getInstance().getCurCastle().id, targetBean.castleId, _arg_1.item.id, onAbondon);
            }
            else
            {
                AddFundWin.show();
            };
        }

        public function onShowEvent():void
        {
            if (this.initialized)
            {
                this.refresh();
            };
        }


    }
}//package view.module.office

