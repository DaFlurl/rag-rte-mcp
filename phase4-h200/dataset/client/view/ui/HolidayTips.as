// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.HolidayTips

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.mx_internal;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import flash.display.Sprite;
    import com.evony.Lang;
    import com.evony.common.module.furlough.FurloughResponse;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.events.ReplayEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
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

    public class HolidayTips extends Canvas implements IBindingClient 
    {

        public static var instance:HolidayTips = new (HolidayTips)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _568190078btnCancelHoliday:Button;
        private var _286715625g_Hours:Number = 0;
        private var _25846365lblTime:Label;
        public var _HolidayTips_Text2:Text;
        private var _815514292btnReturnMainPage:Button;
        private var _878694782txtNote:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":560,
                    "height":287,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "events":{"complete":"___HolidayTips_Image1_complete"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "source":"images/EmbedImages/common/daymessage/ClewBg.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"btnCancelHoliday",
                        "events":{"click":"__btnCancelHoliday_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":210,
                                "y":206,
                                "height":30,
                                "styleName":"y165"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"btnReturnMainPage",
                        "events":{"click":"__btnReturnMainPage_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":385,
                                "y":206,
                                "height":30,
                                "styleName":"y125"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"txtNote",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":241,
                                "y":128,
                                "width":258,
                                "height":70
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"_HolidayTips_Text2",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":241,
                                "y":69,
                                "width":258,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"lblTime",
                        "stylesFactory":function ():void
                        {
                            this.fontSize = 16;
                            this.fontWeight = "bold";
                            this.color = 9843523;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":241,
                                "y":91,
                                "width":258,
                                "height":36
                            });
                        }
                    })]
                });
            }
        });
        private var _2095520559playerInfo:PlayerInfoBean = new PlayerInfoBean();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HolidayTips()
        {
            mx_internal::_document = this;
            this.width = 560;
            this.height = 287;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HolidayTips._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Sprite):void
        {
            if (Context.getInstance().getPlayerBean() != null)
            {
                instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            };
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, _arg_1, true);
                PopUpManager.centerPopUp(instance);
            };
            instance.reFresh();
        }


        private function onCancelHolidayResponse(_arg_1:FurloughResponse):void
        {
            if (_arg_1.ok == 1)
            {
                AlertWin.show(Lang.msg("取消休假成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
            onClose();
        }

        internal function onBtnCancelHoliday():void
        {
            ActionFactory.getInstance().getFurloughCommands().cancelFurlought(playerInfo.id, onCancelHolidayResponse);
        }

        [Bindable(event="propertyChange")]
        public function get btnCancelHoliday():Button
        {
            return (this._568190078btnCancelHoliday);
        }

        private function _HolidayTips_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("取消休假");
            _local_1 = Lang.msg("返回首页");
            _local_1 = Lang.msg("休假状态中登录游戏时的提示文字");
            _local_1 = Lang.msg("休假剩余时间");
        }

        public function set btnCancelHoliday(_arg_1:Button):void
        {
            var _local_2:Object = this._568190078btnCancelHoliday;
            if (_local_2 !== _arg_1)
            {
                this._568190078btnCancelHoliday = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnCancelHoliday", _local_2, _arg_1));
            };
        }

        public function set lblTime(_arg_1:Label):void
        {
            var _local_2:Object = this._25846365lblTime;
            if (_local_2 !== _arg_1)
            {
                this._25846365lblTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lblTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get txtNote():Text
        {
            return (this._878694782txtNote);
        }

        public function set txtNote(_arg_1:Text):void
        {
            var _local_2:Object = this._878694782txtNote;
            if (_local_2 !== _arg_1)
            {
                this._878694782txtNote = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtNote", _local_2, _arg_1));
            };
        }

        internal function onBtnReturnMainPage():void
        {
            ResponseDispatcher.getInstance().dispatchEvent(new ReplayEvent(ReplayEvent.REPLAYGAME));
            onClose();
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function setRemainTime(_arg_1:Number, _arg_2:Number, _arg_3:Number):void
        {
            var _local_4:String = Lang.msg("{0}小时{1}分", _arg_1, _arg_2);
            this.lblTime.text = _local_4;
            g_Hours = _arg_3;
            if (g_Hours > (24 * 60))
            {
                g_Hours = (24 * 60);
            };
            if (g_Hours < 0)
            {
                g_Hours = (24 * 60);
            };
        }

        public function __btnReturnMainPage_click(_arg_1:MouseEvent):void
        {
            onBtnReturnMainPage();
        }

        private function _HolidayTips_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消休假");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnCancelHoliday.label = _arg_1;
            }, "btnCancelHoliday.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回首页");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnReturnMainPage.label = _arg_1;
            }, "btnReturnMainPage.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("休假状态中登录游戏时的提示文字");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                txtNote.text = _arg_1;
            }, "txtNote.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("休假剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HolidayTips_Text2.text = _arg_1;
            }, "_HolidayTips_Text2.text");
            result[3] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get lblTime():Label
        {
            return (this._25846365lblTime);
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

        [Bindable(event="propertyChange")]
        public function get g_Hours():Number
        {
            return (this._286715625g_Hours);
        }

        public function __btnCancelHoliday_click(_arg_1:MouseEvent):void
        {
            onBtnCancelHoliday();
        }

        public function set btnReturnMainPage(_arg_1:Button):void
        {
            var _local_2:Object = this._815514292btnReturnMainPage;
            if (_local_2 !== _arg_1)
            {
                this._815514292btnReturnMainPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnReturnMainPage", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:HolidayTips;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HolidayTips_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_HolidayTipsWatcherSetupUtil");
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

        public function ___HolidayTips_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get btnReturnMainPage():Button
        {
            return (this._815514292btnReturnMainPage);
        }

        private function reFresh():void
        {
            if (Context.getInstance().getPlayerBean() != null)
            {
                instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            };
        }

        public function set g_Hours(_arg_1:Number):void
        {
            var _local_2:Object = this._286715625g_Hours;
            if (_local_2 !== _arg_1)
            {
                this._286715625g_Hours = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "g_Hours", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }


    }
}//package view.ui

