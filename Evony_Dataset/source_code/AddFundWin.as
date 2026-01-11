// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AddFundWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.Context;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    public class AddFundWin extends Canvas implements IBindingClient 
    {

        private static var instance:AddFundWin = new (AddFundWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AddFundWin_Label1:Label;
        public var _AddFundWin_TextArea1:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":520,
                    "height":300,
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
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":468,
                                "height":254,
                                "styleName":"msgboxbg",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.bottom = "50";
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___AddFundWin_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Yes, please",
                                                        "styleName":"y125"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___AddFundWin_Button2_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"No, thanks",
                                                        "styleName":"y125"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_AddFundWin_TextArea1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.fontWeight = "bold";
                                        this.top = "80";
                                        this.color = 5312268;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":320,
                                            "editable":false,
                                            "height":80,
                                            "styleName":"shuangbian"
                                        });
                                    }
                                })]
                            });
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
                                    "id":"_AddFundWin_Label1",
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
                        "type":Button,
                        "events":{"click":"___AddFundWin_Button3_click"},
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

        public function AddFundWin()
        {
            mx_internal::_document = this;
            this.width = 520;
            this.height = 300;
        }

        public static function gotoPurchasePage():void
        {
            if (EvonyClient.isTryUser)
            {
                AlertWinEx.show("Before you make a purchase, please save the game first.");
            }
            else
            {
                if ((((Context.getInstance().getPlayerBean().playerInfo.userId % 10) == 5) && ((Context.getInstance().getPlayerBean().playerInfo.userId % 100) < 50)))
                {
                    ExternalInterface.call("displayUP", GameConfig.instance.SID, Context.getInstance().userName, Context.getInstance().getPlayerBean().playerInfo.userId);
                }
                else
                {
                    navigateToURL(new URLRequest(((GameConfig.instance.addFund + "&user=") + Context.getInstance().userName)), "_blank");
                };
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AddFundWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
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
        }


        public function ___AddFundWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function _AddFundWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("元宝不够购买物品请充值");
            _local_1 = Lang.msg("系统提示");
        }

        private function _AddFundWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("元宝不够购买物品请充值");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddFundWin_TextArea1.text = _arg_1;
            }, "_AddFundWin_TextArea1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("系统提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddFundWin_Label1.text = _arg_1;
            }, "_AddFundWin_Label1.text");
            result[1] = binding;
            return (result);
        }

        private function rechargeHandle():void
        {
            gotoPurchasePage();
            close();
        }

        override public function initialize():void
        {
            var target:AddFundWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AddFundWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_AddFundWinWatcherSetupUtil");
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

        private function close():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___AddFundWin_Button1_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        public function ___AddFundWin_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }


    }
}//package view.ui

