// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ReportPlayerWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class ReportPlayerWin extends Canvas implements IBindingClient 
    {

        public static var instance:ReportPlayerWin = new (ReportPlayerWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1633005180reportPlayerContent:TextArea;
        public var _ReportPlayerWin_Button1:Button;
        public var _ReportPlayerWin_Button2:Button;
        public var _ReportPlayerWin_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":325,
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
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ReportPlayerWin_Label1",
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
                        "type":TextArea,
                        "id":"reportPlayerContent",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "57";
                            this.left = "30";
                            this.right = "30";
                            this.bottom = "52";
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_ReportPlayerWin_Button1",
                        "events":{"click":"___ReportPlayerWin_Button1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "width":75,
                                "x":123,
                                "y":281
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_ReportPlayerWin_Button2",
                        "events":{"click":"___ReportPlayerWin_Button2_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "width":75,
                                "x":248,
                                "y":281
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ReportPlayerWin_Button3_click"},
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
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ReportPlayerWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 1;
            };
            this.width = 440;
            this.height = 325;
            this.addEventListener("creationComplete", ___ReportPlayerWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ReportPlayerWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
            };
        }


        [Bindable(event="propertyChange")]
        public function get reportPlayerContent():TextArea
        {
            return (this._1633005180reportPlayerContent);
        }

        public function set reportPlayerContent(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1633005180reportPlayerContent;
            if (_local_2 !== _arg_1)
            {
                this._1633005180reportPlayerContent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportPlayerContent", _local_2, _arg_1));
            };
        }

        public function ___ReportPlayerWin_Button1_click(_arg_1:MouseEvent):void
        {
            onReportPalyerMail();
        }

        public function ___ReportPlayerWin_Button2_click(_arg_1:MouseEvent):void
        {
            cancelHandel();
        }

        public function ___ReportPlayerWin_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function onReportPalyerMail():void
        {
            if (this.reportPlayerContent.text == "")
            {
                AlertWin.show(Lang.msg("邮件内容不能为空"));
                return;
            };
            ActionFactory.getInstance().getMailCommands().reportPlayer(("In game Spam report " + Context.getInstance().getPlayerBean().playerInfo.userName), this.reportPlayerContent.text, onSendMail);
        }

        override public function initialize():void
        {
            var target:ReportPlayerWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ReportPlayerWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ReportPlayerWinWatcherSetupUtil");
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

        private function _ReportPlayerWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请输入举报内容");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ReportPlayerWin_Label1.text = _arg_1;
            }, "_ReportPlayerWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ReportPlayerWin_Button1.label = _arg_1;
            }, "_ReportPlayerWin_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ReportPlayerWin_Button2.label = _arg_1;
            }, "_ReportPlayerWin_Button2.label");
            result[2] = binding;
            return (result);
        }

        private function onSendMail(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("发送成功"));
                this.reportPlayerContent.text = "";
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function _ReportPlayerWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("请输入举报内容");
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("取消");
        }

        public function init():void
        {
        }

        public function ___ReportPlayerWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function cancelHandel():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.ui

