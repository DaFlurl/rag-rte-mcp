// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.AwardWin

package view.module.guide
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.containers.Tile;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.common.module.quest.QuestRewardRespone;
    import com.evony.Context;
    import com.evony.data.FbData;
    import view.ui.FacebookNoticeWin;
    import com.evony.util.FbUtil;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.ItemBean;
    import view.module.playerInfo.AwardContainer;
    import flash.utils.setTimeout;
    import view.AllWindows;
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

    public class AwardWin extends Canvas implements IBindingClient 
    {

        private static var instance:AwardWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var questId:int;
        public var _AwardWin_Button1:Button;
        private var _1177154070itemHbox:Tile;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":260,
                    "width":430,
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
                            this.top = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"Award obtained",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"itemHbox",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 5;
                            this.horizontalGap = 10;
                            this.borderStyle = "none";
                            this.kerning = true;
                            this.left = "30";
                            this.top = "57";
                            this.right = "30";
                            this.bottom = "62";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"direction":"horizontal"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AwardWin_Button1",
                        "events":{"click":"___AwardWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "25";
                            this.left = "57";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Share with friends",
                                "styleName":"b135"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AwardWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "25";
                            this.right = "57";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Continue Tutorial",
                                "styleName":"b135"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AwardWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "42";
                            this.top = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _itemBeansArray:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(12);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AwardWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.height = 260;
            this.width = 430;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AwardWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:QuestRewardRespone, _arg_2:int):void
        {
            if (instance == null)
            {
                instance = new (AwardWin)();
            };
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.itemShow(_arg_1);
            instance.questId = _arg_2;
        }


        private function checkFB():void
        {
            var _local_1:Object;
            if (Context.getInstance().facebookUser)
            {
                _local_1 = FbData.getInstance().getValue(questId);
                if (_local_1 != null)
                {
                    FacebookNoticeWin.show(_local_1);
                };
            }
            else
            {
                FbUtil.getInstance().connectRequst();
            };
        }

        public function ___AwardWin_Button1_click(_arg_1:MouseEvent):void
        {
            checkFB();
        }

        public function ___AwardWin_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        public function ___AwardWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function _AwardWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().facebookUser);
            }, function (_arg_1:Boolean):void
            {
                _AwardWin_Button1.visible = _arg_1;
            }, "_AwardWin_Button1.visible");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:AwardWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AwardWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_guide_AwardWinWatcherSetupUtil");
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

        public function set itemHbox(_arg_1:Tile):void
        {
            var _local_2:Object = this._1177154070itemHbox;
            if (_local_2 !== _arg_1)
            {
                this._1177154070itemHbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemHbox", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemHbox():Tile
        {
            return (this._1177154070itemHbox);
        }

        private function itemShow(_arg_1:QuestRewardRespone):void
        {
            var _local_3:ItemBean;
            var _local_4:AwardContainer;
            this._itemBeansArray = _arg_1.itemBeansArray;
            this.uiCache.reset();
            this.itemHbox.removeAllChildren();
            var _local_2:int;
            while (_local_2 < this._itemBeansArray.length)
            {
                _local_3 = _arg_1.getItemBeans(_local_2);
                if (_local_3.count > 0)
                {
                    _local_4 = (this.uiCache.getUI(AwardContainer) as AwardContainer);
                    _local_4.itemBean = _local_3;
                    this.itemHbox.addChild(_local_4);
                };
                _local_2++;
            };
            setTimeout(onTimeOutClose, 5000);
        }

        private function onTimeOutClose():void
        {
            if (MinePopupManager.instance.curPopupObj == this)
            {
                close();
            };
        }

        private function close():void
        {
            MinePopupManager.instance.removePopup();
            if (AllWindows.instance.qusetWinVs == AllWindows.instance.currentWin)
            {
                AllWindows.instance.qusetWinVs.doTimeOutClose();
            };
        }

        private function _AwardWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Context.getInstance().facebookUser;
        }


    }
}//package view.module.guide

